<%@page import="model.reservationBean"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.util.*" session="false"%>
<% request.setCharacterEncoding("UTF-8");
HttpSession session = request.getSession(false);
if (session == null || session.getAttribute("userID") == null || (Integer)session.getAttribute("role") != 1) {
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
		jQuery("#admin_userReservationDetail_formID").validationEngine();
	});
</script>
<script type="text/javascript">
function allReservationLink(){

		var form = document.forms[0];
		var input = document.getElementById("userAllReservationFormID");
		form.appendChild(input);
		document.body.appendChild(form);
		form.submit();

		}
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
<title>予約システム 予約変更画面</title>

</head>
<body>
<form action="UserAllReservationCon" method="get"><input type="hidden" name="userID" id="userAllReservationFormID"
		value="<%= user.getUserID() %>"></form>

		<%
				reservationBean userInfo = (reservationBean) request.getAttribute("userInfo");
				String[] dateAndTime = (String[]) request.getAttribute("dateAndTime");
					if(userInfo != null && dateAndTime != null){
						String date = dateAndTime[0];
						int time = Integer.parseInt(dateAndTime[1]);
						String dateTime = date + " " + time;
				%>
	<ul>
		<li><a>Hello,<%= user.getUserName() %>さん</a>

			<ul class="dropdown">
				<li><a href="userPersonalPage.jsp" onclick="">個人ページ</a></li>
				<li><a href="UserCalendarCon">カレンダー</a></li>
				<li><a href="javascript:void(0)" onclick="Logout();">ログアウト</a></li>
			</ul></li>
	</ul>

<% Integer message = (Integer) request.getAttribute("message");	%>

	<div class="message">
		&nbsp
		<!-- このspaceキーは詳細/更新/削除の出力結果メッセージの位置を確保するために据えるものです %-->
		<%
			if (message != null) {
				if (message == -1) {
		%>
		<span class="fail">予約変更が失敗しました&nbsp</span>
		<% }} %>

	</div>

<div class="href">
	<a href="javascript:void(0)" onclick="allReservationLink()">＜全予約状況</a>
	<a></a>
</div>

	<br><br>
<form action="UserReservationUpdateCon" method="post" id="admin_userReservationDetail_formID"
		onsubmit="return confirm('予約変更を確定しますか?');">

	<table border="1">
		<caption></caption>

		<thead>
			<tr>
				<th colspan="3">予約詳細</th>

			</tr>

		</thead>

		<tbody>
			<tr>
			<td>予約番号</td>
			<td colspan="2">&nbsp#<%= userInfo.getBookingNO() %></td>
			</tr>
			<tr>
				<td>日付</td>
				<td colspan="2">&nbsp<input type="date" value="<%= date%>" name="date"><input type="hidden"
				name="date" value="<%=date %>" id="<%=date %>"><input type='hidden' name="beforeDateTime"
				value="<%= dateTime %>" id="<%= dateTime %>"></td>

			</tr>
			<tr>
				<td>時間帯</td>
				<td colspan="2"><p>&nbsp<select name="timeRange" id="timeRange">
							<% for(int i = 10; i <=16 ; i++){ %>
								<option value="<%=i%>" <% if(i == time){ %>selected<%} %>>
								<%= i %>:00~<%= i+1 %>:00</option>

							<% } %>
							</select></p>
				</td>
			</tr>
			<tr>
				<td>名前</td>
				<td colspan=2>&nbsp<%= userInfo.getUserName() %>
				<input type="hidden" name="userID" id="userID"
					value="<%= userInfo.getUserID() %>"></td>
			</tr>
			<tr>
				<td>住所</td>
				<td colspan=2>&nbsp<%= userInfo.getUserAddress() %></td>
			</tr>
			<tr>
				<td>電話番号</td>
				<td colspan=2>&nbsp<%= userInfo.getUserPhoneNumber() %></td>
			</tr>
			<tr>
				<td>メール</td>
				<td colspan=2>&nbsp<%= userInfo.getUserEmail() %></td>
			</tr>


		</tbody>
	</table>
	<br><br>
		<div class="buttonall">

		<%-- 例:update time_table set booking_time = '2023-06-30 10' where booking_time = '2023-06-01 10' --%>
		<input type="submit" value="予約変更" class="button" id="alterButton">&nbsp&nbsp&nbsp&nbsp
		</div>
	</form>

<%} %>

</body>
</html>