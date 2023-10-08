<!-- Created by Anime4000 @ RTL960x Community for xPON ONU SFP Stick -->
<!doctype html>
<html>
	<head>
		<meta charset="utf-8">
        <meta http-equiv=refresh content="30; url=pon-stats.asp">
		<meta name="viewport" content="width=device-width, initial-scale=1">
		<title><% multilang("821" "LANG_PON_STATISTICS"); %></title>	
		<link href="style/bootstrap.min.css" rel="stylesheet">
	</head>
	<body style="background-color: transparent;">
		<div class="col-lg-8 mx-auto p-3 py-md-5">
			<h2 class="mt-4"><% multilang("821" "LANG_PON_STATISTICS"); %></h2>
			<header class="d-flex align-items-center pb-3 mb-5 border-bottom">

			</header>

			<form action="/boaform/formStats" method="post" name="formStats">
                <table class="table table-hover">
                    <tbody>

						<tr>
							<th><% multilang("822" "LANG_BYTES_SENT"); %></th>
							<td><% ponGetStatus("bytes-sent"); %></td>
						</tr>
						<tr>
							<th><% multilang("823" "LANG_BYTES_RECEIVED"); %></th>
							<td><% ponGetStatus("bytes-received"); %></td>
						</tr>
						<tr>
							<th><% multilang("824" "LANG_PACKETS_SENT"); %></th>
							<td><% ponGetStatus("packets-sent"); %></td>
						</tr>
						<tr>
							<th><% multilang("825" "LANG_PACKETS_RECEIVED"); %></th>
							<td><% ponGetStatus("packets-received"); %></td>
						</tr>
						<tr>
							<th><% multilang("826" "LANG_UNICAST_PACKETS_SENT"); %></th>
							<td><% ponGetStatus("unicast-packets-sent"); %></td>
						</tr>
						<tr>
							<th><% multilang("827" "LANG_UNICAST_PACKETS_RECEIVED"); %></th>
							<td><% ponGetStatus("unicast-packets-received"); %></td>
						</tr>
						<tr>
							<th><% multilang("828" "LANG_MULTICAST_PACKETS_SENT"); %></th>
							<td><% ponGetStatus("multicast-packets-sent"); %></td>
						</tr>
						<tr>
							<th><% multilang("829" "LANG_MULTICAST_PACKETS_RECEIVED"); %></th>
							<td><% ponGetStatus("multicast-packets-received"); %></td>
						</tr>
						<tr>
							<th><% multilang("830" "LANG_BROADCAST_PACKETS_SENT"); %></th>
							<td><% ponGetStatus("broadcast-packets-sent"); %></td>
						</tr>
						<tr>
							<th><% multilang("831" "LANG_BROADCAST_PACKETS_RECEIVED"); %></th>
							<td><% ponGetStatus("broadcast-packets-received"); %></td>
						</tr>
						<tr>
							<th><% multilang("832" "LANG_FEC_ERRORS"); %></th>
							<td><% ponGetStatus("fec-errors"); %></td>
						</tr>
						<tr>
							<th><% multilang("833" "LANG_HEC_ERRORS"); %></th>
							<td><% ponGetStatus("hec-errors"); %></td>
						</tr>
						<tr>
							<th><% multilang("834" "LANG_PACKETS_DROPPED"); %></th>
							<td><% ponGetStatus("packets-dropped"); %></td>
						</tr>
						<tr>
							<th><% multilang("835" "LANG_PAUSE_PACKETS_SENT"); %></th>
							<td><% ponGetStatus("pause-packets-sent"); %></td>
						</tr>
						<tr>
							<th><% multilang("836" "LANG_PAUSE_PACKETS_RECEIVED"); %></th>
							<td><% ponGetStatus("pause-packets-received"); %></td>
						</tr>

                    </tbody>
                </table>
			</form>
		</div>
		<script type="text/javascript" src="bootstrap.bundle.min.js"></script>
	</body>
</html>