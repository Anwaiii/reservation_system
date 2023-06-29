<%@page import="java.text.SimpleDateFormat"%>
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
<link rel="stylesheet" type="text/css" href="css/mouseHoverDropDownDesign.css">
<link rel="stylesheet" type="text/css" href="css/adminCalendar.css">
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

		var form = document.forms[0];
		var input = document.getElementById(date);
		form.appendChild(input);
		document.body.appendChild(form);
		form.submit();

		}
</script>

<script type="text/javascript">
function newMonth(currentMonth){
		var form = document.forms[1];
		var input = document.getElementById(currentMonth);
		form.appendChild(input);
		document.body.appendChild(form);
		form.submit();

		}
</script>

<script type="text/javascript">
function lastMonth(){
		var form = document.forms[2];
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
<title>予約システム 管理者カレンダー画面</title>

</head>
<body>

<% Calendar calendar = Calendar.getInstance();	 //今のカレンダーを取得


	Integer currentYear = (Integer) request.getAttribute("currentYear");
	Integer currentMonth = (Integer) request.getAttribute("currentMonth");

	if(currentYear == null && currentMonth == null){
		currentYear = calendar.get(Calendar.YEAR);
		currentMonth = calendar.get(Calendar.MONTH);	// currentMonthは0からはじまる。
	}

	%>

<h1>カレンダー(管理者)</h1>
<form action="AdminTimeRangeCon" method="get"></form>
<form action="NextMonthCon" method="get"><input type="hidden" name="currentYear" value="<%=currentYear%>"
	 id="<%=currentYear%>"><input type="hidden" name="currentMonth" value="<%=currentMonth%>"></form>
	 <form action="LastMonthCon" method="get">
	 <input type="hidden" name="currentYear" value="<%=currentYear%>">
	   <input type="hidden" name="currentMonth" value="<%=currentMonth%>">
	 </form>
<ul>
		<li><a>Hello,<%= user.getUserName() %>さん
		</a>

			<ul class="dropdown">
				<li><a href="adminCreateUser.jsp">ユーザー追加画面</a></li>
				<li><a href="adminUpdateUser.jsp">ユーザー更新画面</a></li>
				<li><a href="javascript:void(0)" onclick="Logout();">ログアウト</a></li>
			</ul></li>
	</ul>


	<%

		int nextMonth = currentMonth + 1;

		calendar.set(currentYear,currentMonth,1);      //カレンダーを当月の1日にセットする
		int dayOfWeek = calendar.get(Calendar.DAY_OF_WEEK);  //	当月の1日は何曜日かを取得する
		 SimpleDateFormat formatter = new SimpleDateFormat("dd");
		    Date day = new Date();
		    int dd = Integer.parseInt(formatter.format(day));
		    SimpleDateFormat formatter2 = new SimpleDateFormat("MM");
		    int MM = Integer.parseInt(formatter2.format(day));
		    SimpleDateFormat formatter3 = new SimpleDateFormat("yyyy");
		    int yyyy = Integer.parseInt(formatter3.format(day));


		 // ex:currentMonth = 5, MM = 6. currentMonth + 1 = MM

		calendar.set(currentYear,nextMonth,1);		//	カレンダーの日付を来月の1日にセットする
		calendar.add(Calendar.DATE,-1);		//	カレンダーの日付を1日前に戻し、本月は何日があるかを求める
    	int maxDay = calendar.get(Calendar.DATE);	//	結果をmaxDayに代入する

    	// currentMonthは0からはじまり、表示の際には+1が必要
    	String month = String.format("%02d", currentMonth+1);
    	 String date="";
    	 calendar = Calendar.getInstance();

    	 calendar.add(Calendar.DATE,90);
    	 Calendar newDay = Calendar.getInstance();
    	 newDay.set(currentYear, currentMonth,1);
		 int diff = calendar.compareTo(newDay);

    %>

	<br>
	<br>
	<br>
	<br>
	<table border="1">
		<caption style="font-size: 30px;">
			<% if(!(currentYear == yyyy && currentMonth < MM)){ %>
			<a href="javascript:void(0)" style="float: left" onclick="lastMonth();">＜</a>

			<% } else{%>&nbsp&nbsp<%} %>
			<span style="color: red; font-weight: bold;"><%= currentYear %>年 <%= currentMonth + 1 %>月</span>

			<% if (diff > 0 ){ %>
			<a href="javascript:void(0)" style="float: right" onclick="newMonth(<%=currentMonth%>);">
			<input type="hidden" name="currentMonth" value="<%=currentMonth%>"
			   id="<%=currentMonth %>">＞</a>
			   <%} else{%>&nbsp&nbsp<%} %>
		</caption>

		<tr>
			<th style="color: red">日</th>
			<th>月</th>
			<th>火</th>
			<th>水</th>
			<th>木</th>
			<th>金</th>
			<th style="color: blue">土</th>
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
				<td><input type="hidden" name="date" value="<%= date %>"
					id="<%= date %>">
					 <% if(colWeek == 1){ %> <b
					style="color: red"><%= dayCount %></b><br>
				<br> <% }else if(colWeek == 7){ %> <b style="color: blue"><%= dayCount %></b><br>
				<br> <% }else{ %> <b><%= dayCount %></b><br>
				<br> <% } %> <%
				 if(!(currentYear == yyyy && currentMonth+1 == MM && dayCount < dd)){
					 %>
					<a class="test" href="javascript:void(0)"
					onclick="TimeRangeLink('<%= date %>');">予約詳細</a><%}%>


				<%dayCount++;}%></td><%}}%>
			</tr>
			<% } %>

		</tbody>

	</table>

</body>
</html>