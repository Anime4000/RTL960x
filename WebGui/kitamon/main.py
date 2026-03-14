from flask import Flask, jsonify, request, Response
import requests
from bs4 import BeautifulSoup
import re
import math
import time


CACHE_TTL = 10
cache_data = None
cache_time = 0


TARGET_URL = "http://192.168.1.1/admin/login.asp"
OMCI_URL = "http://192.168.1.1/admin/graphics/topbar.gif"

app = Flask(__name__)


def sanitize_key(text):
	text = text.strip().lower()
	text = re.sub(r"[^a-z0-9]+", "_", text)
	return text.strip("_")


def parse_numeric(value):
	if value is None:
		return None

	m = re.search(r"-?\d+(?:\.\d+)?", str(value))
	if not m:
		return None

	try:
		return float(m.group(0))
	except ValueError:
		return None


def uptime_parts(uptime):
	"""
	Convert uptime formats into (hour, minute)

	Supported:
	- 'h:mm'
	- 'X min'
	"""

	if not uptime:
		return None, None

	uptime = uptime.strip().lower()

	# format: "2 min"
	m = re.match(r"(\d+)\s*min", uptime)
	if m:
		minute = int(m.group(1))
		return minute // 60, minute % 60

	# format: "h:mm"
	m = re.match(r"(\d+):(\d+)", uptime)
	if m:
		hour = int(m.group(1))
		minute = int(m.group(2))
		return hour, minute

	return None, None


def fetch_omci():
	r = requests.get(OMCI_URL, timeout=5)
	r.raise_for_status()

	soup = BeautifulSoup(r.text, "html.parser")

	result = {
		"OltVendorId": None,
		"EntityID": None
	}

	# ---- OLT Vendor ----
	me131 = soup.find(id="me131")
	if me131:
		for row in me131.find_all("tr"):
			cols = row.find_all("td")
			if len(cols) >= 2:
				key = cols[0].get_text(strip=True)
				val = cols[1].get_text(strip=True)
				if key == "OltVendorId":
					result["OltVendorId"] = val

	# ---- EntityID detection ----
	me84 = soup.find(id="me84")
	if me84:
		for row in me84.find_all("tr")[1:]:
			cols = row.find_all("td")
			if len(cols) >= 1:
				entity = cols[0].get_text(strip=True)
				if entity and entity != "-":
					result["EntityID"] = entity
					break

	return result


def get_data():
	global cache_data, cache_time

	now = time.time()

	if cache_data and (now - cache_time) < CACHE_TTL:
		return cache_data

	data = fetch_table()

	cache_data = data
	cache_time = now

	return data


def fetch_table():
	r = requests.get(TARGET_URL, timeout=5)
	r.raise_for_status()

	soup = BeautifulSoup(r.text, "html.parser")
	table = soup.find("table", {"id": "api"})
	if table is None:
		raise RuntimeError("table id='api' not found")

	data = {}

	for row in table.find_all("tr"):
		cols = row.find_all("td")
		if len(cols) < 2:
			continue

		key = cols[0].get_text(" ", strip=True)
		val = cols[1].get_text(" ", strip=True)

		if key.lower() == "up time":          
			val = f"{val}"

		if key:
			data[key] = val

	# merge OMCI info
	try:
		omci = fetch_omci()
		data.update({k: v for k, v in omci.items() if v is not None})
	except Exception:
		pass

	return data


