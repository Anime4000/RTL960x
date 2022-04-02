<!-- Created by Anime4000 @ RTL960x Community for xPON ONU SFP Stick -->
<!doctype html>
<html>
	<head>
		<meta charset="utf-8">
		<meta name="viewport" content="width=device-width, initial-scale=1">
		<title><% multilang("1127" "LANG_EPON_SETTINGS"); %></title>	
		<link href="style/bootstrap.min.css" rel="stylesheet">
        <script type="text/javascript" src="share.js">
<script>
function applyclick() {
    var mac_addr = document.formepon_llid_mac_mapping.elements["mac_addr[]"];

    for(var i=0; i<mac_addr.length; i++) {
        if ((mac_addr[i].value=="") || (!mac_addr[i].value.contains(":")) || (mac_addr[i].value.length!=17)) {
            alert('<% multilang("2094" "LANG_INVALID_MAC_ADDRESS"); %>');
            mac_addr[i].focus();
            return false;
        }
    }
    return true;
}
</script>

	</head>
	<body style="background-color: transparent;">
		<div class="col-lg-8 mx-auto p-3 py-md-5">
			<h2 class="mt-4"><% multilang("1127" "LANG_EPON_SETTINGS"); %></h2>
			<header class="d-flex align-items-center pb-3 mb-5 border-bottom">
				<% multilang("1128" "LANG_THIS_PAGE_IS_USED_TO_CONFIGURE_THE_PARAMETERS_FOR_EPON_NETWORK_ACCESS"); %>
			</header>

			<form action="/boaform/admin/formeponConf" method="post" name="formeponconf">
				<div class="form-group row">
					<div class="col-sm-3">
                        <% multilang("473" "LANG_LOID"); %>
					</div>
					<div class="col-sm-9">
                        <input type="text" class="form-control" name="fmepon_loid" size="24" maxlength="24" value="<% fmepon_checkWrite("fmepon_loid"); %>">
					</div>
				</div>
<br />
				<div class="form-group row">
					<div class="col-sm-3">
                        <% multilang("474" "LANG_LOID_PASSWORD"); %>
					</div>
					<div class="col-sm-9">
                        <input type="text" class="form-control" name="fmepon_loid_password" size="12" maxlength="12" value="<% fmepon_checkWrite("fmepon_loid_password"); %>">
					</div>
				</div>
<br />
				<div class="form-group row">
					<div class="col-sm-3">
                        <input type="submit" class="btn btn-primary" name="fmepon_loid_password" size="12" maxlength="12" value="<% multilang("136" "LANG_APPLY_CHANGES"); %>">
					</div>
				</div>

                <input type="hidden" value="/epon.asp" name="submit-url">
			</form>

			<h2 class="mt-4"><% multilang("1129" "LANG_LLID_MAC_MAPPING_TABLE"); %></h2>
			<header class="d-flex align-items-center pb-3 mb-5 border-bottom">
			</header>

            <form action="/boaform/admin/formepon_llid_mac_mapping" method="post" name="formepon_llid_mac_mapping">
				<table class="table table-hover" cellspacing="4" cellpadding="0">
					<% showepon_LLID_MAC(); %>
				</table>
<br />
				<div class="form-group row">
					<div class="col-sm-3">
                        <input type="submit" class="btn btn-primary" name="apply" onClick="return applyclick()" value="<% multilang("136" "LANG_APPLY_CHANGES"); %>">
					</div>
				</div>

                <input type="hidden" value="/epon.asp" name="submit-url">
            </form>
		</div>
		<script type="text/javascript" src="bootstrap.bundle.min.js"></script>
	</body>
</html>