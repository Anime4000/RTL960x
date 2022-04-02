<!-- Created by Anime4000 @ RTL960x Community for xPON ONU SFP Stick -->
<!doctype html>
<html lang="en">
	<head>
		<meta charset="utf-8">
        <meta http-equiv=refresh content="30; url=stats.asp">
		<meta name="viewport" content="width=device-width, initial-scale=1">
		<title><% multilang("533" "LANG_INTERFACE_STATISITCS"); %></title>	
		<link href="style/bootstrap.min.css" rel="stylesheet">
	</head>
	<body style="background-color: transparent;">
		<div class="col-lg-8 mx-auto p-3 py-md-5">
			<h2 class="mt-4"><% multilang("533" "LANG_INTERFACE_STATISITCS"); %></h2>
			<header class="d-flex align-items-center pb-3 mb-5 border-bottom">
				<% multilang("534" "LANG_PAGE_DESC_PACKET_STATISTICS_INFO"); %>
			</header>

			<form action="/boaform/formStats" method="post" name="formStats">
				<table class="table table-hover">
					<% pktStatsList(); %>
				</table>
			</form>
		</div>
		<script type="text/javascript" src="bootstrap.bundle.min.js"></script>
	</body>
</html>