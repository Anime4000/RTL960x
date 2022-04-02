<!DOCTYPE html>
<html>
<!-- Copyright (c) Realtek Semiconductor Corp., 2003. All Rights Reserved. -->
<head>
<meta http-equiv="Content-Type" content="text/html" charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>XPON ONU SFP Stick</title>
<link rel="stylesheet" href="/style/default.css">
<style>
body, html {
  height: 100%;
  margin: 0;
  overflow: hidden;
background-color: #330033;
background-image: url("data:image/svg+xml,%3Csvg xmlns='http://www.w3.org/2000/svg' width='400' height='400' viewBox='0 0 800 800'%3E%3Cg fill='none' stroke='%23404' stroke-width='1'%3E%3Cpath d='M769 229L1037 260.9M927 880L731 737 520 660 309 538 40 599 295 764 126.5 879.5 40 599-197 493 102 382-31 229 126.5 79.5-69-63'/%3E%3Cpath d='M-31 229L237 261 390 382 603 493 308.5 537.5 101.5 381.5M370 905L295 764'/%3E%3Cpath d='M520 660L578 842 731 737 840 599 603 493 520 660 295 764 309 538 390 382 539 269 769 229 577.5 41.5 370 105 295 -36 126.5 79.5 237 261 102 382 40 599 -69 737 127 880'/%3E%3Cpath d='M520-140L578.5 42.5 731-63M603 493L539 269 237 261 370 105M902 382L539 269M390 382L102 382'/%3E%3Cpath d='M-222 42L126.5 79.5 370 105 539 269 577.5 41.5 927 80 769 229 902 382 603 493 731 737M295-36L577.5 41.5M578 842L295 764M40-201L127 80M102 382L-261 269'/%3E%3C/g%3E%3Cg fill='%23505'%3E%3Ccircle cx='769' cy='229' r='5'/%3E%3Ccircle cx='539' cy='269' r='5'/%3E%3Ccircle cx='603' cy='493' r='5'/%3E%3Ccircle cx='731' cy='737' r='5'/%3E%3Ccircle cx='520' cy='660' r='5'/%3E%3Ccircle cx='309' cy='538' r='5'/%3E%3Ccircle cx='295' cy='764' r='5'/%3E%3Ccircle cx='40' cy='599' r='5'/%3E%3Ccircle cx='102' cy='382' r='5'/%3E%3Ccircle cx='127' cy='80' r='5'/%3E%3Ccircle cx='370' cy='105' r='5'/%3E%3Ccircle cx='578' cy='42' r='5'/%3E%3Ccircle cx='237' cy='261' r='5'/%3E%3Ccircle cx='390' cy='382' r='5'/%3E%3C/g%3E%3C/svg%3E");

}
font{font-family: monospace, monospace;}
.nfo{font-family: sans-serif; font-size: 8pt; color: #fff; padding-right: 8pt;}
.td1{width:150px}
.btn{width:100px}
</style>
<script src="md5.js" type="text/javascript"></script>
<script>
function setpass()
{
 <% passwd2xmit(); %>
}
function mlhandle()
{
 with ( document.forms[0] ) {
  sec_lang.value="1";
  submit();
 }
}
</script>
</head>
<body>
<blockquote>
<form action=/boaform/admin/formLogin method=POST name="cmlogin">
<input type="hidden" name="challenge">
<!-- //remove by abner for bug#0000688 on 2017-09-29
<table cellSpacing=0 cellPadding=0 width="100%" border=0>
  <tbody>
  <tr vAlign=top>
    <td width="50%"><A><IMG height=60 src="LoginFiles/realtek.jpg" width=170 useMap=#n1E6.$Body.0.1E8 border=0></A></td>
  </tr>
  </tbody>
</table>
-->
<table width="50%" height="25%" align="center" valign="middle">
<tr>
 <td width="25%"></td>
 <td width="50%"></td>
 <td width="25%"></td>
</tr>
</table>
<table width="480" border="0" cellpadding="0" cellspacing="0" bgcolor="#666" align="center" >
 <tr height="35">
  <td align="center" style="font-weight: bold;color:#FFFFFF;font-size:24px;"><% multilang(LAN_LOGIN); %></td>
 </tr>
</table>
<center>
  <table cellSpacing=0 cellPadding=0 border=0 bgcolor="#FFFFFF" style="padding-bottom: 25pt">
    <tbody>
      <tr vAlign=top>
        <td width=480><br>
          <table cellSpacing=0 cellPadding=0 width="100%" border=0>
            <tbody>
              <tr vAlign=top>
                <td vAlign=center width="29%"><div align=right><svg xmlns="http://www.w3.org/2000/svg"  viewBox="0 0 48 48" width="32px" height="32px"><path fill="#c48c00" d="M44,37H4v5c0,1.105,0.895,2,2,2h36c1.105,0,2-0.895,2-2V37z"/><linearGradient id="mqGAn~AfKUNcLhPwXVdula" x1="24" x2="24" y1="15.647" y2="-.296" gradientUnits="userSpaceOnUse"><stop offset="0" stop-color="#92a3b0"/><stop offset=".015" stop-color="#a3b5c4"/><stop offset=".032" stop-color="#aec2d1"/><stop offset=".046" stop-color="#b2c6d6"/></linearGradient><path fill="url(#mqGAn~AfKUNcLhPwXVdula)" d="M11,13v3h4v-3c0-4.971,4.029-9,9-9h0c4.971,0,9,4.029,9,9v3h4v-3c0-7.18-5.82-13-13-13h0	C16.82,0,11,5.82,11,13z"/><path fill="#fad500" d="M44,23H4v-5c0-1.105,0.895-2,2-2h36c1.105,0,2,0.895,2,2V23z"/><rect width="40" height="7" x="4" y="23" fill="#edbe00"/><rect width="40" height="7" x="4" y="30" fill="#e3a600"/><linearGradient id="mqGAn~AfKUNcLhPwXVdulb" x1="24" x2="24" y1="35.373" y2="27.155" gradientUnits="userSpaceOnUse"><stop offset="0" stop-color="#4b4b4b"/><stop offset="1" stop-color="#3b3b3b"/></linearGradient><path fill="url(#mqGAn~AfKUNcLhPwXVdulb)" d="M27,29c0-1.657-1.343-3-3-3s-3,1.343-3,3c0,1.304,0.837,2.403,2,2.816V35c0,0.552,0.448,1,1,1	s1-0.448,1-1v-3.184C26.163,31.403,27,30.304,27,29z"/></svg></div></td>
                <td vAlign=center width="5%"></td>
                <td vAlign=center width="71%"><font color=#0000FF size=2><% multilang("736" "LANG_INPUT_USERNAME_AND_PASSWORD"); %></font><br><br></td>
              </tr>
              <tr vAlign=top>
                <td vAlign=center width="38%"><div align=right><font color=#525859 size=4><% multilang("1077" "LANG_USERNAME"); %>:</font></div></td>
                <td vAlign=center width="3%"></td>
                <td vAlign=center width="75%"><font><input class=td1 maxLength=30 size=20 name=username value=admin></font></td>
              </tr>
              <tr vAlign=top>
                <td vAlign=center width="38%"><div align=right><font color=#525859 size=4><% multilang("63" "LANG_PASSWORD"); %>:</font></div></td>
                <td vAlign=center width="3%"></td>
                <td vAlign=center width="75%"><font><input class=td1 type=password maxLength=30 size=20 name=password></font></td>
              </tr>
              <tr vAlign=top>
                <td vAlign=center width="38%"></td>
                <td vAlign=center width="3%"></td>
                <td vAlign=center width="75%"><font size=2></font><br><input class=btn type=submit value="<% multilang("737" "LANG_LOGIN"); %>" name=save onClick=setpass()></td>
              </tr>
             <br>
            </tbody>
          </table>
        </td>
      </tr>
    </tbody>
  </table>
</center>
<table height="35" width="480" border="0" cellpadding="0" cellspacing="0" bgcolor="#666" align="center">
 <tr><td align=right><div class=nfo>// RTL960x // Mod by Anime4000</div></td></tr>
</table>
<div align=center></div>
<input type="hidden" value="/admin/login.asp" name="submit-url">
</form>
</blockquote>
<!-----------
<blockquote>
<form action=/boaform/admin/formLoginMultilang method=POST name="formML">
<center><table cellSpacing=0 cellPadding=0 border=0>
<tr><td>
 <% checkWrite("loginSelinit"); %>
</td></tr>
</table></center>
</form>
</blockquote>--------------->
</body>
</html>
