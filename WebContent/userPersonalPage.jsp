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
	href="css/userPersonalPage.css">
<link rel="stylesheet" type="text/css"
	href="css/validationEngine.jquery.css">


<script src="js/jquery-1.8.2.min.js" type="text/javascript"></script>
<script src="js/jquery.validationEngine.js" type="text/javascript"
	charset="UTF-8"></script>
<script src="js/languages/jquery.validationEngine-ja.js"
	type="text/javascript" charset="UTF-8"></script>
<script type="text/javascript">
	jQuery(document).ready(function() {
		jQuery("#userPersonalPageConFormID").validationEngine();
	});
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

<script type="text/javascript">
	function Logout() {
		if (window.confirm("ログアウトしますか？")) {
			window.location.replace('Logout');
			return false;
		}
	}
</script>

<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>個人ページ</title>

</head>
<body>
<form action="UserAllReservationCon" method="get"><input type="hidden" name="userID" id="userAllReservationFormID"
		value="<%= user.getUserID() %>"></form>

<ul>
		会員ページ 基本情報
		<li style="float:right;"><a><%= user.getUserName() %></a>
			<ul class="dropdown">
				<li><a href="UserCalendarCon">カレンダー</a></li>
				<li><a href="javascript:void(0)" onclick="allReservation();">全予約状況</a></li>
				<li><a href="javascript:void(0)" onclick="Logout();">ログアウト</a></li>
			</ul></li>
			</ul>
<% String userID = (String) request.getAttribute("userID");
	   if(userID == null){userID="";}%>
	<div class="message">
		&nbsp
		<!-- このspaceキーは詳細/更新/削除の出力結果メッセージの位置を確保するために据えるものです %-->
		<%
			Integer message = (Integer) request.getAttribute("message");
			if (message != null) {
				if (message == 1) {
		%>
		<span class="success">情報を更新しました&nbsp</span>
		<%
			}else { %>
				<span class="fail">更新失敗しました&nbsp</span>
		<%}} %>

	</div>
	<br><br>

<div class="href">
			<a href=""></a><a href="userPasswordChange.jsp">パスワード変更へ</a>
</div>


	<br>
<form action="UserPersonalPageCon" method="post" id="userPersonalPageConFormID">

<table border="1">

<tbody>
			<tr>
				<td style="font-weight: bold;">ユーザーID</td>
				<td>&nbsp<input type="text" name="userID" id="<%= user.getUserID()%>"
				value ="<%= user.getUserID()%>" readonly></td>
			</tr>

			<tr>
				<td style="font-weight: bold;">名前</td>
				<td>&nbsp<input type="text"	name="userName" size="30" value="<%= user.getUserName() %>"
					class="validate[required],[maxSize[20]]"></td>
			</tr>

			<tr>
				<td style="font-weight: bold;">住所</td>
				<td>&nbsp<input type="text" name="userAddress" size="50" value="<%= user.getUserAddress() %>"
					class="validate[required],[maxSize[100]]"></td>
			</tr>

			<tr>
				<td style="font-weight: bold;">電話番号</td>
				<td>&nbsp<input type="text" name="userPhoneNumber" size="30" value="<%= user.getUserPhoneNumber() %>"
					class="validate[required],[maxSize[11]],custom[number],[min[0]]"></td>
			</tr>

			<tr>
				<td style="font-weight: bold;">メール</td>
				<td>&nbsp<input type="email" name="userEmail" size="30" value="<%= user.getUserEmail() %>"
					class="validate[required],[maxSize[50]]"></td>
			</tr>

		</tbody>

</table>
	<br>
		<div class="buttonall">
			<input type="submit" value="更　新" class="button" id="updateButton">&nbsp&nbsp&nbsp&nbsp
			<input type="reset" value="リセット" class="button" id="resetButton">
		</div>


</form>




</body>
</html>