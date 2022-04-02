<!-- Created by Anime4000 @ RTL960x Community for xPON ONU SFP Stick -->
<!doctype html>
<html>
	<head>
		<meta charset="utf-8">
		<meta name="viewport" content="width=device-width, initial-scale=1">
		<title><% multilang("46" "LANG_GPON_SETTINGS"); %></title>	
		<link href="style/bootstrap.min.css" rel="stylesheet">
		<script type="text/javascript" src="share.js"></script>
		<script type="text/javascript">

function applyclick()
{
	/* LOID */
	if (document.formgponconf.fmgpon_loid.value=="") {
		alert('<% multilang("2154" "LANG_LOID_CANNOT_BE_EMPTY"); %>');
		document.formgponconf.fmgpon_loid.focus();
		return false;
	}

	/* LOID Password */
		if (document.formgponconf.fmgpon_loid_password.value=="") {
		alert('<% multilang("2155" "LANG_LOID_PASSWORD_CANNOT_BE_EMPTY"); %>');
		document.formgponconf.fmgpon_loid_password.focus();
		return false;
	}
	if (includeSpace(document.formgponconf.fmgpon_loid_password.value)) {
		alert('<% multilang("2156" "LANG_CANNOT_ACCEPT_SPACE_CHARACTER_IN_LOID_PASSWORD"); %>');
		document.formgponconf.fmgpon_loid_password.focus();
		return false;
	}
	if (checkString(document.formgponconf.fmgpon_loid_password.value) == 0) {
		alert('<% multilang("2157" "LANG_INVALID_LOID_PASSWORD"); %>');
		document.formgponconf.fmgpon_loid_password.focus();
		return false;
	}

	/* PLOAM Password */
	if (document.formgponconf.fmgpon_ploam_password.value=="") {
		alert('<% multilang("2158" "LANG_PLOAM_PASSWORD_CANNOT_BE_EMPTY"); %>');
		document.formgponconf.fmgpon_ploam_password.focus();
		return false;
	}
	if (includeSpace(document.formgponconf.fmgpon_ploam_password.value)) {
		alert('<% multilang("2159" "LANG_CANNOT_ACCEPT_SPACE_CHARACTER_IN_PLOAM_PASSWORD"); %>');
		document.formgponconf.fmgpon_ploam_password.focus();
		return false;
	}
	if (document.formgponconf.fmgpon_ploam_password.value.length<=10 && checkString(document.formgponconf.fmgpon_ploam_password.value) == 0) {
		alert('<% multilang("2160" "LANG_INVALID_PLOAM_PASSWORD"); %>');
		document.formgponconf.fmgpon_ploam_password.focus();
		return false;
	}

	if( document.formgponconf.fmgpon_ploam_password.value.length>10 && document.formgponconf.fmgpon_ploam_password.value.length != 20) {
		alert('<% multilang("2161" "LANG_PLOAM_PASSWORD_SHOULD_BE_10_CHARACTERS"); %>');
		document.formgponconf.fmgpon_ploam_password.focus();
		return false;
	}

	if (document.formgponconf.fmgpon_ploam_password.value.length == 20 && checkHex(document.formgponconf.fmgpon_ploam_password.value) == 0) {
		alert('<% multilang("2160" "LANG_INVALID_PLOAM_PASSWORD"); %>');
		document.formgponconf.fmgpon_ploam_password.focus();
		return false;
	}

	return true;
}
		</script>
	</head>
	<body style="background-color: transparent;">
		<div class="col-lg-8 mx-auto p-3 py-md-5">
			<h2 class="mt-4"><% multilang("46" "LANG_GPON_SETTINGS"); %></h2>
			<header class="d-flex align-items-center pb-3 mb-5 border-bottom">
				<% multilang("472" "LANG_THIS_PAGE_IS_USED_TO_CONFIGURE_THE_PARAMETERS_FOR_YOUR_GPON_NETWORK_ACCESS"); %>
			</header>

			<form action="/boaform/admin/formgponConf" method="post" name="formgponconf">
				<div class="form-group row">
					<div class="col-sm-3 col-form-label">
						<label><% multilang("475" "LANG_PLOAM_PASSWORD"); %></label>
					</div>
					<div class="col-sm-9">
						<input type="text" class="form-control" id="fmgpon_ploam_password" name="fmgpon_ploam_password" value="<% fmgpon_checkWrite("fmgpon_ploam_password"); %>">
					</div>
				</div>
<br />
				<div class="form-group row">
					<label class="col-sm-3 col-form-label"><% multilang("476" "LANG_SERIAL_NUMBER"); %></label>
					<div class="col-sm-9">
						<input type="text" class="form-control" id="fmgpon_sn" name="fmgpon_sn" value="<% fmgpon_checkWrite("fmgpon_sn"); %>">
					</div>
				</div>
<br />
				<div class="col text-center">
					<input type="submit" class="btn btn-primary col-sm-3" name="apply" onClick="return applyclick()" value="<% multilang("136" "LANG_APPLY_CHANGES"); %>">
					<input type="hidden" value="/gpon.asp" name="submit-url">
				</div>
			</form>

		</div>
		<script type="text/javascript" src="bootstrap.bundle.min.js"></script>
	</body>
</html>