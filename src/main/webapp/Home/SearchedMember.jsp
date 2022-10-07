<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="java.sql.*" %>
<%@taglib prefix = "c"	 uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
<head>
<link rel = "stylesheet" href = "http://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css">
<meta charset="UTF-8">
<title>Searched</title>
<!-- add Nav -->
<jsp:include page="../Nav/HomeNav.jsp" flush="true" />
</head>	
<body>


	
	<div class="container" style="text-align:center;">
		<h1>searched</h1>
		<c:forEach var="memberDTO" items="${searchedList }">
			<p><a href="/sns/controller/AcHomePage?id='${memberDTO.getMid() }'">${memberDTO.getMid() }</a></p>
		</c:forEach>
	</div>
	
	
	
	
	
</body>
</html>