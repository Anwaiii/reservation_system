<%@page import="model.reservationBean"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.util.*" session="false"%>
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" type="text/css"	href="css/mouseHoverDropDownDesign.css">
<link rel="stylesheet" type="text/css" href="css/SignUp.css">
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
	function noSignUp() {
		if (window.confirm('登録せずにログイン画面へ戻りますか？')) {
			window.location = "Login.jsp"
		} else {
			return false;
		}
	}
</script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>予約システム 新規登録</title>

</head>
<body>
	<script defer src="js/click.js" type="text/javascript" charset="UTF-8"></script>
	<h1>新規登録画面</h1>

	<%
		Integer signUpResult = (Integer) request.getAttribute("signUpResult");
		reservationBean user = (reservationBean) request.getAttribute("user");
		if(user == null){
			user = new reservationBean();
			user.setUserID("");
			user.setUserName("");
			user.setUserAddress("");
			user.setUserPhoneNumber("");
			user.setUserEmail("");
		}

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

<div class="href">
		<a href="javascript:void(0)" onclick="noSignUp();">ログイン画面へ</a> <a
			href=""></a>
	</div>

<br>
	<form action="SignUpCon" method="post" id="signUpFormID" autocomplete="off">
		<table border=1>
			<caption>登録情報</caption>

			<tr>
				<th colspan="2">会員登録</th>

			</tr>
			<tr>
				<td style="font-weight: bold;">ユーザID</td>
				<td><input type="text" name="userID" size="30" value="<%= user.getUserID() %>"
					class="validate[required],[maxSize[16]],custom[onlyLetterNumber]"></td>
			</tr>
			<tr>
				<td style="font-weight: bold;">パスワード</td>
				<td><input type="password" name="password" size="30"
					class="validate[required],[minSize[6],][maxSize[16]]"></td>
			</tr>

			<tr>
				<td style="font-weight: bold;">パスワード(再確認)</td>
				<td><input type="password" name="passwordConfirm" size="30"
				class="validate[required]"></td>
			</tr>

			<tr>
				<td style="font-weight: bold;">氏名</td>
				<td><input type="text" name="userName" size="30" value="<%= user.getUserName() %>"
					class="validate[required],[maxSize[20]]"></td>
			</tr>

			<tr>
				<td style="font-weight: bold;">住所</td>
				<td><input type="text" name="userAddress" size="50" value="<%= user.getUserAddress() %>"
					class="validate[required],[maxSize[100]]"></td>
			</tr>

			<tr>
				<td style="font-weight: bold;">電話番号</td>
				<td><input type="text" name="userPhoneNumber" size="30"
					placeholder="例: 08912345678" value="<%= user.getUserPhoneNumber() %>"
					class="validate[required],[minSize[11]],[maxSize[11]],custom[number]"></td>
			</tr>

			<tr>
				<td style="font-weight: bold;">メール</td>
				<td><input type="text" name="userEmail" size="50" value="<%= user.getUserEmail() %>"
					class="validate[required],[maxSize[50]]"></td>
			</tr>



		</table>
		<br>

		<div class="buttonall">
			<input type="submit" value="新規登録" class="button" id="signUp">

		</div>
	</form>










</body>
</html>