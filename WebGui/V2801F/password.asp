<!-- Created by Anime4000 @ RTL960x Community for xPON ONU SFP Stick -->
<!doctype html>
<html>
	<head>
		<meta charset="utf-8">
		<meta name="viewport" content="width=device-width, initial-scale=1">
		<title><% multilang("493" "LANG_PASSWORD_CONFIGURATION"); %></title>	
		<link href="style/bootstrap.min.css" rel="stylesheet">
<script>
function saveChanges() {
	if ( document.password.newpass.value != document.password.confpass.value) {
		alert("<% multilang("1982" "LANG_PASSWORD_IS_NOT_MATCHED_PLEASE_TYPE_THE_SAME_PASSWORD_BETWEEN_NEW_AND_CONFIRMED_BOX"); %>");
		document.password.newpass.focus();
		return false;
	}

	if ( document.password.newpass.value.length == 0) {
		alert("<% multilang("1983" "LANG_PASSWORD_CANNOT_BE_EMPTY_PLEASE_TRY_IT_AGAIN"); %>");
		document.password.newpass.focus();
		return false;
	}

	if (includeSpace(document.password.newpass.value)) {
		alert("<% multilang("1986" "LANG_CANNOT_ACCEPT_SPACE_CHARACTER_IN_PASSWORD_PLEASE_TRY_IT_AGAIN"); %>");
		document.password.newpass.focus();
		return false;
	}

	if (checkString(document.password.newpass.value) == 0) {
		alert("<% multilang("1987" "LANG_INVALID_PASSWORD"); %>");
		document.password.newpass.focus();
		return false;
	}

  return true;
}
</script>
	</head>
	<body style="background-color: transparent;">
		<div class="col-lg-8 mx-auto p-3 py-md-5">
			<h2 class="mt-4"><% multilang("493" "LANG_PASSWORD_CONFIGURATION"); %></h2>
			<header class="d-flex align-items-center pb-3 mb-5 border-bottom">
				<% multilang("489" "LANG_PAGE_DESC_SET_ACCOUNT_PASSWORD"); %>
			</header>

			<form action="/boaform/formPasswordSetup" method="post" name="password">
				<div class="form-group row">
					<div class="col-sm-3 col-form-label">
						<label><% multilang("758" "LANG_USER"); %> <% multilang("626" "LANG_NAME"); %></label>
					</div>
					<div class="col-sm-9">
						<select class="form-select" name="userMode">
							<option selected value="0">admin</option>
						</select>
					</div>
				</div>
<br />
				<div class="form-group row">
					<div class="col-sm-3 col-form-label">
						<label><% multilang("490" "LANG_OLD_PASSWORD"); %></label>
					</div>
					<div class="col-sm-9">
						<input type="password" class="form-control" name="oldpass" size="20" maxlength="30">
					</div>
				</div>
<br />
				<div class="form-group row">
					<div class="col-sm-3 col-form-label">
						<label><% multilang("491" "LANG_NEW_PASSWORD"); %></label>
					</div>
					<div class="col-sm-9">
						<input type="password" class="form-control" name="newpass" size="20" maxlength="30">
					</div>
				</div>
<br />
				<div class="form-group row">
					<div class="col-sm-3 col-form-label">
						<label><% multilang("492" "LANG_CONFIRMED_PASSWORD"); %></label>
					</div>
					<div class="col-sm-9">
						<input type="password" class="form-control" name="confpass" size="20" maxlength="30">
					</div>
				</div>
<br />
				<div class="form-group row">
					<div class="col-sm-3">
						<input type="submit" class="btn btn-primary" name="save" onClick="return saveChanges();" value="<% multilang("136" "LANG_APPLY_CHANGES"); %>">
					</div>
				</div>

                <input type="hidden" value="/password.asp" name="submit-url">
			</form>
		</div>
		<script type="text/javascript" src="bootstrap.bundle.min.js"></script>
	</body>
</html>