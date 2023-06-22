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
<link rel="stylesheet" type="text/css" href="css/userCalendar.css">
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
function TimeRangeLink(date){
	if(window.confirm("yes/no？")){
		var form = document.forms[0];
		var input = document.getElementById(date);
		form.appendChild(input);
		document.body.appendChild(form);
		form.submit();
		return true;
	}else{
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
<title>予約システム カレンダー画面</title>

</head>
<body>
<form action="UserTimeRangeCon" method="get"></form>
<ul>
		<%
		System.out.println("sessionCheck");
	 	reservationBean user= (reservationBean)session.getAttribute("user");
	 	%>
		<li><a>Hello,<%= userSession.getUserName() %>さん
		</a>

			<ul class="dropdown">
				<li><a href="userAllReservation.jsp">全予約状況</a></li>
				<li><a href="javascript:void(0)" onclick="Logout();">ログアウト</a></li>
			</ul></li>
	</ul>
<%  Calendar calendar = Calendar.getInstance();	 //今のカレンダーを取得
		int currentYear = calendar.get(Calendar.YEAR);
		int currentMonth = calendar.get(Calendar.MONTH);
		int nextMonth = currentMonth + 1;
		calendar.set(currentYear,currentMonth,1);      //カレンダーを当月の1日にセットする
		int dayOfWeek = calendar.get(Calendar.DAY_OF_WEEK);  //	当月の1日は何曜日かを取得する
		// System.out.println(calendar.get(Calendar.DATE) +" "+ dayOfWeek);

		calendar.set(currentYear,nextMonth,1);		//	カレンダーの日付を来月の1日にセットする
		calendar.add(Calendar.DATE,-1);		//	カレンダーの日付を1日前に戻し、本月は何日があるかを求める
    	int maxDay = calendar.get(Calendar.DATE);	//	結果をmaxDayに代入する
    	// System.out.println(calendar.get(Calendar.MONTH)+" "+ maxDay);

    	String month = String.format("%02d", currentMonth+1);
    	 String date="";
    %>


	 <table border="1">
	 <caption style="font-size: 30px;">
		<a href="" style="float:left">＜</a>
		<span style="color : red; font-weight: bold;"><%= currentYear %>年  <%= currentMonth + 1 %>月</span>
	    <a href="" style="float:right">＞</a>
	 </caption>

      <tr>
        <th style="color : red">日</th>
        <th>月</th>
        <th>火</th>
        <th>水</th>
        <th>木</th>
        <th>金</th>
        <th style="color : blue">土</th>
      </tr>

 <% ArrayList<String> reservationResult = (ArrayList) request.getAttribute("reservationResult");
    	if(reservationResult != null){ %>



<tbody>
		<%
		int dayCount = 1;
		for (int rowWeek=1; rowWeek<=6; rowWeek++) { %>
		<tr>
		<%
		      for (int colWeek=1; colWeek<=7; colWeek++) {
		    	  date = currentYear+"-"+month+"-" + String.format("%02d",dayCount);
		    	  if (colWeek < dayOfWeek && rowWeek == 1) {
		      %>
		      <td></td>
		      <%  }else if(dayCount <= maxDay){ %>
		      		<td><input type="hidden" name="date"
						value="<%= date %>" id="<%= dayCount %>">
		      			<% if(colWeek == 1){ %>
		      				<b style="color : red"><%= dayCount %></b><br><br>
		      			<% }else if(colWeek == 7){ %>
			  				<b style="color : blue"><%= dayCount %></b><br><br>
			  			<% }else{ %>
			  				<b><%= dayCount %></b><br><br>
			  			<% } %>
			  			<% if(reservationResult.get(dayCount-1).equals("予約")){ %>
					<a class="test" href="javascript:void(0)" onclick="TimeRangeLink(<%= dayCount %>);">予約</a>
					<% }else{ %>
					<a class="test" href="javascript:void(0)">満席</a>
					<% } %>


		      		</td>
		      <% dayCount++;}}

		      %>
		  </tr>
		<% }} %>

</tbody>











    </table>










</body>
</html>