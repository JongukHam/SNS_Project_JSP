<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="java.sql.*" %>
<%@taglib prefix = "c"	 uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
<head>
<link href='//spoqa.github.io/spoqa-han-sans/css/SpoqaHanSansNeo.css' rel='stylesheet' type='text/css'>
<link rel = "stylesheet" href = "http://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css">
<meta charset="UTF-8">
<title>?</title>
<style>
	* { font-family: 'Spoqa Han Sans Neo', 'sans-serif'; }
	#editPage{
		display:flex;
		border:1px solid black;
		border-radius : 7px;
	}
	#editPage>.names{
		border:1px solid black;
		border-radius : 7px;
		width:27%;
		text-align:center;
	}
	#editPage>.contents{
		border:1px solid black;
		border-radius : 7px;
		width:73%;
		padding-left:30%;
	}
	#editPage ul{
		list-style:none;
		padding-left:0px;
		padding-top:20px;
	}
	#editPage li{
		margin-bottom:25px;
	}
</style>
</head>	
<jsp:include page="../Nav/HomeNav.jsp" flush="true" />
<body>

<div class="container">
	<div id="editPage">
			<div class="names">
				<ul>
					<li>아이디</li>
					<li>이름</li>
					<li>이메일</li>
					<li>전화번호</li>
					<li>생년월일</li>
				</ul>
			</div>
			<div class="contents">
				<ul>
					<li>1</li>
					<li>2</li>
					<li>3</li>
					<li>4</li>
					<li>5</li>
				</ul>
			</div>
	</div>
</div>

	
	
	
	
</body>
</html>