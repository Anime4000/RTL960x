

function get_by_id(id) {
 with(document) {
  return getElementById(id);
 }
}

function disableTextField (field) {
 if (document.all || document.getElementById)
  field.disabled = true;
 else {
  field.oldOnFocus = field.onfocus;
  field.onfocus = skip;
 }
}
function enableTextField (field) {
 if (document.all || document.getElementById)
  field.disabled = false;
 else {
  field.onfocus = field.oldOnFocus;
 }
}

function disableRadioGroup (radioArrOrButton)
{
  if (radioArrOrButton.type && radioArrOrButton.type == "radio") {
        var radioButton = radioArrOrButton;
        var radioArray = radioButton.form[radioButton.name];
  }
  else
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

function enableRadioGroup (radioArrOrButton)
{
  if (radioArrOrButton.type && radioArrOrButton.type == "radio") {
        var radioButton = radioArrOrButton;
        var radioArray = radioButton.form[radioButton.name];
  }
  else
        var radioArray = radioArrOrButton;

  radioArray.disabled = false;
  radioArray.checkedElement = null;
  for (var b = 0; b < radioArray.length; b++) {
        radioArray[b].disabled = false;
        radioArray[b].checkedElement = null;
  }
}

function disableCheckBox (checkBox) {
  if (!checkBox.disabled) {
    checkBox.disabled = true;
    if (!document.all && !document.getElementById) {
      checkBox.storeChecked = checkBox.checked;
      checkBox.oldOnClick = checkBox.onclick;
      checkBox.onclick = preserve;
    }
  }
}

function enableCheckBox (checkBox)
{
  if (checkBox.disabled) {
    checkBox.disabled = false;
    if (!document.all && !document.getElementById)
      checkBox.onclick = checkBox.oldOnClick;
  }
}


function check_wps_enc(enc, radius, auth, hidden_ssid, wpa_cipher, wpa2_cipher, wps20)
{
  if(hidden_ssid){
   return 4;
  }
  if (enc == 0 ) {
                if (radius != 0)
                        return 2;
        }
  //else if(enc == 1){
  else if (wps20 && enc == 1) {
   return 5;
  }
        else {
    if(wps20 && (enc == 2 || enc == 3 || (enc == 5 && wpa2_cipher == 1) || (enc == 6 && wpa_cipher == 1 && wpa2_cipher == 1))){
     return 6;
    }
                if (auth & 1)
                        return 2;
        }
        return 0;
}

function check_wps_wlanmode(mo, type)
{
        if (mo == 2) {
                return 1;
        }
        if (mo == 1 && type != 0) {
                return 1;
        }
        return 0;
}


function getDigit(str, num)
{
  i=1;
  if ( num != 1 ) {
   while (i!=num && str.length!=0) {
  if ( str.charAt(0) == '.' ) {
   i++;
  }
  str = str.substring(1);
   }
   if ( i!=num )
    return -1;
  }
  for (i=0; i<str.length; i++) {
   if ( str.charAt(i) == '.' ) {
  str = str.substring(0, i);
  break;
 }
  }
  if ( str.length == 0)
   return -1;
  d = parseInt(str, 10);
  return d;
}

function getDigitforMac(str, num)
{
  i=1;
  if ( num != 1 ) {
   while (i!=num && str.length!=0) {
  if ( str.charAt(0) == '-' ) {
   i++;
  }
  str = str.substring(1);
   }
   if ( i!=num )
    return -1;
  }
  for (i=0; i<str.length; i++) {
   if ( str.charAt(i) == '-' ) {
  str = str.substring(0, i);
  break;
 }
  }
  if ( str.length == 0)
   return -1;
  d = parseInt(str, 10);
  return d;
}

function validateKey(str)
{
   for (var i=0; i<str.length; i++) {
    if ( (str.charAt(i) >= '0' && str.charAt(i) <= '9') ||
      (str.charAt(i) == '.' ) )
   continue;
 return 0;
  }
  return 1;
}

function validateKey2(str)
{
   for (var i=0; i<str.length; i++) {
    if ( (str.charAt(i) >= '0' && str.charAt(i) <= '9') ||
      (str.charAt(i) == '-' ) ||
      (str.charAt(i) >= 'A' && str.charAt(i) <= 'F')||
      (str.charAt(i) >= 'a' && str.charAt(i) <= 'f') )
   continue;
 return 0;
  }
  return 1;
}

function IsInvalidIP(str)
{
//	if ((str == "127.100.100.100") || (str == "127.255.255.254"))
 d = getDigit(str, 1);
 if (d == 127)
  return 1;
 return 0;
}

function IsLoopBackIP(str)
{
 if(str=="127.0.0.1")
  return 1;
 return 0;
}

function checkDigit(str)
{
 for (var i=0; i<str.length; i++) {
  if ((str.charAt(i) >= '0' && str.charAt(i) <= '9'))
   continue;
  return 0;
 }
 return 1;
}

function checkDigitRange(str, num, min, max)
{
  d = getDigit(str,num);
  if ( d > max || d < min )
       return false;
  return true;
}

function checkDigitRangeforMac(str, num, min, max)
{
  d = getDigitforMac(str,num);
  if ( d > max || d < min )
       return false;
  return true;
}

function checkLan1andLan2(ip1, mask1, ip2, mask2)
{
 d11 = getDigit(ip1.value,1);
 d12 = getDigit(mask1.value, 1);
 d21 = getDigit(ip2.value,1);
 d22 = getDigit(mask2.value,1);
 d1 = d11 & d12;
 d2 = d21 & d22;
 if (d1 != d2)
  return true;

 d11 = getDigit(ip1.value,2);
 d12 = getDigit(mask1.value, 2);
 d21 = getDigit(ip2.value,2);
 d22 = getDigit(mask2.value,2);
 d1 = d11 & d12;
 d2 = d21 & d22;
 if (d1 != d2)
  return true;

 d11 = getDigit(ip1.value,3);
 d12 = getDigit(mask1.value, 3);
 d21 = getDigit(ip2.value,3);
 d22 = getDigit(mask2.value,3);
 d1 = d11 & d12;
 d2 = d21 & d22;
 if (d1 != d2)
  return true;

 d11 = getDigit(ip1.value,4);
 d12 = getDigit(mask1.value, 4);
 d21 = getDigit(ip2.value,4);
 d22 = getDigit(mask2.value,4);
 d1 = d11 & d12;
 d2 = d21 & d22;
 if (d1 != d2)
  return true;

 return false;
}

function checkIP(ip)
{
 if (ip.value=="") {
  alert("<% multilang("1637" "LANG_INVALID_IPV4_ADDR_SHOULD_NOT_EMPTY"); %>");
  ip.value = ip.defaultValue;
  ip.focus();
  return false;
 }
 if ( validateKey( ip.value ) == 0 ) {
  alert("<% multilang("1638" "LANG_INVALID_IPV4_ADDR_SHOULD_BE_DECIMAL_NUM"); %>");
  ip.value = ip.defaultValue;
  ip.focus();
  return false;
 }

 if( IsLoopBackIP( ip.value)==1 ) {
  alert("<% multilang("1639" "LANG_INVALID_IPV4_ADDR"); %>");
  ip.value = ip.defaultValue; // Jenny,  Buglist B058, backward default value
  ip.focus();
  return false;
 }

 if ( !checkDigitRange(ip.value,1,0,255) ) {
  alert("<% multilang("1640" "LANG_INVALID_IPV4_ADDR_1ST_DIGIT"); %>");
  ip.value = ip.defaultValue;
  ip.focus();
  return false;
 }
 if ( !checkDigitRange(ip.value,2,0,255) ) {
  alert("<% multilang("1641" "LANG_INVALID_IPV4_ADDR_2ND_DIGIT"); %>");
  ip.value = ip.defaultValue;
  ip.focus();
  return false;
 }
 if ( !checkDigitRange(ip.value,3,0,255) ) {
  alert("<% multilang("1642" "LANG_INVALID_IPV4_ADDR_3RD_DIGIT"); %>");
  ip.value = ip.defaultValue;
  ip.focus();
  return false;
 }
 if ( !checkDigitRange(ip.value,4,1,254) ) {
  alert("<% multilang("1643" "LANG_INVALID_IPV4_ADDR_4TH_DIGIT"); %>");
  ip.value = ip.defaultValue;
  ip.focus();
  return false;
 }

 return true;
}

function checkHostIP(ip, checkEmpty)
{
 if (checkEmpty == 1 && ip.value=="") {
  alert("<% multilang("1637" "LANG_INVALID_IPV4_ADDR_SHOULD_NOT_EMPTY"); %>");
  ip.value = ip.defaultValue;
  ip.focus();
  return false;
 }
 if (validateKey(ip.value) == 0) {
  alert("<% multilang("1638" "LANG_INVALID_IPV4_ADDR_SHOULD_BE_DECIMAL_NUM"); %>");
  ip.value = ip.defaultValue;
  ip.focus();
  return false;
 }

 if (IsLoopBackIP(ip.value)==1 || IsInvalidIP(ip.value)==1) {
  alert("<% multilang("1639" "LANG_INVALID_IPV4_ADDR"); %>");
  ip.value = ip.defaultValue;
  ip.focus();
  return false;
 }

 if (!checkDigitRange(ip.value, 1, 1, 223)) {
  alert("<% multilang("1640" "LANG_INVALID_IPV4_ADDR_1ST_DIGIT"); %>");
  ip.value = ip.defaultValue;
  ip.focus();
  return false;
 }
 if (!checkDigitRange(ip.value, 2, 0, 255)) {
  alert("<% multilang("1641" "LANG_INVALID_IPV4_ADDR_2ND_DIGIT"); %>");
  ip.value = ip.defaultValue;
  ip.focus();
  return false;
 }
 if (!checkDigitRange(ip.value, 3, 0, 255)) {
  alert("<% multilang("1642" "LANG_INVALID_IPV4_ADDR_3RD_DIGIT"); %>");
  ip.value = ip.defaultValue;
  ip.focus();
  return false;
 }
 if (!checkDigitRange(ip.value, 4, 0, 254)) {
  alert("<% multilang("1643" "LANG_INVALID_IPV4_ADDR_4TH_DIGIT"); %>");
  ip.value = ip.defaultValue;
  ip.focus();
  return false;
 }

 return true;
}

function checkNetIP(ip, checkEmpty)
{
 if (checkEmpty == 1 && ip.value=="") {
  alert("<% multilang("1637" "LANG_INVALID_IPV4_ADDR_SHOULD_NOT_EMPTY"); %>");
  ip.value = ip.defaultValue;
  ip.focus();
  return false;
 }
 if (validateKey(ip.value) == 0) {
  alert("<% multilang("1638" "LANG_INVALID_IPV4_ADDR_SHOULD_BE_DECIMAL_NUM"); %>");
  ip.value = ip.defaultValue;
  ip.focus();
  return false;
 }

 if (IsLoopBackIP(ip.value)==1 || IsInvalidIP(ip.value)==1) {
  alert("<% multilang("1639" "LANG_INVALID_IPV4_ADDR"); %>");
  ip.value = ip.defaultValue;
  ip.focus();
  return false;
 }

 if (!checkDigitRange(ip.value, 1, 0, 255)) {
  alert("<% multilang("1640" "LANG_INVALID_IPV4_ADDR_1ST_DIGIT"); %>");
  ip.value = ip.defaultValue;
  ip.focus();
  return false;
 }
 if (!checkDigitRange(ip.value, 2, 0, 255)) {
  alert("<% multilang("1641" "LANG_INVALID_IPV4_ADDR_2ND_DIGIT"); %>");
  ip.value = ip.defaultValue;
  ip.focus();
  return false;
 }
 if (!checkDigitRange(ip.value, 3, 0, 255)) {
  alert("<% multilang("1642" "LANG_INVALID_IPV4_ADDR_3RD_DIGIT"); %>");
  ip.value = ip.defaultValue;
  ip.focus();
  return false;
 }
 if (!checkDigitRange(ip.value, 4, 0, 255)) {
  alert("<% multilang("1643" "LANG_INVALID_IPV4_ADDR_4TH_DIGIT"); %>");
  ip.value = ip.defaultValue;
  ip.focus();
  return false;
 }

 return true;
}

function checkNetmask(netmask, checkEmpty)
{
 var i, d;

 if (checkEmpty == 1 && netmask.value == "") {
  alert("<% multilang("1644" "LANG_INVALID_IPV4_SUBNET_SHOULD_NOT_EMPTY"); %>");
  netmask.value = netmask.defaultValue;
  netmask.focus();
  return false;
 }

 if (validateKey(netmask.value) == 0) {
  alert("<% multilang("1645" "LANG_INVALID_IPV4_SUBNET_SHOULD_BE_DECIMAL_NUM"); %>");
  netmask.value = netmask.defaultValue;
  netmask.focus();
  return false;
 }

 for (i=1; i<=4; i++) {
  d = getDigit(netmask.value, i);
  if( !(d==0 || d==128 || d==192 || d==224 || d==240 || d==248 || d==252 || d==254 || d==255 )) {
   alert("<% multilang("1646" "LANG_INVALID_IPV4_SUBNET_DIGIT"); %>");
   netmask.focus();
   return false;
  }
 }

 return true;
}

function checkMask(netmask)
{
 var i, d;

 if (netmask.value == "") {
  alert("<% multilang("1644" "LANG_INVALID_IPV4_SUBNET_SHOULD_NOT_EMPTY"); %>");
  netmask.value = netmask.defaultValue;
  netmask.focus();
  return false;
 }

 if (validateKey(netmask.value) == 0) {
  alert("<% multilang("1645" "LANG_INVALID_IPV4_SUBNET_SHOULD_BE_DECIMAL_NUM"); %>");
  netmask.value = netmask.defaultValue;
  netmask.focus();
  return false;
 }

 for (i=1; i<=4; i++) {
  d = getDigit(netmask.value, i);
  if (!(d==0 || d==128 || d==192 || d==224 || d==240 || d==248 || d==252 || d==254 || d==255)) {
   alert("<% multilang("1646" "LANG_INVALID_IPV4_SUBNET_DIGIT"); %>");
   netmask.focus();
   return false;
  }
 }

 return true;
}

function checkMac(macAddr, checkEmpty)
{
 var i, macdigit = 0;

 if (checkEmpty == 1 && macAddr.value.length == 0) {
  alert("<% multilang("1647" "LANG_INVALID_MAC_ADDR_SHOULD_NOT_EMPTY"); %>");
  return false;
 }

 if (macAddr.value.length > 0 && macAddr.value.length < 12) {
  alert("<% multilang("1648" "LANG_INVALID_MAC_ADDR_NOT_COMPLETE"); %>");
  macAddr.focus();
  return false;
 }

 if (macAddr.value.length == 0)
  macdigit = -1;
 for (i=0; i<macAddr.value.length; i++) {
  if ((macAddr.value.charAt(i) == 'f') || (macAddr.value.charAt(i) == 'F'))
   macdigit ++;
  else
   continue;
 }

 if (macdigit == macAddr.value.length || macAddr.value == "000000000000") {
  alert("<% multilang("1649" "LANG_INVALID_MAC_ADDR"); %>");
  macAddr.focus();
  return false;
 }

 for (i=0; i<macAddr.value.length; i++) {
  if ((macAddr.value.charAt(i) >= '0' && macAddr.value.charAt(i) <= '9') ||
   (macAddr.value.charAt(i) >= 'a' && macAddr.value.charAt(i) <= 'f') ||
   (macAddr.value.charAt(i) >= 'A' && macAddr.value.charAt(i) <= 'F') )
   continue;
  alert("<% multilang("1650" "LANG_INVALID_MAC_ADDR_SHOULD_BE"); %>");
  macAddr.focus();
  return false;
 }
 return true;
}

function checkHex(str)
{
 for (var i=0; i<str.length; i++) {
  if((str.charAt(i) >= '0' && str.charAt(i) <= '9') || (str.charAt(i) >= 'A' && str.charAt(i) <= 'F') || (str.charAt(i) >= 'a' && str.charAt(i) <= 'f') )
   continue;
  return 0;
 }
 return 1;
}

function includeSpace(str)
{
  for (var i=0; i<str.length; i++) {
   if ( str.charAt(i) == ' ' ) {
   return true;
 }
  }
  return false;
}

function checkPrintableString(str)
{
 for (var i=0; i<str.length; i++) {
  //if ((str.charAt(i) >= '0' && str.charAt(i) <= '9') || (str.charAt(i) >= 'A' && str.charAt(i) <= 'Z') || (str.charAt(i) >= 'a' && str.charAt(i) <= 'z') ||
  //   (str.charAt(i) == '.') || (str.charAt(i) == ':') || (str.charAt(i) == '-') || (str.charAt(i) == '_') || (str.charAt(i) == ' ') || (str.charAt(i) == '/') || (str.charAt(i) == '@'))
  if((str.charAt(i) >= ' ') && (str.charAt(i) <= '~'))
   continue;
  return 0;
 }
 return 1;
}

function checkString(str)
{
 for (var i=0; i<str.length; i++) {
  if ((str.charAt(i) >= '0' && str.charAt(i) <= '9') || (str.charAt(i) >= 'A' && str.charAt(i) <= 'Z') || (str.charAt(i) >= 'a' && str.charAt(i) <= 'z') ||
     (str.charAt(i) == '.') || (str.charAt(i) == ':') || (str.charAt(i) == '-') || (str.charAt(i) == '_') || (str.charAt(i) == ' ') || (str.charAt(i) == '/') || (str.charAt(i) == '@'))
   continue;
  return 0;
 }
 return 1;
}

function deleteClick()
{
 if ( !confirm('<% multilang("1651" "LANG_CONFIRM_DELETE_ONE_ENTRY"); %>') ) {
  return false;
 }
 else
  return true;
}

function deleteAllClick()
{
 if ( !confirm('Do you really want to delete the all entries?') ) {
  return false;
 }
 else
  return true;
}

function delClick(index)
{
 if ( !confirm('<% multilang("1653" "LANG_CONFIRM_DELETE"); %>') ) {
  return false;
 }

 document.actionForm.action.value=0;
 document.actionForm.idx.value=index;
 document.actionForm.submit();
 return true;
}

function editClick(index)
{
 document.actionForm.action.value=1;
 document.actionForm.idx.value=index;
 document.actionForm.submit();
 return true;
}

function verifyBrowser() {
 var ms = navigator.appVersion.indexOf("MSIE");
 ie4 = (ms>0) && (parseInt(navigator.appVersion.substring(ms+5, ms+6)) >= 4);
 var ns = navigator.appName.indexOf("Netscape");
 ns= (ns>=0) && (parseInt(navigator.appVersion.substring(0,1))>=4);
 if (ie4)
  return "ie4";
 else
  if(ns)
   return "ns";
  else
   return false;
}

function isBrowser(b,v) {
 browserOk = false;
 versionOk = false;

 browserOk = (navigator.appName.indexOf(b) != -1);
 if (v == 0) versionOk = true;
 else versionOk = (v <= parseInt(navigator.appVersion));
 return browserOk && versionOk;
}

function disableButton (button) {
  if (document.all || document.getElementById)
    button.disabled = true;
  else if (button) {
    button.oldOnClick = button.onclick;
    button.onclick = null;
    button.oldValue = button.value;
    button.value = 'DISABLED';
  }
}

function disableButtonIB (button) {
 if (isBrowser('Netscape', 0))
  return;
 if (document.all || document.getElementById)
  button.disabled = true;
 else if (button) {
  button.oldOnClick = button.onclick;
  button.onclick = null;
  button.oldValue = button.value;
  button.value = 'DISABLED';
 }
}

function disableButtonVB (button) {
  if (verifyBrowser() == "ns")
   return;
  if (document.all || document.getElementById)
    button.disabled = true;
  else if (button) {
    button.oldOnClick = button.onclick;
    button.onclick = null;
    button.oldValue = button.value;
    button.value = 'DISABLED';
  }
}

function enableButton (button) {
  if (document.all || document.getElementById)
    button.disabled = false;
  else if (button) {
    button.onclick = button.oldOnClick;
    button.value = button.oldValue;
  }
}

function enableButtonVB (button) {
  if (verifyBrowser() == "ns")
   return;
  if (document.all || document.getElementById)
    button.disabled = false;
  else if (button) {
    button.onclick = button.oldOnClick;
    button.value = button.oldValue;
  }
}

function enableButtonIB (button) {
 if (isBrowser('Netscape', 4))
  return;
 if (document.all || document.getElementById)
  button.disabled = false;
 else if (button) {
  button.onclick = button.oldOnClick;
  button.value = button.oldValue;
 }
}

//Add is invalid message
//Function Name: alertInvalid(fieldname, fieldvalue [,additional])
//Description: alerts invalid message containing fieldname and value
//Parameters: fieldname, fieldvalue, additional - Any additional comments to be added
//Output: MessageBox(invalid message)
function alertInvalid(fieldname, fieldvalue, additional)
{
 if (additional == undefined)
  alert (fieldname + " " + fieldvalue + "<% multilang("1914" "LANG_INVALID"); %>");
 else
  alert (fieldname + " " + fieldvalue + "<% multilang("1914" "LANG_INVALID"); %>" + additional + ".");
}

//Function Name: isValidIpAddress(address[,fieldname][,type])
//Description: Check that address entered is valid ip address
//Parameters: address, 	fieldname(optional): entering will show error message when encountered
//			  type: TYPE_NETWORK_ADDRESS:check network address | TYPE_IP_ADDRESS (default) check of type IP address
//output: true:no error		false:has error
function isValidIpAddress(address,fieldname,type) {
 var i = 0;
 var c = '';
 var hasfield = false;

 if (fieldname != undefined) hasfield = true;

 if (address == "") {
  if (hasfield) alertInvalid(fieldname,address);
  return false;
 }

 for (i = 0; i < address.length; i++) {
  c = address.charAt(i);
  if ((c>='0'&&c<='9')||(c=='.'))
   continue;
  else {
   if (hasfield) alertInvalid(fieldname,address);
   return false;
  }
 }
 if (address == '0.0.0.0' ||address == '255.255.255.255') {
  if (hasfield) alertInvalid(fieldname,address);
  return false;
 }

 addrParts = address.split('.');

 // Make sure that everything is in decimal place
 for (i=0; i<addrParts.length; i++) {
  addrParts[i] = parseInt(addrParts[i], 10);
  addrParts[i] += "";
 }

 if (addrParts.length != 4) {
  if (hasfield) alertInvalid(fieldname,address);
  return false;
 }

 for (i = 0; i<4; i++) {
  if (isNaN(addrParts[i]) || addrParts[i] =="") {
   if (hasfield) alertInvalid(fieldname,address);
   return false;
  }
  num = parseInt(addrParts[i], 10);
  if (num < 0 || num > 255) {
   if (hasfield) alertInvalid(fieldname,address);
   return false;
  }
  if (addrParts[i].length > 3) {
   if (hasfield) alertInvalid(fieldname,address);
   return false;
  }
 }

 if ((type == undefined) || (type==TYPE_IP_ADDRESS)) {
  if (parseInt(addrParts[0],10)==0||parseInt(addrParts[3],10)==0||parseInt(addrParts[0],10)==127||parseInt(addrParts[0],10)>223) {
   if (hasfield) alertInvalid(fieldname,address);
   return false;
  }
 } else {
  if (type == TYPE_NETWORK_ADDRESS) {
   if ((parseInt(addrParts[0],10)==0) || (parseInt(addrParts[0],10)==127)||parseInt(addrParts[0],10)>223) {
    if (hasfield) alertInvalid(fieldname,address);
    return false;
   }
  }
 }

 return true;
}

//Function name:changeBlockState(idname,status)
//Description: This function changes the disabled and color property of elements given under id
//	Input: idname : the id of the tag or DIV, must have id property
//		   status: ENABLED | DISABLED
function changeBlockState(idname, status) {
 var i;
 var tempelems = document.getElementById(idname).getElementsByTagName("*");
 for (i = 0; i < tempelems.length; i++) {
  if (tempelems[i].disabled != undefined)
   tempelems[i].disabled = status;
 }

 // disable the element itself
 var tempelems = document.getElementById(idname);
 if (tempelems.disabled != undefined)
  tempelems.disabled = status;
}

function validateKeyV6IP(str)
{
   find_flag=0;
   account=0;

   for (var i=0; i<str.length; i++) {
    if ( (str.charAt(i) >= '0' && str.charAt(i) <= '9') ||
      (str.charAt(i) == ':' ) ||
      (str.charAt(i) >= 'A' && str.charAt(i) <= 'F')||
      (str.charAt(i) >= 'a' && str.charAt(i) <= 'f') ) {
       if ((str.charAt(i) == ':' && str.charAt(i-1) == ':') || str.charAt(i) == ':' ) {
        //find_flag = find_flag + 1;
        account = account + 1;
       }

       if ((str.charAt(i) == ':' && str.charAt(i-1) == ':')) {
        find_flag = find_flag + 1;
       }

       if (str.charAt(i) == ':' && str.charAt(i-1) == ':' && str.charAt(i-2) == ':') {
        return 0;
       }

   continue;
    }
    return 0;
  }

  // alert("find_flag="+find_flag);

  if ( find_flag > 1 || account == 1)
   return 0;

  return 1;
}


function validateKeyV6Prefix(str)
{
   find_flag=0;
   var prefix_len=0;
   var prefix_len_tmp1=0;
   var prefix_len_tmp2=0;

   for (var i=0; i<str.length; i++) {
    if ( (str.charAt(i) >= '0' && str.charAt(i) <= '9') ||
      (str.charAt(i) == ':' ) || (str.charAt(i) == '/' ) ||
      (str.charAt(i) >= 'A' && str.charAt(i) <= 'F')||
      (str.charAt(i) >= 'a' && str.charAt(i) <= 'f') ) {
       if ((str.charAt(i) == ':' && str.charAt(i-1) == ':')) {
        if ( str.charAt(i+1) != '/' ) {
         return 0;
        }
        find_flag = find_flag + 1;
       }

       if ( str.charAt(i) == '/' ) {

         if ( str.charAt(i+1) < '0' || str.charAt(i+1) > '9') {
          return 0;
         }

        if ( (i+2) < str.length ) {
          if ( str.charAt(i+2) < '0' || str.charAt(i+2) > '9') {
           return 0;
         }

         prefix_len_tmp1 = parseInt(str.charAt(i+1), 10);
         prefix_len_tmp1 = prefix_len_tmp1*10;
         prefix_len_tmp2 = parseInt(str.charAt(i+2), 10);
         prefix_len = prefix_len_tmp1 + prefix_len_tmp2;
        } else {
         prefix_len = parseInt(str.charAt(i+1), 10);
        }

        if ( prefix_len > 64 || prefix_len < 3 ) {
         return 0;
        }
       }

       if (str.charAt(i) == ':' && str.charAt(i-1) == ':' && str.charAt(i-2) == ':') {
        return 0;
       }

   continue;
    }

    return 0;
  }

  //alert("find_flag="+find_flag);

  if ( find_flag != 1 ) {
 alert("<% multilang("1654" "LANG_INVALID_IPV6_PREFIX"); %>");
   return 0;
  }

  return 1;
}

//star:20100825 IPV6_RELATED
function isIPv6(str)
{
return str.match(/:/g).length<=7
&&/::/.test(str)
?/^([\da-f]{1,4}(:|::)){1,6}[\da-f]{1,4}$/i.test(str)
:/^([\da-f]{1,4}:){7}[\da-f]{1,4}$/i.test(str);
}

function $(a) {
        return document.getElementById(a);
 }

 function isNumber(value)
{
 return /^\d+$/.test(value);
}

function ParseIpv6Array(str)
{
    var Num;
    var i,j;
    var finalAddrArray = new Array();
    var falseAddrArray = new Array();

    var addrArray = str.split(':');
    Num = addrArray.length;
    if (Num > 8)
    {
        return falseAddrArray;
    }

    for (i = 0; i < Num; i++)
    {
        if ((addrArray[i].length > 4)
            || (addrArray[i].length < 1))
        {
            return falseAddrArray;
        }
        for (j = 0; j < addrArray[i].length; j++)
        {
            if ((addrArray[i].charAt(j) < '0')
                || (addrArray[i].charAt(j) > 'f')
                || ((addrArray[i].charAt(j) > '9') &&
                (addrArray[i].charAt(j) < 'a')))
            {
                return falseAddrArray;
            }
        }

        finalAddrArray[i] = '';
        for (j = 0; j < (4 - addrArray[i].length); j++)
        {
            finalAddrArray[i] += '0';
        }
        finalAddrArray[i] += addrArray[i];
    }

    return finalAddrArray;
}

function getFullIpv6Address(address)
{
    var c = '';
    var i = 0, j = 0, k = 0, n = 0;
    var startAddress = new Array();
    var endAddress = new Array();
    var finalAddress = '';
    var startNum = 0;
    var endNum = 0;
    var lowerAddress;
    var totalNum = 0;

    lowerAddress = address.toLowerCase();

    var addrParts = lowerAddress.split('::');
    if (addrParts.length == 2)
    {
        if (addrParts[0] != '')
        {
            startAddress = ParseIpv6Array(addrParts[0]);
            if (startAddress.length == 0)
            {
                return '';
            }
        }
        if (addrParts[1] != '')
        {
            endAddress = ParseIpv6Array(addrParts[1]);
            if (endAddress.length == 0)
            {
               return '';
            }
        }

        if (startAddress.length + endAddress.length >= 8)
        {
            return '';
        }
    }
    else if (addrParts.length == 1)
    {
        startAddress = ParseIpv6Array(addrParts[0]);
        if (startAddress.length != 8)
        {
            return '';
        }
    }
    else
    {
        return '';
    }

    for (i = 0; i < startAddress.length; i++)
    {
        finalAddress += startAddress[i];
        if (i != 7)
        {
            finalAddress += ':';
        }
    }
    for (; i < 8 - endAddress.length; i++)
    {
        finalAddress += '0000';
        if (i != 7)
        {
            finalAddress += ':';
        }
    }
    for (; i < 8; i++)
    {
        finalAddress += endAddress[i - (8 - endAddress.length)];
        if (i != 7)
        {
            finalAddress += ':';
        }
    }

    return finalAddress;

}

function isIpv6Address(address)
{
    if (getFullIpv6Address(address) == '')
    {
        return false;
    }

    return true;
}


function isUnicastIpv6Address(address)
{
    var tempAddress = getFullIpv6Address(address);

    if ((tempAddress == '')
        || (tempAddress == '0000:0000:0000:0000:0000:0000:0000:0000')
        || (tempAddress == '0000:0000:0000:0000:0000:0000:0000:0001')
        || (tempAddress.substring(0, 2) == 'ff'))
    {
        return false;
    }

    return true;
}

function isGlobalIpv6Address(address)
{
    var tempAddress = getFullIpv6Address(address);

    if ((tempAddress == '')
        || (tempAddress == '0000:0000:0000:0000:0000:0000:0000:0000')
        || (tempAddress == '0000:0000:0000:0000:0000:0000:0000:0001')
        || (tempAddress.substring(0, 3) == 'fe8')
        || (tempAddress.substring(0, 3) == 'fe9')
        || (tempAddress.substring(0, 3) == 'fea')
        || (tempAddress.substring(0, 3) == 'feb')
        || (tempAddress.substring(0, 2) == 'ff'))
    {
        return false;
    }

    return true;
}

function isLinkLocalIpv6Address(address)
{
    var tempAddress = getFullIpv6Address(address);

    if ( (tempAddress.substring(0, 3) == 'fe8')
        || (tempAddress.substring(0, 3) == 'fe9')
        || (tempAddress.substring(0, 3) == 'fea')
        || (tempAddress.substring(0, 3) == 'feb'))
    {
        return true;
    }

    return false;
}

//star:20100825 IPV6_RELATED END

function sji_int(val){if(val == false) {return 0;} else if(val == true) {return 1;} else {return parseInt(val);}}

function sji_docinit(doc, cgi)
{
 var surl = doc.getElementsByName("submit-url");
 if(surl && surl.length > 0)
 {
  if(surl[0].value == "")surl[0].value = doc.location.href;
 }

 var stype = "";
 var stag = "";
 var svalue = null;

 if(typeof doc == "undefined" || typeof cgi == "undefined")return;
 for(var name in cgi)
 {
  if(typeof cgi[name] != "boolean" && typeof cgi[name] != "string" && typeof cgi[name] != "number")continue;
  svalue = cgi[name];
  var obj = doc.getElementsByName(name);
  if(typeof obj != "object")continue;
  if(obj.length == 0 || typeof obj[0].tagName == "undefined")continue;
  stag = obj[0].tagName;
  if(stag == "LABEL")
  {
   obj[0].innerHTML = svalue;
  }
  else if(stag == "TD")
  {
   obj[0].innerHTML = svalue;
  }
  else if(stag == "INPUT")
  {
   stype = obj[0].type;
   if(stype == "text" || stype == "hidden")obj[0].value = svalue;
   else if(stype == "radio")obj[sji_int(svalue)].checked = true;
   else if(stype == "checkbox")obj[0].checked = sji_int(svalue);
   else {/*warning*/}
  }
  else if(stag == "SELECT")
  {
   obj[0].value = svalue;
  }
  else {/*warning*/}
 }
}

function sji_onchanged(doc, rec)
{
 var stype = "";
 var stag = "";
 var svalue = null;

 if(typeof doc == "undefined" || typeof rec == "undefined")return;
 for(var name in rec)
 {
  if(typeof rec[name] != "boolean" && typeof rec[name] != "string" && typeof rec[name] != "number")continue;
  svalue = rec[name];
  var obj = doc.getElementsByName(name);
  if(typeof obj != "object")continue;
  if(obj.length == 0 || typeof obj[0].tagName == "undefined")continue;
  stag = obj[0].tagName;
  if(stag == "LABEL")
  {
   obj[0].innerHTML = svalue;
  }
  else if(stag == "TD")
  {
   obj[0].innerHTML = svalue;
  }
  else if(stag == "INPUT")
  {
   stype = obj[0].type;
   if(stype == "text" || stype == "hidden" || stype == "password")obj[0].value = svalue;
   else if(stype == "radio")obj[sji_int(svalue)].checked = true;
   else if(stype == "checkbox")obj[0].checked = sji_int(svalue);
   else {/*warning*/}
  }
  else if(stag == "SELECT")
  {
   obj[0].value = svalue;
  }
  else {/*warning*/}
 }
}

/********************************************************************
**          string functions
********************************************************************/

function sji_valenc(val)
{
 var text = "";
 if(typeof val == "undefined")return null;
    else if(typeof val == "string")
    {
        text = val.length + ":" + val;
    }
    else if(typeof val == "number")
    {
        text = "i" + val + "e";
    }
 else return null;

    return text;
}

function sji_valdec(text)
{
    var type = text.charAt(0);
    var len = text.length;
    var val = '\0';
    var hlen = 1;
    var hdr = "";
    var vlen = 0;
 var cnt = 1;

 if(typeof text == "undefined")return null;

    if(text.length <= 2){return null;}

 if(type == 'i')
 {
  var subtext = "";
  while(cnt < len)
  {
   val = text.charAt(cnt);
   if(val == 'e')
   {
    subtext = text.substring(1, cnt);
    cnt++;
    break;
   }
   cnt++;
  }
  if(subtext == ""){return null;}

  if(isNaN(parseInt(subtext))){return null;}

  return new it(cnt, parseInt(subtext));
 }
 else
 {
  while(hlen < len)
  {
   val = text.charAt(hlen);
   if(val == ':')
   {
    hdr = text.substring(0, hlen);
    hlen++;
    break;
   }
   hlen++;
  }
  if(hdr == ""){return null;}
  if(isNaN(parseInt(hdr))){return null;}

  vlen = parseInt(hdr);
  if((vlen + hlen) > len){vlen = len - hlen;}

  return new it(hlen + vlen, text.substring(hlen, hlen + vlen));
 }
 return null;
}

//说明：键值对
//键名称 数值 
//======================
function it(key, value)
{
 this.key = key;
 this.value = value;
 return this;
}

//-----------------------
//说明：通用结构
//名称 选中
//======================
function it_nr(name)
{
 if(typeof name == "undefined")return null;

 this.name = name;
 this.select = false;

 this.add = function(kv)
 {
  this[kv.key] = kv.value;
 }
 this.enc = function()
 {
  var strenc = "d";
  for(var k in this)
  {
   var strk = sji_valenc(k);
   if(strk == null) continue;
   var strv = sji_valenc(this[k]);
   if(strv == null) continue;
   strenc += (strk + strv);
  }
  strenc += "e";
  return strenc;
 }
 this.dec = function(strenc)
 {
  if(typeof strenc == "undefined" || strenc == null)return;
  if(strenc.charAt(0) != 'd')return;
  var cnt = 1;
  while(cnt < strenc.length)
  {
   var kvk = sji_valdec(strenc.substring(cnt, strenc.length));
   if(kvk == null)break;
   cnt += kvk.key;
   var kvv = sji_valdec(strenc.substring(cnt, strenc.length));
   if(kvv == null)break;
   cnt += kvv.key;
   this[kvk.value] = kvv.value;
  }
  if(strenc.charAt(cnt) != 'e')return; // error, not terminator
 }

 for(var i = 1; i < arguments.length; i++)
 {
  if(typeof arguments[i].key == "undefined" || typeof arguments[i].value == "undefined")continue;
  this[arguments[i].key] = arguments[i].value;
 }
 return this;
}

function validateDecimalDigit(str)
{
 for (var i=0; i<str.length; i++)
 {
  if ( str.charAt(i) >= '0' && str.charAt(i) <= '9')
   continue;
  return 0;
 }
 return 1;
}

//add by ramen
//type=1:at least one character
//type=0:may be empty

function includeCyrillicKey(str)
{
 var code;
 for (var i = 0; i < str.length; i++)
 {
/*
0x0400~0x04FF => 1024~1279
0x0500~0x052F => 1280~1327
0x2DE0~0x2DFF => 11744~11775
0xA640~0xA69F => 42560~42655
*/
  code = str.charCodeAt(i);
  if(code >= 1024 && code <= 1279)
   return true;
  if(code >= 1280 && code <= 1327)
   return true;
  if(code >= 11744 && code <= 11775)
   return true;
  if(code >= 42560 && code <= 42655)
   return true;
 }
 return false;
}