def calculate_los(data):
	rx_power = parse_numeric(data.get("Rx Power"))
	onu_state = (data.get("ONU State") or "").strip().upper()

	entity_id = (data.get("EntityID") or "").strip()
	omci = entity_id not in ("", "-")

	result = {
		"code": None,
		"status": "Unknown",
		"description": "Unable to determine link status",
		"rx_power_dbm": rx_power,
		"onu_state": onu_state,
		"omci": omci
	}

	if rx_power is None:
		result["description"] = "RX power reading unavailable"
		return result

	# ---- Weak signal ----
	if rx_power <= -28:
		if onu_state == "O3":
			result["code"] = 6
			result["status"] = "ONT_LOS_AUTH_FAIL"
			result["description"] = "Signal too weak during authentication stage. Check fiber, connectors, or splitter loss."

		elif onu_state != "O5":
			result["code"] = 5
			result["status"] = "ONT_LOS"
			result["description"] = "Optical signal is too weak. ONU cannot establish link with OLT."

		else:  # O5
			if omci:
				result["code"] = 1
				result["status"] = "OLT_ALLOW_LOW_SIGNAL"
				result["description"] = "Signal is below recommended level but OLT still allows service. Fiber quality may be degrading."

			else:
				result["code"] = 2
				result["status"] = "OLT_REJECT_LOW_SIGNAL"
				result["description"] = "OLT rejected ONU due to weak optical signal. Check fiber attenuation and splitter path."

	# ---- Normal signal ----
	else:
		if onu_state == "O5":
			if omci:
				result["code"] = 0
				result["status"] = "OLT_AUTH_OK"
				result["description"] = "ONU authenticated successfully and OMCI configuration is active."

			else:
				result["code"] = 3
				result["status"] = "OLT_FAKE_O5"
				result["description"] = "OLT is not providing OMCI/VLAN configuration. Check GPON serial number or PLOAM authentication."

		else:
			result["code"] = 4
			result["status"] = "OLT_AUTH_FAIL"
			result["description"] = "Optical signal is normal but authentication failed. Verify ONU serial number or PLOAM credentials."

	return result


def build_raw(data):
	out = dict(data)
	los = calculate_los(data)
	out["LoS Description"] = los["description"]
	out["LoS Indicator"] = los["status"]
	out["LoS Code"] = los["code"]
	return out


def prometheus_escape_label(value):
	return str(value).replace("\\", "\\\\").replace('"', '\\"').replace("\n", "\\n")


def build_prometheus(data):
	lines = []
	identity_labels = {}
	status_labels = {}

	NUMERIC_METRICS = {
		"cpu",
		"memory",
		"temperature",
		"voltage",
		"bias_current",
		"tx_power",
		"rx_power"
	}

	for k, v in data.items():
		metric = sanitize_key(k)

		if metric == "up_time":
			continue

		if metric in NUMERIC_METRICS:
			num = parse_numeric(v)
			if num is not None and math.isfinite(num):
				lines.append(f"onu_{metric} {num}")
			continue

		# identity fields
		if metric in ("gpon_sn", "onu_id", "onu_state", "loid_status", "oltvendorid", "entityid"):
			identity_labels[metric] = v

	uptime = data.get("Up time")
	if uptime:
		h, m = uptime_parts(uptime)
		if h is not None:
			s = h * 3600 + m * 60
			lines.append(f"onu_up_time_seconds {s}")
			lines.append(f"onu_up_time_hour {h}")
			lines.append(f"onu_up_time_minute {m}")

	los = calculate_los(data)
	if los["code"] is not None:
		lines.append(f"onu_los_code {los['code']}")
		status_labels["los_indicator"] = los["status"]
		status_labels["los_description"] = los["description"]

	info_labels = {**identity_labels, **status_labels}

	if info_labels:
		label_string = ",".join(
			f'{sanitize_key(k)}="{prometheus_escape_label(v)}"'
			for k, v in info_labels.items()
		)
		lines.append(f"onu_info{{{label_string}}} 1")

	return "\n".join(lines) + "\n"



def banner():
	print("")
	print("========================================")
	print("  Kita Monitor GPON Telemetry Exporter")
	print("========================================")
	print("  Author : Anime4000")
	print("  Port   : 4000")
	print("  API    : /?prometheus")
	print("")
	print("NOTE: This tool is designed for Nijika Firmware on compatible RTL960x ONUs.")
	print("      Functionality on other models or firmware versions is not guaranteed.")
	print("")


@app.route("/")
def api():
	data = get_data()

	if "prometheus" in request.args:
		return Response(build_prometheus(data), mimetype="text/plain; version=0.0.4")

	return jsonify(build_raw(data))


if __name__ == "__main__":
	banner()
	app.run(host="0.0.0.0", port=4000)