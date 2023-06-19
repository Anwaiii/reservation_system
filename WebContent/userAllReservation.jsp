<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.util.*" session="false"%>
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" type="text/css" href="css/mouseHoverDropDownDesign.css">
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
<title>予約システム 全予約確認画面</title>
<script type="text/javascript">
$(function(){
    $(".test02").css("color","green")
});
</script>
</head>
<body>
<h1> 全予約状況 </h1>


<ul>
		<% /*
		System.out.println("sessionCheck");
	 	UserBean user= (UserBean)sessionCheck.getAttribute("user"); */
	 	%>
		<li><a>Hello,xxxxxxxさん
		</a>

			<ul class="dropdown">
				<li><a href="userCalendar.jsp">カレンダー画面</a></li>
				<li><a href="javascript:void(0)" onclick="Logout();">ログアウト</a></li>
			</ul></li>
	</ul>
		<br><br><br><br>


	 <table border="1">
	 <caption style="font-size: 30px;">

	 </caption>


<tbody>


	<tr>
	<td>2023-06-01   <a href="">変更</a>   <a href="">取消</a></td>
	</tr>
	<tr>
	<td>2023-06-07    <a href="">変更</a>   <a href="">取消</a></td>
	</tr>
	<tr>
	<td>2023-06-10    <a href="">変更</a>   <a href="">取消</a></td>
	</tr>

</tbody>



    </table>




</body>
</html>