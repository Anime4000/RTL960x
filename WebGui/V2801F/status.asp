<!-- Created by Anime4000 @ RTL960x Community for xPON ONU SFP Stick -->
<!doctype html>
<html lang="en">
	<head>
		<meta charset="utf-8">
		<meta http-equiv=refresh content="30; url=status.asp">
		<meta name="viewport" content="width=device-width, initial-scale=1">
		<title><% multilang("68" "LANG_DEVICE_STATUS"); %></title>	
		<link href="style/bootstrap.min.css" rel="stylesheet">
	</head>
	<body style="background-color: transparent;">
		<div class="col-lg-8 mx-auto p-3 py-md-5">
			<h2 class="mt-4"><% multilang("68" "LANG_DEVICE_STATUS"); %></h2>
			<header class="d-flex align-items-center pb-3 mb-5 border-bottom">
				<p><% multilang("69" "LANG_PAGE_DESC_DEVICE_STATUS_SETTING"); %></p>
			</header>

			<table class="table table-hover">
				<thead class="thead-dark">
					<tr>
						<th scope="col" colspan="2"><% multilang("70" "LANG_SYSTEM"); %></td>
					</tr>
				</thead>
				<tbody>
					<tr>
						<td ><% multilang("95" "LANG_DEVICE_NAME"); %></td>
						<td><% getInfo("name"); %></td>
					</tr>
					<tr>
						<td><% multilang("72" "LANG_UPTIME"); %></td>
						<td><% getInfo("uptime"); %></td>
					</tr>
					<tr>
						<td><% multilang("75" "LANG_FIRMWARE_VERSION"); %></td>
						<td><% getInfo("fwVersion"); %></td>
					</tr>
					<tr>
						<td>CPU Usage</td>
						<td><% getInfo("cpu_util"); %></td>
					</tr>
					<tr>
						<td>Memory Usage</th>
						<td><% getInfo("mem_util"); %></td>
					</tr>
				</tbody>
			</table>

			<table class="table table-hover">
				<thead class="thead-dark">
					<tr>
						<th scope="col" colspan="2"><% multilang("6" "LANG_LAN"); %> <% multilang("216" "LANG_CONFIGURATION"); %></th>
					</tr>
				</thead>
				<tbody>
					<tr>
						<td ><% multilang("85" "LANG_IP_ADDRESS"); %></td>
						<td><% getInfo("lan-ip"); %></td>
					</tr>
					<tr>
						<td><% multilang("86" "LANG_SUBNET_MASK"); %></td>
						<td><% getInfo("lan-subnet"); %></td>
					</tr>
					<tr>
						<td><% multilang("88" "LANG_MAC_ADDRESS"); %></td>
						<td><% getInfo("elan-Mac"); %></td>
					</tr>
				</tbody>
			</table>

		</div>
		<script type="text/javascript" src="bootstrap.bundle.min.js"></script>
	</body>
</html>