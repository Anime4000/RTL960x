<!-- Created by Anime4000 @ RTL960x Community for xPON ONU SFP Stick -->
<!doctype html>
<html>
	<head>
		<meta charset="utf-8">
		<meta name="viewport" content="width=device-width, initial-scale=1">
		<title><% multilang("47" "LANG_OMCI_INFO"); %></title>	
		<link href="style/bootstrap.min.css" rel="stylesheet">
		<script type="text/javascript" src="share.js"></script>
		<script type="text/javascript">
var omci_tm_opt_value = <% getInfo("omci_tm_opt"); %>;
var omcc_ver_value = <% getInfo("omcc_ver"); %>;
var omci_olt_mode_value = <% fmOmciInfo_checkWrite("omci_olt_mode"); %>;

function applyclick() {
	if (document.formOmciInfo.omci_sw_ver1.value=="") {
		alert('<% multilang("2455" "LANG_OMCI_SW_VER1_CANNOT_BE_EMPTY"); %>');
		document.formOmciInfo.omci_sw_ver1.focus();
		return false;
	}
	if (document.formOmciInfo.omci_sw_ver2.value=="") {
		alert('<% multilang("2456" "LANG_OMCI_SW_VER2_CANNOT_BE_EMPTY"); %>');
		document.formOmciInfo.omci_sw_ver2.focus();
		return false;
	}
	if (document.formOmciInfo.cwmp_productclass.value=="") {
		alert('<% multilang("2457" "LANG_OMCI_EQID_CANNOT_BE_EMPTY"); %>');
		document.formOmciInfo.cwmp_productclass.focus();
		return false;
	}
	if (document.formOmciInfo.cwmp_hw_ver.value=="") {
		alert('<% multilang("2458" "LANG_OMCI_ONT_VER_CANNOT_BE_EMPTY"); %>');
		document.formOmciInfo.cwmp_hw_ver.focus();
		return false;
	}

	return true;
}

function on_change() {
	with (document.forms[0]) {
		if(omci_olt_mode_value == 0) {
			omci_tm_opt.value = omci_tm_opt_value;
			omcc_ver.value = omcc_ver_value;
		}
	}
}

function on_init() {
	with (document.forms[0]) {
		omci_tm_opt.value = omci_tm_opt_value;
		omcc_ver.value = omcc_ver_value;
		omci_olt_mode.value = omci_olt_mode_value;
	}
}
		</script>
	</head>
	<body style="background-color: transparent;" onLoad="on_init();">
		<div class="col-lg-8 mx-auto p-3 py-md-5">
			<h2 class="mt-4"><% multilang("47" "LANG_OMCI_INFO"); %></h2>
			<header class="d-flex align-items-center pb-3 mb-5 border-bottom">
				This page allow you to change OMCI device information to allow OLT authenticate your xPON ONU Stick SFP
			</header>

			<form action="/boaform/admin/formOmciInfo" method="post" name="formOmciInfo">
				<div class="form-group row">
					<label class="col-sm-4 col-form-label"><% multilang("59" "LANG_OMCI_VENDOR_ID"); %></label>
					<div class="col-sm-8">
						<input type="text" class="form-control font-monospace" id="omci_vendor_id" name="omci_vendor_id" value="<% getInfo("omci_vendor_id"); %>">
						<small class="form-text text-dark">Brand Id, example for Huawei: <code class="text-primary">HWTC</code></small>
					</div>
				</div>
<br />
				<div class="form-group row">
					<label class="col-sm-4 col-form-label"><% multilang("53" "LANG_OMCI_SW_VER1"); %></label>
					<div class="col-sm-8">
						<input type="text" class="form-control font-monospace" id="omci_sw_ver1" name="omci_sw_ver1" value="<% getInfo("omci_sw_ver1"); %>">
						<small class="form-text text-dark">Software Version 1, example for Huawei HG8240H5: <code class="text-primary">V5R019C00S125</code></small>
					</div>
				</div>
<br />
				<div class="form-group row">
					<label class="col-sm-4 col-form-label"><% multilang("54" "LANG_OMCI_SW_VER2"); %></label>
					<div class="col-sm-8">
						<input type="text" class="form-control font-monospace" id="omci_sw_ver2" name="omci_sw_ver2" value="<% getInfo("omci_sw_ver2"); %>">
						<small class="form-text text-dark">Software Version 2, example for Huawei HG8240H5: <code class="text-primary">V5R019C00S125</code></small>
					</div>
				</div>
