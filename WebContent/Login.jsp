<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.util.*" session="false"%>
<%
HttpSession session = request.getSession(false);
if(session != null && session.getAttribute("role") != null){
 Integer role = (Integer)session.getAttribute("role");
	if (role == 0) {
		response.sendRedirect("AdminCalendarCon");
	}else{
		response.sendRedirect("UserCalendarCon");
	}
}
%>
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" type="text/css"
	href="css/mouseHoverDropDownDesign.css">
<link rel="stylesheet" type="text/css" href="css/Login.css">
<link rel="stylesheet" type="text/css"
	href="css/validationEngine.jquery.css">
<script src="js/jquery-1.8.2.min.js" type="text/javascript"></script>
<script src="js/jquery.validationEngine.js" type="text/javascript"
	charset="UTF-8"></script>
<script src="js/languages/jquery.validationEngine-ja.js"
	type="text/javascript" charset="UTF-8"></script>
<script type="text/javascript">
	jQuery(document).ready(function() {
		jQuery("#loginFormID").validationEngine();
	});
</script>

<script type="text/javascript">
function signUpJSP(){
		window.location = "SignUp.jsp"
}
</script>


<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>予約システムログイン画面</title>

</head>

<body>
<script defer src="js/click.js" type="text/javascript" charset="UTF-8"></script>
	<%
		/* request.setCharacterEncoding("UTF-8");
		HttpSession sessionCheck = request.getSession(false);
		System.out.println(sessionCheck);
		if (sessionCheck != null && sessionCheck.getAttribute("userID") != null
				&& sessionCheck.getAttribute("role") != null) {
			if ((Integer) sessionCheck.getAttribute("role") == 1) {
				System.out.println("login.jsp:role1");
				response.sendRedirect("UserCalendarCon");
				return;
			} else if ((Integer) sessionCheck.getAttribute("role") == 0) {
				System.out.println("login.jsp:role0");
				response.sendRedirect("Register.jsp");
				return;
			}
		} */
	%>

	<h1>予約システム</h1>

	<%
		Integer signUpResult = (Integer) request.getAttribute("signUpResult");
		Integer loginMessage = (Integer) request.getAttribute("message");
	%>
	<div class="message">
		&nbsp
		<!-- このspaceキーは詳細/更新/削除の出力結果メッセージの位置を確保するために据えるものです %-->
		<%
			if (signUpResult != null) {
				if (signUpResult == 1) {
		%>
		<span class="success">●ユーザー登録が完了しました●&nbsp</span>
		<%
			}
			}
		%>

		<%
			if (loginMessage != null) {
				if (loginMessage <= 0) {
		%>
		<span class="fail"> ユーザID・パスワードが一致しません。&nbsp</span>
		<%
			}
			}
		%>



	</div>
	<br>
	<form action="LoginCon" method="post" id="loginFormID" autocomplete="off">
		<table border=1>


			<tr>
				<th colspan="2">会員ログイン</th>

			</tr>
			<tr>
				<td style="font-weight: bold;">ログインID</td>
				<td>&nbsp<input type="text" name="userID" size="30"
					class="validate[required],custom[onlyLetterNumber],[maxSize[16]]"></td>
			</tr>
			<tr>
				<td style="font-weight: bold;">パスワード</td>
				<td>&nbsp<input type="password" name="password" size="30"
					class="validate[required],[maxSize[16]]"></td>
			</tr>

		</table>
		<br>

		<div class="buttonall">
			<input type="submit" value="ログイン" class="button" id="loginButton">&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp
			<input type="button" value="新規登録" class="button" id="signUpButton" onclick="signUpJSP();"><br> <br>
		</div>
	</form>











</body>
</html>