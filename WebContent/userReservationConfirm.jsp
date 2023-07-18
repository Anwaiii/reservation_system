<%@page import="java.util.ArrayList"%>
<%@page import="model.reservationBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.util.*" session="false"%>
<% request.setCharacterEncoding("UTF-8");
HttpSession session = request.getSession(false);
if (session == null || session.getAttribute("userID") == null || (Integer)session.getAttribute("role") != 1) {
	response.sendRedirect("Login.jsp");
	return;
}
reservationBean user= (reservationBean)session.getAttribute("user");


%>
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" type="text/css"
	href="css/mouseHoverDropDownDesign.css">
<link rel="stylesheet" type="text/css"
	href="css/userReservationConfirm.css">
<link rel="stylesheet" type="text/css"
	href="css/validationEngine.jquery.css">


<script src="js/jquery-1.8.2.min.js" type="text/javascript"></script>
<script src="js/jquery.validationEngine.js" type="text/javascript"
	charset="UTF-8"></script>
<script src="js/languages/jquery.validationEngine-ja.js"
	type="text/javascript" charset="UTF-8"></script>
<script type="text/javascript">
	jQuery(document).ready(function() {
		jQuery("#userReservationConfirmFormID").validationEngine();
	});
</script>
<script type="text/javascript">
	function reservationConfirm() {
		if (window.confirm('予約を確定しますか？')) {
			var form = document.getElementById("userReservationConfirmFormID");
			form.submit();
	}
		}
</script>

<script type="text/javascript">
function TimeRangeLink(date){

		var form = document.forms[0];
		var input = document.getElementById(date);
		form.appendChild(input);
		document.body.appendChild(form);
		form.submit();

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

<script type="text/javascript">
function allReservation(){
		var form = document.forms[0];
		var input = document.getElementById("userAllReservationFormID");
		form.appendChild(input);
		document.body.appendChild(form);
		form.submit();
		}
</script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>予約システム 予約確定</title>

</head>
<body>
<form action="UserTimeRangeCon" method="get"></form>
	<h1>予約詳細</h1>
	<form action="UserAllReservationCon" method="get"><input type="hidden" name="userID" id="userAllReservationFormID"
		value="<%= user.getUserID() %>"></form>

	<ul>

		<li><a>Hello,<%= user.getUserName() %>さん </a>

			<ul class="dropdown">
				<li><a href="userPersonalPage.jsp" onclick="">個人ページ</a></li>
				<li><a href="UserCalendarCon">カレンダー</a></li>
				<li><a href="javascript:void(0)" onclick="allReservation();">全予約状況</a></li>
				<li><a href="javascript:void(0)" onclick="Logout();">ログアウト</a></li>
			</ul></li>
	</ul>

	<%
				String[] dateAndTime = (String[]) request.getAttribute("dateAndTime");
					if(dateAndTime != null){
						String date = dateAndTime[0];
						int time = Integer.parseInt(dateAndTime[1]);

				%>

	<div class="href">
	<a href="javascript:void(0)" onclick="TimeRangeLink('<%= date %>')">＜時間帯画面</a>
	<a></a>
</div><br><br>

	<form action="UserReservationConfirmCon" method="post"
		id="userReservationConfirmFormID" name="userReservationConfirmFormID">

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
					<td colspan="2">&nbsp<input type="hidden" name="date" value="<%= date %>"
					 id="<%= date %>"><%= date %></td>

				</tr>
				<tr>
					<td>時間帯</td>
					<td colspan="2">&nbsp<input type="hidden" name="time"
					value="<%= time %>"><%= time %>:00~<%= time+1 %>:00</td>
				</tr>
				<% } %>
				<tr>
					<td>名前</td>
					<td colspan=2>&nbsp<input type="hidden" name="userID"
					value="<%=user.getUserID() %>"><%= user.getUserName() %></td>
				</tr>
				<tr>
					<td>電話番号</td>
					<td colspan="2">&nbsp<%= user.getUserPhoneNumber() %></td>
				</tr>
				<tr>
					<td>メール</td>
					<td colspan="2">&nbsp<%= user.getUserEmail() %></td>
				</tr>

			</tbody>
		</table>
		<br>
		<br>
		<div class="buttonall">
			<input type="button" value="予約確定" class="button" onclick="reservationConfirm();"
			id="reservationConfirmButton">
		</div>
	</form>


</body>
</html>