<br />
				<div class="form-group row">
					<label class="col-sm-4 col-form-label"><% multilang("58" "LANG_OMCI_ONT_VER"); %></label>
					<div class="col-sm-8">
						<input type="text" class="form-control font-monospace" id="cwmp_hw_ver" name="cwmp_hw_ver" value="<% getInfo("cwmp_hw_ver"); %>">
						<small class="form-text text-dark">Hardware Version, example for Huawei HG8240H5: <code class="text-primary">168D.A</code></small>
					</div>
				</div>
<br />
				<div class="form-group row">
					<label class="col-sm-4 col-form-label"><% multilang("57" "LANG_OMCI_EQID"); %></label>
					<div class="col-sm-8">
						<input type="text" class="form-control font-monospace" id="cwmp_productclass" name="cwmp_productclass" value="<% getInfo("cwmp_productclass"); %>">
						<small class="form-text text-dark">TR-069 Product Class, <code class="text-primary">IGD</code> or <code class="text-primary">SFU</code> is the most common value for Universal ONU</small>
					</div>
				</div>
<br />
				<div class="form-group row">
					<label class="col-sm-4 col-form-label"><% multilang("55" "LANG_OMCC_VER"); %></label>
					<div class="col-sm-8">
						<select class="form-select" id="omcc_ver" name="omcc_ver" onChange="on_change()">
							<option value="128" >0x80</option>
							<option value="129" >0x81</option>
							<option value="130" >0x82</option>
							<option value="131" >0x83</option>
							<option value="132" >0x84</option>
							<option value="133" >0x85</option>
							<option value="134" >0x86</option>
							<option value="150" >0x96</option>
							<option value="160" >0xA0</option>
							<option value="161" >0xA1</option>
							<option value="162" >0xA2</option>
							<option value="163" >0xA3</option>
							<option value="176" >0xB0</option>
							<option value="177" >0xB1</option>
							<option value="178" >0xB2</option>
							<option value="179" >0xB3</option>
						</select>
						<small class="form-text text-dark">OMCI Version, <code class="text-primary">0x80</code> is the most common value for Universal ONU</small>
					</div>
				</div>
<br />
				<div class="form-group row">
					<label class="col-sm-4 col-form-label"><% multilang("56" "LANG_OMCI_TM_OPT"); %></label>
					<div class="col-sm-8">
						<select class="form-select" id="omci_tm_opt" name="omci_tm_opt" onChange="on_change()">
							<option value="0" >0</option>
							<option value="1" >1</option>
							<option value="2" >2</option>
						</select>
						<small class="form-text text-dark">Traffic Management, <code class="text-primary">2</code> is the most common value for Universal ONU</small>
					</div>
				</div>
<br />
				<div class="form-group row">
					<label class="col-sm-4 col-form-label">Compatibility Mode:</label>
					<div class="col-sm-8">
						<select class="form-select" id="omci_olt_mode" name="omci_olt_mode" >
							<option value="0">Default Mode</option>
							<option value="1">Huawei OLT Mode</option>
							<option value="2">ZTE OLT Mode</option>
							<option value="3">Customized Mode</option>
						</select>
						<small class="form-text text-dark">ONU Compatibility, <code class="text-primary">Huawei</code> is the most common value for Universal ONU</small>
					</div>
				</div>
<br />
				<div class="col text-center">
					<input type="submit" class="btn btn-primary" name="apply" onClick="return applyclick()" value="<% multilang("136" "LANG_APPLY_CHANGES"); %>">
					<input type="hidden" value="/omci_info.asp" name="submit-url">
				</div>
			</form>
		</div>
		<script type="text/javascript" src="bootstrap.bundle.min.js"></script>
		<script type="text/javascript">
			document.getElementById('omcc_ver').value = <% getInfo("omcc_ver"); %>;
			document.getElementById('omci_tm_opt').value = <% getInfo("omci_tm_opt"); %>;
			document.getElementById('omci_olt_mode').value = <% fmOmciInfo_checkWrite("omci_olt_mode"); %>;
		</script>
	</body>
</html>