<!-- Created by Anime4000 @ RTL960x Community for xPON ONU SFP Stick -->
<!doctype html>
<html>
	<head>
		<meta charset="utf-8">
		<meta name="viewport" content="width=device-width, initial-scale=1">
		<title><% multilang("1123" "LANG_MULTI_LANGUAL_SETTINGS"); %></title>	
		<link href="style/bootstrap.min.css" rel="stylesheet">
	</head>
	<body style="background-color: transparent;">
		<div class="col-lg-8 mx-auto p-3 py-md-5">
			<h2 class="mt-4"><% multilang("1123" "LANG_MULTI_LANGUAL_SETTINGS"); %></h2>
			<header class="d-flex align-items-center pb-3 mb-5 border-bottom">
				<% multilang("1124" "LANG_PAGE_DESC_MULTI_LANGUAL"); %>
			</header>

			<form action="/boaform/langSel" method="post" name="mlSet">
				<div class="form-group row">
					<div class="col-sm-3 col-form-label">
						<label><% multilang("1123" "LANG_MULTI_LANGUAL_SETTINGS"); %></label>
					</div>
					<div class="col-sm-9">
						<select class="form-select" name="selinit">
							<% checkWrite("selinit"); %>
						</select>
					</div>
				</div>
<br />
				<div class="form-group row">
					<div class="col-sm-3">
					</div>
					<div class="col-sm-9">
						<input type="submit" class="btn btn-primary" onclick="parent.location.reload();" value="<% multilang("1126" "LANG_UPDATE_SELECTED_LANGUAGE"); %>">
					</div>
				</div>
			</form>
		</div>
		<script type="text/javascript" src="bootstrap.bundle.min.js"></script>
	</body>
</html>