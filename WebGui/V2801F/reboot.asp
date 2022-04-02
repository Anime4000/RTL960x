<!-- Created by Anime4000 @ RTL960x Community for xPON ONU SFP Stick -->
<!doctype html>
<html>
	<head>
		<meta charset="utf-8">
		<meta name="viewport" content="width=device-width, initial-scale=1">
		<title><% multilang("477" "LANG_COMMIT_AND_REBOOT"); %></title>	
		<link href="style/bootstrap.min.css" rel="stylesheet">

<script>
function saveClick() {
    if ( !confirm('<% multilang("2468" "LANG_DO_YOU_REALLY_WANT_TO_COMMIT_THE_CURRENT_SETTINGS"); %>') ) {
        return false;
    }
    else
        return true;
}

function resetClick() {
    if ( !confirm('<% multilang("2469" "LANG_DO_YOU_REALLY_WANT_TO_RESET_THE_CURRENT_SETTINGS_TO_DEFAULT"); %>') ) {
        return false;
    }
    else
        return true;
}
</script>

	</head>
	<body style="background-color: transparent;">
		<div class="col-lg-8 mx-auto p-3 py-md-5">
			<h2 class="mt-4"><% multilang("477" "LANG_COMMIT_AND_REBOOT"); %></h2>
			<header class="d-flex align-items-center pb-3 mb-5 border-bottom">
				<% multilang("478" "LANG_THIS_PAGE_IS_USED_TO_COMMIT_CHANGES_TO_SYSTEM_MEMORY_AND_REBOOT_YOUR_SYSTEM"); %>
			</header>

			<form action="/boaform/admin/formReboot" method="post" name="cmboot">
				<div class="form-group row">
					<div class="col-sm-4">
					</div>
					<div class="col-sm-4">
                        <button type="input" class="btn btn-warning" name="save" onclick="return saveClick()"><% multilang("477" "LANG_COMMIT_AND_REBOOT"); %></button>
					</div>
					<div class="col-sm-4">
					</div>
				</div>
			</form>
		</div>
		<script type="text/javascript" src="bootstrap.bundle.min.js"></script>
	</body>
</html>