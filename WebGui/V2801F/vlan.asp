<!-- Created by Anime4000 @ RTL960x Community for xPON ONU SFP Stick -->
<!doctype html>
<html>
	<head>
		<meta charset="utf-8">
		<meta name="viewport" content="width=device-width, initial-scale=1">
		<title><% multilang("1023" "LANG_VLAN_SETTINGS"); %></title>	
		<link href="style/bootstrap.min.css" rel="stylesheet">
		<script type="text/javascript" src="share.js"></script>
		<script type="text/javascript">
function vlan_cfg_type_change() {
	with (document.forms[0])
	{
		if (vlan_cfg_type[0].checked ==	true) {
			disableRadioGroup(vlan_manu_mode);
			disableTextField(vlan_manu_tag_vid);
		}
		else {
			enableRadioGroup(vlan_manu_mode);
			vlan_manu_mode_change();
		}
	}
}
function vlan_manu_mode_change() {
	with	(document.forms[0])
	{
		if(vlan_manu_mode[1].checked ==	true) {
			enableTextField(vlan_manu_tag_vid);
		}
		else{
			disableTextField(vlan_manu_tag_vid);
		}
	}
}
function on_init() {
	with (document.forms[0])
	{
		if(vlan_cfg_type[0].checked	==	true)
			refresh.disabled = false;
		else
			refresh.disabled = true;

	}
	vlan_cfg_type_change();

}
function saveChanges() {
	with (document.forms[0])
	{
		if	(vlan_cfg_type[1].checked == true)	{
			if(vlan_manu_mode[1].checked == true) {
				if(vlan_manu_tag_vid.value == "") {
					alert("<%	multilang("2374" "LANG_VID_CANNOT_BE_EMPTY"); %>");
					vlan_manu_tag_vid.focus();
					return	false;
				}
			}
		}
	}

	return true;
}
		</script>
	</head>
	<body style="background-color: transparent;" onLoad="on_init()">
		<div class="col-lg-8 mx-auto p-3 py-md-5">
			<h2 class="mt-4"><% multilang("1023" "LANG_VLAN_SETTINGS"); %></h2>
			<header class="d-flex align-items-center pb-3 mb-5 border-bottom">
				This page used to configure and handle xPON VLAN
			</header>

			<form action="/boaform/formVlan" method="post" name="vlan">
				<div class="form-group row">
					<div class="col-sm-3">
						<input type="radio" class="form-check-input" name="vlan_cfg_type" id="vlan_cfg_type" value="0" onClick="vlan_cfg_type_change()" <% fmvlan_checkWrite("vlan_cfg_type_auto"); %>>
						<label class="form-check-label" for="vlan_cfg_type">
							<% multilang("153" "LANG_AUTO"); %>
						</label>
					</div>
					<div class="col-sm-3">
						<input type="submit" class="btn btn-primary" name="refresh" value="<% multilang("381" "LANG_REFRESH"); %>">
					</div>
				</div>
<br />
				<div class="form-group">
					<% omciVlanInfo(); %>
				</div>
<br />
				<div class="form-group">
					<div class="col-sm-2">
						<input type="radio" class="form-check-input" name="vlan_cfg_type" id="vlan_cfg_type" value="1" onClick="vlan_cfg_type_change()" <% fmvlan_checkWrite("vlan_cfg_type_manual"); %>>
						<label class="form-check-label" for="vlan_cfg_type">
							<% multilang("410" "LANG_MANUAL"); %>
						</label>
					</div>
				</div>
<br />
				<div class="form-group row">
					<div class="col-sm-1">
					</div>
					<div class="col-sm-11">
						<input type="radio" class="form-check-input" name="vlan_manu_mode" id="vlan_cfg_type" value="0" onClick="vlan_manu_mode_change()" <% fmvlan_checkWrite("vlan_manu_mode_trans"); %>>
						<label class="form-check-label" for="vlan_cfg_type">
							<% multilang("1025" "LANG_TRANSPARENT_MODE"); %>
						</label>
					</div>
				</div>
<br />
				<div class="form-group row">
					<div class="col-sm-1">
					</div>
					<div class="col-sm-4">
						<input type="radio" class="form-check-input" name="vlan_manu_mode" id="vlan_cfg_type" value="0" onClick="vlan_manu_mode_change()" <% fmvlan_checkWrite("vlan_manu_mode_tag"); %>>
						<label class="form-check-label" for="vlan_cfg_type">
							<% multilang("1026" "LANG_TAGGING_MODE"); %>
						</label>
					</div>
					<div class="col-sm-7">
						<input type="text" class="form-control" name="vlan_manu_tag_vid" size="5" maxlength="5" value="<% fmvlan_checkWrite("vlan_manu_tag_vid"); %>">
						<small class="form-text text-muted">Min: 0, Max: 4095</small>
					</div>
				</div>
<br />
				<div class="form-group row">
					<div class="col-sm-1">
					</div>
					<div class="col-sm-11">
						<input type="radio" class="form-check-input" name="vlan_manu_mode" id="vlan_cfg_type" value="0" onClick="vlan_manu_mode_change()" <% fmvlan_checkWrite("vlan_manu_mode_srv"); %>>
						<label class="form-check-label" for="vlan_cfg_type">
							<% multilang("1027" "LANG_REMOTE_ACCESS_MODE"); %>
						</label>
					</div>
				</div>
<br />
				<div class="form-group row">
					<div class="col-sm-1">
					</div>
					<div class="col-sm-11">
						<input type="radio" class="form-check-input" name="vlan_manu_mode" id="vlan_cfg_type" value="0" onClick="vlan_manu_mode_change()" <% fmvlan_checkWrite("vlan_manu_mode_sp"); %>>
						<label class="form-check-label" for="vlan_cfg_type">
							<% multilang("1028" "LANG_SPECIAL_CASE_MODE"); %>
						</label>
					</div>
				</div>
<br />
				<div class="col text-center">
					<input type="submit" class="btn btn-primary" name="save" onClick="return applyclick()" value="<% multilang("136" "LANG_APPLY_CHANGES"); %>">
					<input type="hidden" value="/vlan.asp" name="submit-url">
				</div>
			</form>
		</div>
		<script type="text/javascript" src="bootstrap.bundle.min.js"></script>
	</body>
</html>