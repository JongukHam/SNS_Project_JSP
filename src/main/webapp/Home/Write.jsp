<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="java.sql.*" %>
<%@taglib prefix = "c"	 uri="http://java.sun.com/jsp/jstl/core"%>
<%@page import="member.memberDAO"%>
<%@page import="member.memberDTO"%>

<!DOCTYPE html>
<html>
<head>
<jsp:include page="../CssLink/CssLink.jsp" flush="true" />
<meta charset="UTF-8">
<title>Write</title>
<style>
	* { font-family: 'Spoqa Han Sans Neo', 'sans-serif'; }
.writeForm{
	background-color:#fcf7f7;
	border-radius:10px;
	height:500px;
	padding:30px;
	display:flex;
}
.texts{
	margin-right:30px;
	width:20%;
}
.texts .i2{
	height:48%;
}
.writeHere{
	width:80%;
}
.writeHere form{
	height:100%;
}

.writeHere input{
	width:100%;
	border: 1px;
	border-radius:7px;
}
.writeHere .i2{
	margin-top:14px;
	height:50%;
	width:100%;
	resize:none;
	border: 1px;
	border-radius:7px;
}
.writeHere .i4{
	width:60px;
	margin-left:90%;
	border:1px solid #F8F8F8;
}

</style>
</head>	
<jsp:include page="../Nav/HomeNav.jsp" flush="true" />
<body>

<div class="container">
	<div class="writeForm">
		<div class="texts">
			<p>ID
			<p>Title
			<p class="i2">content
			<p>Image
		</div>
		<div class="writeHere">
			<p>&nbsp;${memberId }
			<form name="writeForm" method="post" action="/sns/controller/uploadBoard" enctype="multipart/form-data">
				<input class="i1" type="text" name="title" maxlength='50' placeholder="제목을 입력해 주세요"/>
				<textarea class="i2" name="content" maxlength='500' placeholder="내용을 입력해 주세요"></textarea>
				<input class="i3" type="file" name="ImageFile" />
				<input class="i4" type="submit" value="등록" />
			</form>
		</div>
	
	
	</div>
</div>
</body>
</html>