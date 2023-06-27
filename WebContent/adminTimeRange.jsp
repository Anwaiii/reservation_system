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
<link rel="stylesheet" type="text/css" href="css/adminTimeRange.css">
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
function reservationDetailLink(date){

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
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>予約システム 管理者時間帯画面</title>

</head>
<body>
	<h1>時間帯(管理者)</h1>
<form action="Admin_userReservationDetailCon" method="get"></form>

	<ul>
		<%
		String date = (String) request.getAttribute("date");
		%>
		<li><a>Hello,<%= user.getUserName() %>さん </a>

			<ul class="dropdown">
				<li><a href="AdminCalendarCon">カレンダー</a></li>
				<li><a href="adminCreateUser.jsp">ユーザー追加画面</a></li>
				<li><a href="adminUpdateUser.jsp">ユーザー更新画面</a></li>
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
		<span class="success">予約を削除しました。&nbsp</span>

		<% }else if(message == 2){ %>
		<span class="success">予約を変更しました。&nbsp</span>

		<% }else if(message == 0){ %>
			<span class="fail">予約変更が失敗しました。&nbsp</span>
		<%
			}else{
		%>
		<span class="fail">削除が失敗しました。&nbsp</span>
		<% }} %>
		</div>
	<br>
	<br>


 <table border="1">
	 <caption>
		<%= date %>の時間帯を選んでください
	 </caption>

<tbody>
<%  ArrayList<String> reservationResult = (ArrayList) request.getAttribute("reservationResult");


    	if(reservationResult != null && date != null){

    		for(int i=10;i<=16;i++){ %>
    			<tr>
    			<%
    			// 10時~16時の中で予約が入っている時間帯を確認できる。リンクをクリックできる。
    			if(reservationResult.contains(""+i)){
    				%>

    			<td><input type="hidden" name="reservationDetail" value="<%= date+" "+i%>" id="<%=i%>">
    			<a href="javascript:void(0)" onclick="reservationDetailLink(<%=i%>);">
    			<%= i %>:00~<%= i+1 %>:00</a>（予約詳細）
    			</td>

    			<% //予約が入っていないは時間帯を確認できない。リンクもクリックできない。
    			}else{ %>
    			<td><%= i %>:00~<%= i+1 %>:00（予約なし）</td>


    			<% } %>
    			</tr>
    			 <% }} %>




</tbody>
 </table>















</body>
</html>