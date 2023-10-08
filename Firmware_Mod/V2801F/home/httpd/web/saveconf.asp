<!-- Created by Anime4000 @ RTL960x Community for xPON ONU SFP Stick -->
<!doctype html>
<html>
	<head>
		<meta charset="utf-8">
		<meta name="viewport" content="width=device-width, initial-scale=1">
		<title><% multilang("479" "LANG_BACKUP_AND_RESTORE_SETTINGS"); %></title>	
		<link href="style/bootstrap.min.css" rel="stylesheet">

<script type="text/javascript">
function resetClick() {
    console.log("resetClick() is fired");
    return confirm("<% multilang("2470" "LANG_DO_YOU_REALLY_WANT_TO_RESET_THE_CURRENT_SETTINGS_TO_FACTORY_DEFAULT"); %>");
}

function uploadClick() {
    if (document.saveConfig.binary.value.length == 0) {
        alert('<% multilang("480" "LANG_CHOOSE_FILE"); %>!');
        document.saveConfig.binary.focus();
        return false;
    }
    return true;
}
</script>

	</head>
	<body style="background-color: transparent;">
		<div class="col-lg-8 mx-auto p-3 py-md-5">
			<h2 class="mt-4"><% multilang("479" "LANG_BACKUP_AND_RESTORE_SETTINGS"); %></h2>
			<header class="d-flex align-items-center pb-3 mb-5 border-bottom">
				<% multilang("481" "LANG_THIS_PAGE_ALLOWS_YOU_TO_BACKUP_CURRENT_SETTINGS_TO_A_FILE_OR_RESTORE_THE_SETTINGS_FROM_THE_FILE_WHICH_WAS_SAVED_PREVIOUSLY_BESIDES_YOU_COULD_RESET_THE_CURRENT_SETTINGS_TO_FACTORY_DEFAULT"); %>
			</header>

			<form action="/boaform/formSaveConfig" enctype="multipart/form-data" method="post" name="saveCSConfig">
				<div class="form-group row">
					<div class="col-sm-4">
						<label class="form-check-label" for="vlan_cfg_type">
							<% multilang("482" "LANG_BACKUP_SETTINGS_TO_FILE"); %>
						</label>
					</div>
					<div class="col-sm-4">
                        <input type="submit" class="btn btn-primary" name="save_cs" value="<% multilang("485" "LANG_BACKUP"); %>">
					</div>
				</div>
			</form>
<br />
			<form action="/boaform/formSaveConfig" enctype="multipart/form-data" method="post" name="saveConfig">
				<div class="form-group row">
					<div class="col-sm-4">
						<label class="form-check-label" for="vlan_cfg_type">
							<% multilang("486" "LANG_RESTORE_SETTINGS_FROM_FILE"); %>
						</label>
					</div>
					<div class="col-sm-8">
                        <input type="file" class="form-control" id="formFile" name="binary" value="<% multilang("480" "LANG_CHOOSE_FILE"); %>">
						<small class="form-text text-warning">Invalid config file can cause xPON ONU SFP Stick unable to boot!</small>
					</div>
				</div>
<br />
				<div class="form-group row">
					<div class="col-sm-4">
					</div>
					<div class="col-sm-8">
                        <input type="submit" class="btn btn-warning" name="load" onClick="return uploadClick();" value="<% multilang("487" "LANG_RESTORE"); %>">
					</div>
				</div>
                <input type="hidden" value="/saveconf.asp" name="submit-url">
			</form>

			<h2 class="mt-4">Factory Reset</h2>
			<header class="d-flex align-items-center pb-3 mb-5 border-bottom">
				Restore xPON ONU SFP Stick back to default factory settings.
			</header>

			<form action="/boaform/formSaveConfig" method="post" name="resetConfig">
				<div class="form-group row">
					<div class="col-sm-4">
						<label class="form-check-label" for="vlan_cfg_type">
							<% multilang("488" "LANG_RESET_SETTINGS_TO_DEFAULT"); %>
						</label>
					</div>
					<div class="col-sm-4">
                        <input type="submit" class="btn btn-danger" name="reset" onClick="return resetClick();" value="<% multilang("200" "LANG_RESET"); %>">
					</div>
				</div>
                <input type="hidden" value="/saveconf.asp" name="submit-url">
			</form>
		</div>

		<script type="text/javascript" src="bootstrap.bundle.min.js"></script>
	</body>
</html>