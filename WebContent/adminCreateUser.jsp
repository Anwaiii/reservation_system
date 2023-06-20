<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.util.*" session="false"%>
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" type="text/css" href="css/mouseHoverDropDownDesign.css">
<link rel="stylesheet" type="text/css" href="css/adminCreateUser.css">
<link rel="stylesheet" type="text/css"
	href="css/validationEngine.jquery.css">


<script src="js/jquery-1.8.2.min.js" type="text/javascript"></script>
<script src="js/jquery.validationEngine.js" type="text/javascript"
	charset="UTF-8"></script>
<script src="js/languages/jquery.validationEngine-ja.js"
	type="text/javascript" charset="UTF-8"></script>
<script type="text/javascript">
	jQuery(document).ready(function() {
		jQuery("#signUpFormID").validationEngine();
	});
</script>
<script type="text/javascript">
function Logout(){
	if(window.confirm("ログアウトしますか？")){
		window.location.replace('Logout');
		return false;
	}
}
</script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>予約システム ユーザー追加画面</title>
<script type="text/javascript">
$(function(){
    $(".test02").css("color","green")
});
</script>
</head>
<body>
<h1>ユーザ追加(管理者)</h1>


<ul>
		<% /*
		System.out.println("sessionCheck");
	 	UserBean user= (UserBean)sessionCheck.getAttribute("user"); */
	 	%>
		<li><a>Hello,xxxxxxxさん
		</a>

			<ul class="dropdown">
				<li><a href="adminUpdateUser.jsp">ユーザー更新画面</a></li>
				<li><a href="adminCalendar.jsp">カレンダー画面</a></li>
				<li><a href="javascript:void(0)" onclick="Logout();">ログアウト</a></li>
			</ul></li>
	</ul>
	<br><br><br><br>

	<%
		Integer signUpResult = (Integer) request.getAttribute("signUpResult");

	%>
	<div class="message">
		&nbsp
		<!-- このspaceキーは詳細/更新/削除の出力結果メッセージの位置を確保するために据えるものです %-->
		<%
			if (signUpResult != null) {
				if (signUpResult == -1) {
		%>
		<span class="fail">✖パスワードが一致していません✖&nbsp</span>
		<%
			} else if (signUpResult == -2) {
		%>
		<span class="fail">✖ユーザIDが既に使用されています✖&nbsp</span>
		<%
			}else{
		%>
		<span class="fail">✖新規登録が失敗しました✖&nbsp</span>
		<%
			}}
		%>

	</div>

<form action="reservationConfirmCon" method="post" id="reservationConfirm_formID">

	<table border="1">


<tbody>

		<tr>
				<td style="font-weight: bold;">ユーザID</td>
				<td><input type="text" name="userID" size="30"
					class="validate[required],[maxSize[20]],custom[onlyLetterNumber]"></td>
			</tr>
			<tr>
				<td style="font-weight: bold;">パスワード</td>
				<td><input type="password" name="password" size="30"
					class="validate[required],[minSize[6],][maxSize[20]]"></td>
			</tr>

			<tr>
				<td style="font-weight: bold;">パスワード(再確認)</td>
				<td><input type="password" name="passwordConfirm" size="30"></td>
			</tr>

			<tr>
				<td style="font-weight: bold;">氏名</td>
				<td><input type="text" name="userName" size="30"
					class="validate[required],[maxSize[20]]"></td>
			</tr>

			<tr>
				<td style="font-weight: bold;">住所</td>
				<td><input type="text" name="userAddress" size="30"
					class="validate[required],[maxSize[100]]"></td>
			</tr>

			<tr>
				<td style="font-weight: bold;">電話番号</td>
				<td><input type="text" name="userPhoneNumber" size="30"
					class="validate[required],[maxSize[20]]"></td>
			</tr>

			<tr>
				<td style="font-weight: bold;">メール</td>
				<td><input type="text" name="userEmail" size="30"
					class="validate[required],[maxSize[50]]"></td>
			</tr>

		</tbody>
	</table>
	<br><br>
		<div class="buttonall">
		<input type="submit" value="登　録" class="button" id="signUpButton">
		</div>
	</form>
















</body>
</html>