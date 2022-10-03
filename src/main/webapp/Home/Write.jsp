<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="java.sql.*" %>
<%@taglib prefix = "c"	 uri="http://java.sun.com/jsp/jstl/core"%>
<%@page import="member.memberDAO"%>
<%@page import="member.memberDTO"%>

<!DOCTYPE html>
<html>
<head>
<link rel = "stylesheet" href = "http://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css">
<meta charset="UTF-8">
<title>?</title>
</head>	
<body>

<%
	memberDAO dao = new memberDAO();
	out.print(dao.select());
	dao.close();
%>
	
	hihihihi
	
	
</body>
</html>