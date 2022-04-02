<!-- Created by Anime4000 @ RTL960x Community for xPON ONU SFP Stick -->
<!doctype html>
<html>
	<head>
		<meta charset="utf-8">
		<meta http-equiv=refresh content="30; url=fdbtbl.asp">
		<meta name="viewport" content="width=device-width, initial-scale=1">
		<title><% multilang("790" "LANG_BRIDGE_FORWARDING_DATABASE"); %></title>	
		<link href="style/bootstrap.min.css" rel="stylesheet">
	</head>
	<body style="background-color: transparent;">
		<div class="col-lg-8 mx-auto p-3 py-md-5">
			<h2 class="mt-4"><% multilang("790" "LANG_BRIDGE_FORWARDING_DATABASE"); %></h2>
			<header class="d-flex align-items-center pb-3 mb-5 border-bottom">
				<% multilang("380" "LANG_PAGE_DESC_MAC_TABLE_INFO"); %>
			</header>

			<form action="/boaform/formRefleshFdbTbl" method="post" name="formFdbTbl">
				<table class="table table-hover">
					<thead class="thead-dark">
						<tr>
							<th scope="col"><% multilang("191" "LANG_PORT"); %></td>
							<th scope="col"><% multilang("88" "LANG_MAC_ADDRESS"); %></td>
							<th scope="col"><% multilang("792" "LANG_IS_LOCAL"); %></td>
							<th scope="col"><% multilang("793" "LANG_AGEING_TIMER"); %></td>
						</tr>
					</thead>
					<% bridgeFdbList(); %>
				</table>
				<input type="hidden" value="/fdbtbl.asp" name="submit-url">
			</form>
		</div>
		<script type="text/javascript" src="bootstrap.bundle.min.js"></script>
	</body>
</html>