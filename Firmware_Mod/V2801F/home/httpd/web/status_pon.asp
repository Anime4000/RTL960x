<!-- Created by Anime4000 @ RTL960x Community for xPON ONU SFP Stick -->
<!doctype html>
<html>
	<head>
		<meta charset="utf-8">
		<meta http-equiv=refresh content="30; url=status_pon.asp">
		<meta name="viewport" content="width=device-width, initial-scale=1">
		<title>PON <% multilang("3" "LANG_STATUS"); %></title>	
		<link href="style/bootstrap.min.css" rel="stylesheet">
	</head>
	<body style="background-color: transparent;">
		<div class="col-lg-8 mx-auto p-3 py-md-5">
			<h2 class="mt-4">PON <% multilang("3" "LANG_STATUS"); %></h2>
			<header class="d-flex align-items-center pb-3 mb-5 border-bottom">
				<p><% multilang("103" "LANG_PAGE_DESC_PON_STATUS"); %></p>
			</header>

			<table class="table table-hover">
				<thead class="thead-dark">
					<tr>
						<th scope="col" colspan="2"><% multilang("1180" "LANG_PON"); %><% multilang("104" "LANG_STATUS_1"); %></th>
					</tr>
				</thead>
				<tbody>
					<tr>
						<td><% multilang("105" "LANG_VENDOR_NAME"); %></td>
						<td><% ponGetStatus("vendor-name"); %></td>
					</tr>
					<tr>
						<td><% multilang("106" "LANG_PART_NUMBER"); %></td>
						<td><% ponGetStatus("part-number"); %></td>
					</tr>
					<tr>
						<td><% multilang("107" "LANG_TEMPERATURE"); %></td>
						<td><% ponGetStatus("temperature"); %></td>
					</tr>
					<tr>
						<td><% multilang("108" "LANG_VOLTAGE"); %></td>
						<td><% ponGetStatus("voltage"); %></td>
					</tr>
					<tr>
						<td><% multilang("109" "LANG_TX_POWER"); %></td>
						<td><% ponGetStatus("tx-power"); %></td>
					</tr>
					<tr>
						<td><% multilang("110" "LANG_RX_POWER"); %></td>
						<td><% ponGetStatus("rx-power"); %></td>
					</tr>
					<tr>
						<td><% multilang("111" "LANG_BIAS_CURRENT"); %></td>
						<td><% ponGetStatus("bias-current"); %></td>
					</tr>
				</tbody>
			</table>

			<table class="table table-hover">
				<% showgpon_status(); %>
			</table>

			<table class="table table-hover">
				<% showepon_LLID_status(); %>
			</table>

		</div>
		<script type="text/javascript" src="bootstrap.bundle.min.js"></script>
	</body>
</html>