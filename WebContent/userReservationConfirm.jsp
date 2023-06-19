<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.util.*" session="false"%>
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" type="text/css"
	href="css/mouseHoverDropDownDesign.css">
<link rel="stylesheet" type="text/css" href="css/userReservationConfirm.css">
<link rel="stylesheet" type="text/css"
	href="css/validationEngine.jquery.css">


<script src="js/jquery-1.8.2.min.js" type="text/javascript"></script>
<script src="js/jquery.validationEngine.js" type="text/javascript"
	charset="UTF-8"></script>
<script src="js/languages/jquery.validationEngine-ja.js"
	type="text/javascript" charset="UTF-8"></script>
<script type="text/javascript">
	jQuery(document).ready(function() {
		jQuery("#userReservationConfirm_formID").validationEngine();
	});
</script>
<script type="text/javascript">
	function deleteConfirm() {
		if (window.confirm('削除しますか？')) {
			window.location = "Login.jsp"
		} else {
			return false;
		}
	}
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
<title>予約システム 予約確定</title>
<script type="text/javascript">
	$(function() {
		$(".test02").css("color", "green")
	});
</script>
</head>
<body>
	<h1>予約確定</h1>


	<ul>
		<%
			/*
				System.out.println("sessionCheck");
			 	UserBean user= (UserBean)sessionCheck.getAttribute("user"); */
		%>
		<li><a>Hello,xxxxxxxさん </a>

			<ul class="dropdown">
				<li><a href="userCalendar.jsp">カレンダー</a></li>
				<li><a href="userAllReservation.jsp">全予約状況</a></li>
				<li><a href="javascript:void(0)" onclick="Logout();">ログアウト</a></li>
			</ul></li>
	</ul>
	<br>
	<br>
	<br>
	<br>

<form action="userReservationConfirmCon" method="post" id="userReservationConfirm_formID">

	<table border="1">
		<caption></caption>

		<thead>
			<tr>
				<th colspan="3">予約情報</th>

			</tr>

		</thead>

		<tbody>

			<tr>
				<td>日付</td>
				<td colspan="2">2023-06-13</td>

			</tr>
			<tr>
				<td>時間帯</td>
				<td colspan="2">10:00~11:00</td>

			</tr>
			<tr>
				<td>名前</td>
				<td colspan=2>wong</td>
			</tr>
			<tr>
				<td>電話番号</td>
				<td colspan="2">123-4567-8901</td>
			</tr>
			<tr>
				<td>メール</td>
				<td colspan="2">xxxxx@gmail.com</td>
			</tr>

		</tbody>
	</table>
	<br><br>
		<div class="buttonall">
		<input type="submit" value="予約確定" class="button" id="reservationConfirm">
		</div>
	</form>


</body>
</html>