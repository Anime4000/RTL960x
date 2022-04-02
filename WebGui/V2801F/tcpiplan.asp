<!-- Created by Anime4000 @ RTL960x Community for xPON ONU SFP Stick -->
<!doctype html>
<html>
	<head>
		<meta charset="utf-8">
		<meta name="viewport" content="width=device-width, initial-scale=1">
		<title><% multilang("112" "LANG_LAN_INTERFACE_SETTINGS"); %></title>	
		<link href="style/bootstrap.min.css" rel="stylesheet">
    <script type="text/javascript" src="share.js">
		<script>
function resetClick() {
	document.tcpip.reset;
}

function saveChanges() {
	var lpm1 = 0;
	var lpm2 = 0;

	if (!checkHostIP(document.tcpip.ip, 1))
		return false;
	if (!checkNetmask(document.tcpip.mask, 1))
		return false;

// Magician 2013/08/23: LAN port mask.
	with (document.forms[0]) {
		if(typeof chk_port_mask1 != 'undefined' && chk_port_mask1 != null) {
			for (var i = 0; i < chk_port_mask1.length; i++) {
				if (chk_port_mask1[i].checked == true)
					lpm1 |= (0x1 << i);
   			}
			lan_port_mask1.value = lpm1;
		}

		if(typeof chk_port_mask2 != 'undefined' && chk_port_mask2 != null) {
			for (var i = 0; i < chk_port_mask2.length; i++) {
				if (chk_port_mask2[i].checked == true)
					lpm2 |= (0x1 << i);
			}
			lan_port_mask2.value = lpm2;
		}

		if((ip_version1.selectedIndex != 0) && (ipv6_mode1[1].checked) ) { //IPv6 enabled && mode is manual
			if (ipv6_addr1.value =="" || ipv6_addr1.value =="::") {
				alert("<% multilang("2347" "LANG_LAN_IPV6_ADDRESS_CANNOT_BE_EMPTY_FORMAT_IS_IPV6_ADDRESS_FOR_EXAMPLE_3FFE_501_FFFF_100_1"); %>");
				ipv6_addr1.focus();
				return false;
			} else {
				if ( validateKeyV6IP(ipv6_addr1.value) == 0) {
					alert("<% multilang("2348" "LANG_INVALID_LAN_IPV6_IP"); %>");
					ipv6_addr1.focus();
					return false;
				}
			}

			if (ipv6_prefix1.value =="") {
				alert("<% multilang("2349" "LANG_LAN_IPV6_ADDRESS_IPV6_PREFIX1_CANNOT_BE_EMPTY_VALID_NUMBER_IS_0_127"); %>");
				ipv6_prefix1.focus();
				return false;
			} else {
				var prefixInt = parseInt(ipv6_prefix1.value);
				if ( prefixInt>127 ||prefixInt<0) {
					alert("<% multilang("2350" "LANG_INVALID_LAN_IPV6_PREVIX"); %>");
					ipv6_prefix1.focus();
					return false;
				}
			}
		}
	}
	<% checkIP2(); %>
	return true;
}

function disableRadioGroup (radioArrOrButton) {
	if (radioArrOrButton.type && radioArrOrButton.type == "radio") {
		var radioButton = radioArrOrButton;
		var radioArray = radioButton.form[radioButton.name];
	} else
  	var radioArray = radioArrOrButton;

	radioArray.disabled = true;

	for (var b = 0; b < radioArray.length; b++) {
		if (radioArray[b].checked) {
			radioArray.checkedElement = radioArray[b];
			break;
		}
	}
	for (var b = 0; b < radioArray.length; b++) {
		radioArray[b].disabled = true;
		radioArray[b].checkedElement = radioArray.checkedElement;
	}
}

function updateState() {
	if (document.tcpip.wlanDisabled.value == "ON") {
		disableRadioGroup(document.tcpip.BlockEth2Wir);
	}
}

function ipv6_mode1_change() {
	with (document.forms[0]) {
		if(ipv6_mode1[0].checked) {
			ipv6_addr1.disabled = true;
			ipv6_prefix1.disabled = true;
		} else {
			ipv6_addr1.disabled = false;
			ipv6_prefix1.disabled = false;

			if(ipv6_addr1.value =="::")
			ipv6_addr1.value ="";
		}
	}
}

function ipv6_mode2_change() {
	with (document.forms[0]) {
		if(ipv6_mode2[0].checked) {
			ipv6_addr2.disabled = true;
			ipv6_prefix2.disabled = true;
		} else {
			ipv6_addr2.disabled = false;
			ipv6_prefix2.disabled = false;
		}
	}
}

function ipv6_version1_change() {
	with (document.forms[0]) {
		if(ip_version1.selectedIndex == 0) {
			ipv6_mode1[0].disabled = true;
			ipv6_mode1[1].disabled = true;
			ipv6_addr1.disabled = true;
			ipv6_prefix1.disabled = true;
			ip.disabled = false;
			mask.disabled = false;
		} else {
			ipv6_mode1[0].disabled = false;
			ipv6_mode1[1].disabled = false;
			ipv6_addr1.disabled = false;
			ipv6_prefix1.disabled = false;
			ip.disabled = false;
			mask.disabled = false;
			ipv6_mode1_change();
		}
	}
}

function on_init()
{
	ipv6_version1_change();
}

<% lanScript(); %>
</script>
	</head>
	<body style="background-color: transparent;">
		<div class="col-lg-8 mx-auto p-3 py-md-5">
			<h2 class="mt-4"><% multilang("112" "LANG_LAN_INTERFACE_SETTINGS"); %></h2>
			<header class="d-flex align-items-center pb-3 mb-5 border-bottom">
				<p><% multilang("113" "LANG_PAGE_DESC_CONFIG_DEVICE_LAN_INTERFACE"); %></p>
			</header>

			<form action="/boaform/formTcpipLanSetup" method="post" name="tcpip">
				<div class="form-group row">
					<label class="col-sm-3 col-form-label"><% multilang("66" "LANG_INTERFACE"); %> <% multilang("626" "LANG_NAME"); %></label>
					<div class="col-sm-9">
						<input type="text" class="form-control-plaintext" value="br0" readonly>
					</div>
				</div>
<br />
				<div class="form-group row">
					<label class="col-sm-3 col-form-label"><% multilang("85" "LANG_IP_ADDRESS"); %></label>
						<div class="col-sm-9">
						<input type="text" class="form-control" id="ip" name="ip" value="<% getInfo("lan-ip"); %>">
					</div>
				</div>
<br />
				<div class="form-group row">
					<label class="col-sm-3 col-form-label"><% multilang("86" "LANG_SUBNET_MASK"); %></label>
						<div class="col-sm-9">
						<input type="text" class="form-control" id="mask" name="mask" value="<% getInfo("lan-subnet"); %>">
					</div>
				</div>
<br />
        <div class="col text-center">
				  <input type="submit" class="btn btn-primary" onClick="return saveChanges();" value="<% multilang("136" "LANG_APPLY_CHANGES"); %>">
        </div>
			</form>

		</div>
    <script type="text/javascript" src="bootstrap.bundle.min.js"></script>
	</body>
</html>