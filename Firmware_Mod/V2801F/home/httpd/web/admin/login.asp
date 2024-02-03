<!doctype html>
<html>
<!-- Copyright (c) Realtek Semiconductor Corp., 2003. All Rights Reserved. -->
	<head>
		<meta http-equiv="Content-Type" content="text/html" charset="utf-8">
		<meta name="viewport" content="width=device-width, initial-scale=1.0">
		<title>xPON ONU SFP</title>
		<script src="md5.js" type="text/javascript"></script>
		<script>
		function setpass()
		{
			<% passwd2xmit(); %>
		}
		function mlhandle()
		{
			document.formML.submit();
			parent.location.reload();
		}
		</script>
		<style>
		body {
			display: flex;
			justify-content: center;
			align-items: center;
			height: 100vh;
			margin: 0;
			font-family: Arial, sans-serif;
			background-color: #330033;
			background-image: url("data:image/svg+xml,%3Csvg xmlns='http://www.w3.org/2000/svg' width='400' height='400' viewBox='0 0 800 800'%3E%3Cg fill='none' stroke='%23404' stroke-width='1'%3E%3Cpath d='M769 229L1037 260.9M927 880L731 737 520 660 309 538 40 599 295 764 126.5 879.5 40 599-197 493 102 382-31 229 126.5 79.5-69-63'/%3E%3Cpath d='M-31 229L237 261 390 382 603 493 308.5 537.5 101.5 381.5M370 905L295 764'/%3E%3Cpath d='M520 660L578 842 731 737 840 599 603 493 520 660 295 764 309 538 390 382 539 269 769 229 577.5 41.5 370 105 295 -36 126.5 79.5 237 261 102 382 40 599 -69 737 127 880'/%3E%3Cpath d='M520-140L578.5 42.5 731-63M603 493L539 269 237 261 370 105M902 382L539 269M390 382L102 382'/%3E%3Cpath d='M-222 42L126.5 79.5 370 105 539 269 577.5 41.5 927 80 769 229 902 382 603 493 731 737M295-36L577.5 41.5M578 842L295 764M40-201L127 80M102 382L-261 269'/%3E%3C/g%3E%3Cg fill='%23505'%3E%3Ccircle cx='769' cy='229' r='5'/%3E%3Ccircle cx='539' cy='269' r='5'/%3E%3Ccircle cx='603' cy='493' r='5'/%3E%3Ccircle cx='731' cy='737' r='5'/%3E%3Ccircle cx='520' cy='660' r='5'/%3E%3Ccircle cx='309' cy='538' r='5'/%3E%3Ccircle cx='295' cy='764' r='5'/%3E%3Ccircle cx='40' cy='599' r='5'/%3E%3Ccircle cx='102' cy='382' r='5'/%3E%3Ccircle cx='127' cy='80' r='5'/%3E%3Ccircle cx='370' cy='105' r='5'/%3E%3Ccircle cx='578' cy='42' r='5'/%3E%3Ccircle cx='237' cy='261' r='5'/%3E%3Ccircle cx='390' cy='382' r='5'/%3E%3C/g%3E%3C/svg%3E");
		}
		a {
			text-decoration: none;
			color: #007BFF;
		}
		a:visited {
			color: #be9bff;
		}
		a:hover {
			color: orange;
		}
		.container {
			width: 400px;
			padding: 20px;
			border: 1px solid rgba(204, 204, 204, 0.75);
			border-radius: 5px;
			backdrop-filter: blur(16px);
			background-color: rgba(249, 249, 249, 0.6);
			box-shadow: 0 0 10px rgba(0,0,0,0.1);
		}
		.form-group {
			margin-bottom: 15px;
		}
		.form-group label {
			display: block;
			margin-bottom: 5px;
		}
		.form-group input {
			width: calc(100% - 20px);
			padding: 10px;
			border: 1px solid #ccc;
			border-radius: 3px;
		}
		.btn {
			display: block;
			width: calc(100% + 2px);
			padding: 10px;
			border: none;
			border-radius: 3px;
			background-color: #007BFF;
			color: white;
			text-align: center;
			cursor: pointer;
		}
		.btn:hover {
			background-color: #0056b3;
		}
		.logo {
			width: 80px;
			height: 80px;
			float: left;
			margin-right: 20px;
		}
		.bottom-text {
			position: fixed;
			bottom: 10px;
			width: 100%;
			text-align: center;
			font-size: 14px;
			font-family: monospace, monospace;
			color: #9b9b9b;
		}
		</style>
	</head>
	<body>
		<blockquote>
			<form action="/boaform/admin/formLogin" method="POST" name="cmlogin">
				<input type="hidden" name="challenge">
				<div class="container">
					<h3>Authentication Required</h3>
					<div class="form-group">
						<label for="username">Username</label>
						<input id="username" name="username" placeholder="Enter your username" class="td1">
					</div>
					<div class="form-group">
						<label for="password">Password</label>
						<input type="password" id="password" name="password" placeholder="Enter your password" class="td1">
					</div>
					<input class="btn" type="submit" value="<% multilang("737" "LANG_LOGIN"); %>" name="save" onClick="setpass(this)">
					<input class="btn" type="hidden" value="/admin/login.asp" name="submit-url">
				</div>
			</form>
		</blockquote>
		<div class="bottom-text">

			This xPON ONU SFP is powered by <a href="https://github.com/Anime4000/RTL960x">RTL960x</a> with modifications by Anime4000<br />Additional integrated scripts provided by stich86, inyourgroove, and rajkosto.

		</div>
	</body>
</html>
