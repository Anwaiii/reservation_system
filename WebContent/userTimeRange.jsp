<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.util.*" session="false"%>
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
		<% /*
		System.out.println("sessionCheck");
	 	UserBean user= (UserBean)sessionCheck.getAttribute("user"); */
	 	%>
		<li><a>Hello,xxxxxxxさん
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


	<tr>
	<td><a href="userReservationConfirm.jsp">10:00~11:00</a>（予約済み）</td>
	</tr>
	<tr>
	<td><a href="">11:00~12:00</a>（予約なし）</td>
	</tr>
	<tr>
	<td><a href="">12:00~13:00</a>（予約済み）</td>
	</tr>
	<tr>
	<td><a href="">13:00~14:00</a>（予約なし）</td>
	</tr>
	<tr>
	<td><a href="">14:00~15:00</a>（予約なし）</td>
	</tr>
	<tr>
	<td><a href="">15:00~16:00</a>（予約なし）</td>
	</tr>
	<tr>
	<td><a href="">16:00~17:00</a>（予約済み）</td>
	</tr>

</tbody>
 </table>


</body>
</html>