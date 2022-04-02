<!-- Created by Anime4000 @ RTL960x Community for xPON ONU SFP Stick -->
<!doctype html>
<html>
	<head>
		<meta charset="utf-8">
		<meta name="viewport" content="width=device-width, initial-scale=1">
		<title><% multilang("64" "LANG_FIRMWARE_UPGRADE"); %></title>	
		<link href="style/bootstrap.min.css" rel="stylesheet">

<script type="text/javascript">
var upgrade_flag = 1;
function sendClicked() {
	if(1 == upgrade_flag) {
			if (document.password.binary.value=="") {
			alert("<% multilang("2162" "LANG_SELECTED_FILE_CANNOT_BE_EMPTY"); %>");
			document.password.binary.focus();
			return false;
		}

		if (!confirm('<% multilang("499" "LANG_PAGE_DESC_UPGRADE_CONFIRM")%>'))
			return false;
		else {
			upgrade_flag = 0;
			return true;
		}
	} else {
		alert("The upgrading is in progress!");
		return false;
	}
}
</script>

	</head>
	<body style="background-color: transparent;">
		<div class="col-lg-8 mx-auto p-3 py-md-5">
			<h2 class="mt-4"><% multilang("64" "LANG_FIRMWARE_UPGRADE"); %></h2>
			<header class="d-flex align-items-center pb-3 mb-5 border-bottom">
				<% multilang("494" "LANG_PAGE_DESC_UPGRADE_FIRMWARE"); %>
			</header>

			<form action="/boaform/admin/formUpload" method="post" enctype="multipart/form-data" name="password">
				<div class="form-group row">
					<div class="mb-3">
						<label for="formFile" class="form-label">RTL960x firmware package file (*.tar)</label>
						<input class="form-control" id="formFile" type="file" name="binary" value="<% multilang("480" "LANG_CHOOSE_FILE"); %>">
						<small class="form-text text-warning">Invalid firmware package can cause xPON ONU Stick SFP unable to boot!</small>
					</div>
				</div>
<br />
				<div class="form-group row">
					<div class="col-sm-4">
						<input type="submit" class="btn btn-primary" name="send" onclick="return sendClicked()" value="<% multilang("495" "LANG_UPGRADE"); %>">
					</div>
				</div>


                <input type="hidden" value="/admin/upgrade.asp" name="submit-url">
			</form>
		</div>
		<script type="text/javascript" src="bootstrap.bundle.min.js"></script>
	</body>
</html>