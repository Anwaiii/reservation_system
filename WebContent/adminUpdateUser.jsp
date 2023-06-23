<%@page import="model.reservationBean"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.util.*" session="false"%>
<% request.setCharacterEncoding("UTF-8");
HttpSession session = request.getSession(false);
if (session == null || session.getAttribute("userID") == null ||  (Integer)session.getAttribute("role") != 0) {
	response.sendRedirect("Login.jsp");
	return;
}
	reservationBean user = (reservationBean)session.getAttribute("user");


%>
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" type="text/css"
	href="css/mouseHoverDropDownDesign.css">
<link rel="stylesheet" type="text/css" href="css/adminUpdateUser.css">
<link rel="stylesheet" type="text/css"
	href="css/validationEngine.jquery.css">


<script src="js/jquery-1.8.2.min.js" type="text/javascript"></script>
<script src="js/jquery.validationEngine.js" type="text/javascript"
	charset="UTF-8"></script>
<script src="js/languages/jquery.validationEngine-ja.js"
	type="text/javascript" charset="UTF-8"></script>
<script type="text/javascript">
	jQuery(document).ready(function() {
		jQuery("#adminUpdateUser_formID").validationEngine();
	});
</script>
<script type="text/javascript">
	function Logout() {
		if (window.confirm("ログアウトしますか？")) {
			window.location.replace('Logout');
			return false;
		}
	}
</script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>予約システム ユーザー更新画面</title>
<script type="text/javascript">
	$(function() {
		$(".test02").css("color", "green")
	});
</script>
</head>
<body>
	<h1>ユーザ更新(管理者)</h1>


	<ul>
		<%
			/*
				System.out.println("sessionCheck");
			 	UserBean user= (UserBean)sessionCheck.getAttribute("user"); */
		%>
		<li><a>Hello,<%= user.getUserName() %>さん </a>

			<ul class="dropdown">
				<li><a href="adminCreateUser.jsp">ユーザー追加画面</a></li>
				<li><a href="AdminCalendarCon">カレンダー</a></li>
				<li><a href="javascript:void(0)" onclick="Logout();">ログアウト</a></li>
			</ul></li>
	</ul>
	<br>
	<br>
	<br>
	<br>


	<form action="adminUpdateUserCon" method="get"
		id="adminUpdateUserSearch_formID">

		<div class="search" style="text-align:center;">

			<span style="font-weight: bold;">ユーザID: </span><input type="text"
				name="userID" size="30"
				class="validate[required],[maxSize[20]],custom[onlyLetterNumber]">
			<input type="submit" value="検　索" class="button" id="searchButton">

		</div>
		</form>
		<br>
		<br>

		<form action="adminUpdateUserCon" method="post"
		id="adminUpdateUser_formID">


		<table border="1">


<tbody>

			<tr>
				<td style="font-weight: bold;">名前</td>
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
			<input type="submit" value="更　新" class="button" id="updateButton">&nbsp&nbsp&nbsp&nbsp
			<input type="button" value="削　除" class="button" id="deleteButton">
		</div>
	</form>
















</body>
</html>