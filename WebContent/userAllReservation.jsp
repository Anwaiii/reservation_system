<%@page import="java.util.ArrayList"%>
<%@page import="model.reservationBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.util.*" session="false"%>
<%
	request.setCharacterEncoding("UTF-8");
	HttpSession session = request.getSession(false);
	if (session == null || session.getAttribute("userID") == null) {
		response.sendRedirect("Login.jsp");
		return;
	}
	reservationBean user = (reservationBean) session.getAttribute("user");
%>
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" type="text/css"
	href="css/mouseHoverDropDownDesign.css">
<link rel="stylesheet" type="text/css" href="css/userAllReservation.css">
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
	function updateLink(reservationDate) {
		var form = document.forms[0];
		var input = document.getElementById(reservationDate);
		form.appendChild(input);
		document.body.appendChild(form);
		form.submit();

	}
</script>

<script type="text/javascript">
	function deleteLink(date) {
		if (window.confirm("この予約を取り消しますか？")) {
			var form = document.forms[1];
			var input = document.getElementById(date);
			form.appendChild(input);
			document.body.appendChild(form);
			form.submit();
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
<title>予約システム 全予約確認画面</title>

</head>
<body>
	<h1></h1>
	<form action="UserReservationUpdateCon" method="get"></form>
	<form action="UserAllReservationCon" method="post">
		<input type="hidden" name="userID" value="<%=user.getUserID()%>">
	</form>

	<ul>

		<li><a>Hello,<%=user.getUserName()%>さん
		</a>


			<ul class="dropdown">
				<li><a href="UserCalendarCon">カレンダー画面</a></li>
				<li><a href="javascript:void(0)" onclick="Logout();">ログアウト</a></li>
			</ul></li>
	</ul>
	<%
		Integer message = (Integer) request.getAttribute("message");
	%>
	<div class="message">
		&nbsp
		<!-- このspaceキーは詳細/更新/削除の出力結果メッセージの位置を確保するために据えるものです %-->

		<%
			if (message != null) {
				if (message == 1) {
		%>
		<span class="success">予約を取り消しました。&nbsp</span>
		<%
			} else if(message == 2){
		%>
		<span class="success">予約を変更しました。&nbsp</span>
		<% }else if(message == -1){ %>
		<span class="fail">予約変更が失敗しました。この時間帯は既に予約されています。&nbsp</span>
		<%}else{ %>
		<span class="fail">取消が失敗しました。&nbsp</span>
		<% }} %>

	</div>
	<br>
	<br>

	<table border="1">
		<caption style="font-size: 20px;">---全予約状況---</caption>
		<tbody>
			<%
				// 書式:yyyy-MM-dd HH24
				ArrayList<String> reservationResult = (ArrayList) request.getAttribute("reservationResult");
				if (reservationResult != null) {
					for (int i = 0; i < reservationResult.size(); i++) {
			%>
			<tr>
				<td><input type="hidden" name="reservationDate"
					id="<%=reservationResult.get(i)%>"
					value="<%=reservationResult.get(i)%>"> <span
					style="font-weight: 900;"><%=reservationResult.get(i)%>時&nbsp&nbsp&nbsp&nbsp</span>

					 <a	href="javascript:void(0)" onclick="updateLink('<%= reservationResult.get(i) %>');">変更</a>
					 &nbsp&nbsp&nbsp&nbsp <a
					href="javascript:void(0)"
					onclick="deleteLink('<%=reservationResult.get(i)%>');">取消</a></td>
			</tr>


			<%
				}
				}
			%>
		</tbody>



	</table>




</body>
</html>