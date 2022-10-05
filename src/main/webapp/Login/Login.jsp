<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="java.sql.*" %>
<%@taglib prefix = "c"	 uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
<head>
<link rel = "stylesheet" href = "http://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css">
<meta charset="UTF-8">
<title>Login</title>
</head>	
<body>
	<h1>현재 세션 = ${memberId }</h1>
	<form method="post" action="/sns/controller/Login">
		<input type ="text" name="mid"/>
		<input type="submit" />
	</form>
	
	
	
	
</body>
</html>