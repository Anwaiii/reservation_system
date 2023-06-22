<%@page import="model.reservationBean"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.util.*" session="false"%>
<% request.setCharacterEncoding("UTF-8");
HttpSession session = request.getSession(false);
if (session == null || session.getAttribute("userID") == null) {
	response.sendRedirect("Login.jsp");
	return;
}
	reservationBean userSession = (reservationBean)session.getAttribute("user");


%>
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" type="text/css" href="css/mouseHoverDropDownDesign.css">
<link rel="stylesheet" type="text/css" href="css/userTimeRange.css">
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
	function deleteConfirm() {
		if (window.confirm('削除しますか？')) {
			window.location = "Login.jsp"
		} else {
			return false;
		}
	}
</script>
<script type="text/javascript">
function Logout(){
	if(window.confirm("ログアウトしますか？")){
		window.location.replace('Logout');
		return false;
	}
}
</script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>予約システム 時間帯</title>
<script type="text/javascript">
$(function(){
    $(".test02").css("color","green")
});
</script>
</head>
<body>
<h1> 予約状況 </h1>


<ul>
		<%
	 	reservationBean user= (reservationBean)session.getAttribute("user");
	 	%>
			<li><a>Hello,<%= userSession.getUserName() %>さん
		</a>

			<ul class="dropdown">
				<li><a href="userCalendar.jsp">カレンダー</a></li>
				<li><a href="userAllReservation.jsp">全予約状況</a></li>
				<li><a href="javascript:void(0)" onclick="Logout();">ログアウト</a></li>
			</ul></li>
	</ul>
		<br><br><br><br>


	 <table border="1">
	 <caption>
		時間帯を選んでください
	 </caption>


<tbody>
<%  ArrayList<String> reservationResult = (ArrayList) request.getAttribute("reservationResult");
    	if(reservationResult != null){

    		for(int i=10;i<=16;i++){ %>
    			<tr>
    			<% if(!reservationResult.contains(""+i)){
    				%>

    			<td><a href="userReservationConfirm.jsp">
    			<%= i %> :00~<%= i+1 %>:00</a>（予約可能）</td>
    			<% }else{ %>
    			<td><%= i %>:00~<%= i+1 %>:00（予約済み）</td>


    			<% } %>
    			</tr>
    			 <% }} %>




</tbody>
 </table>


</body>
</html>