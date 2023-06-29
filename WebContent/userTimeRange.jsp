<%@page import="java.text.SimpleDateFormat"%>
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
reservationBean user= (reservationBean)session.getAttribute("user");


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
function reservationConfirmLink(date){

		var form = document.forms[0];
		var input = document.getElementById(date);
		form.appendChild(input);
		document.body.appendChild(form);
		form.submit();

		}
</script>

<script type="text/javascript">
function allReservation(){
		var form = document.forms[1];
		var input = document.getElementById("userAllReservationFormID");
		form.appendChild(input);
		document.body.appendChild(form);
		form.submit();

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

</head>
<body>
<h1> 予約状況 </h1>
<form action="UserReservationConfirmCon" method="get"></form>
<form action="UserAllReservationCon" method="get"><input type="hidden" name="userID" id="userAllReservationFormID"
		value="<%= user.getUserID() %>"></form>
<ul>
		<%
		String date = (String) request.getAttribute("date");
	 	%>
			<li><a>Hello,<%= user.getUserName() %>さん
		</a>

			<ul class="dropdown">
				<li><a href="UserCalendarCon">カレンダー</a></li>
				<li><a href="javascript:void(0)" onclick="allReservation();">全予約状況</a></li>
				<li><a href="javascript:void(0)" onclick="Logout();">ログアウト</a></li>
			</ul></li>
	</ul>
		<br><br><br><br>


	 <table border="1">
	 <caption>
		<%=date %>の時間帯を選んでください
	 </caption>


<tbody>
<%  ArrayList<String> reservationResult = (ArrayList) request.getAttribute("reservationResult");

    	if(reservationResult != null && date != null){

    		for(int i=10;i<=16;i++){

    		String beforeDateTime = date+" "+i;;
			boolean flag = false;

    		SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd HH");
    		Calendar beforeDateCalendar = Calendar.getInstance();
    		Calendar now = Calendar.getInstance();
    		beforeDateCalendar.setTime(formatter.parse(beforeDateTime));

    		%>
    			<tr>
    			<td>

				<% if(beforeDateCalendar.before(now)){ %>
    			<%}else if(!reservationResult.contains(""+i)){ %>


    			<a href="javascript:void(0)" onclick="reservationConfirmLink(<%=i%>);">
    			<%= i %>:00~<%= i+1 %>:00</a>（予約可能）<input type="hidden" name="reservationDetail"
    			value="<%= date+" "+i%>" id="<%=i%>">
    			<% }else{ %>
    			<%= i %>:00~<%= i+1 %>:00（予約済み）</td>


    			<% } %>
    			</tr>
    			 <% }}%>




</tbody>
 </table>


</body>
</html>