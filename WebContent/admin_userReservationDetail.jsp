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
<link rel="stylesheet" type="text/css" href="css/admin_userReservationDetail.css">
<link rel="stylesheet" type="text/css"
	href="css/validationEngine.jquery.css">


<script src="js/jquery-1.8.2.min.js" type="text/javascript"></script>
<script src="js/jquery.validationEngine.js" type="text/javascript"
	charset="UTF-8"></script>
<script src="js/languages/jquery.validationEngine-ja.js"
	type="text/javascript" charset="UTF-8"></script>
<script type="text/javascript">
	jQuery(document).ready(function() {
		jQuery("#admin_userReservationDetail_formID").validationEngine();
	});
</script>
<script type="text/javascript">
	function Logout() {
		if (window.confirm("ログアウトしますか?")) {
			window.location.replace('Logout');
			return false;
		}
	}
</script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>予約システム 管理者_ユーザー予約詳細画面</title>
<script type="text/javascript">
	$(function() {
		$(".test02").css("color", "green")
	});
</script>
</head>
<body>
	<h1>ユーザー予約詳細画面(管理者)</h1>


	<ul>
		<%
			/*
				System.out.println("sessionCheck");
			 	UserBean user= (UserBean)sessionCheck.getAttribute("user"); */
		%>
		<li><a>Hello,<%= user.getUserName() %>さん</a>

			<ul class="dropdown">
				<li><a href="AdminCalendarCon">カレンダー</a></li>
				<li><a href="adminCreateUser.jsp">ユーザー追加画面</a></li>
				<li><a href="adminUpdateUser.jsp">ユーザー更新画面</a></li>
				<li><a href="javascript:void(0)" onclick="Logout();">ログアウト</a></li>
			</ul></li>
	</ul>
	<br>
	<br>
	<br>
	<br>

<form action="admin_userReservationDetailCon" method="post" id="admin_userReservationDetail_formID">

	<table border="1">
		<caption></caption>

		<thead>
			<tr>
				<th colspan="3">予約詳細</th>

			</tr>

		</thead>

		<tbody>

			<tr>
				<td>日付</td>
				<td colspan="2"><input type="date" value="2023-06-13"></td>

			</tr>
			<tr>
				<td>時間帯</td>
				<td colspan="2"><p class="select"><select name="buyAmount" id="buyAmount"
						onchange='checkValue(this.value)'>
							<option value="10">10:00~11:00</option>
							<option value="11">11:00~12:00</option>
							<option value="12">12:00~13:00</option>
							<option value="13">13:00~14:00</option>
							<option value="14">14:00~15:00</option>
							<option value="15">15:00~16:00</option>
							<option value="16">16:00~17:00</option>
					</select></td>

			</tr>
			<tr>
				<td>名前</td>
				<td colspan=2> wong</td>
			</tr>
			<tr>
				<td>住所</td>
				<td colspan="2"> xxxxxxxxxxxxxxxxx</td>
			</tr>
			<tr>
				<td>電話番号</td>
				<td colspan="2"> 123-4567-8901</td>
			</tr>
			<tr>
				<td>メール</td>
				<td colspan="2">xxxxx@gmail.com</td>
			</tr>

		</tbody>
	</table>
	<br><br>
		<div class="buttonall">
		<input type="submit" value="予約変更" class="button" id="alterButton">&nbsp&nbsp&nbsp&nbsp
		<input type="button" value="予約削除" class="button" id="deleteButton">
		</div>
	</form>



</body>
</html>