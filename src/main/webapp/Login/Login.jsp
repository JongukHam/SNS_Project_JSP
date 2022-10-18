<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="java.sql.*" %>
<%@taglib prefix = "c"    uri="http://java.sun.com/jsp/jstl/core"%>
<jsp:useBean id="member" class="member.memberDTO" scope="session" />

<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/css/bootstrap.min.css">
<meta charset="UTF-8">
<title>?</title>
</head>   
<body>

	
  <div class="container" style="text-align:center; margin-top:100px;">
      <h3>로그인</h3>         
		<form action="/sns/controller/Login" class="was-validated" name="member" method="post">
		  <div class="form-group">
		    <label for="uname">Username:</label>
		    <input type="text" class="form-control" id="mid" placeholder="Enter userId" name="mid" required>
		    <div class="valid-feedback">Valid.</div>
		    <div class="invalid-feedback">아이디를 입력해 주세요</div>
		  </div>
		  <div class="form-group">
		    <label for="pwd">Password:</label>
		    <input type="password" class="form-control" id="pw" placeholder="Enter password" name="pw" required>
		    <div class="valid-feedback">Valid.</div>
		    <div class="invalid-feedback">비밀번호를 입력해 주세요</div>
		  </div>
		  <button type="submit" class="btn btn-primary">로그인</button>
		  <button type="button" class="btn btn-primary" onclick="location.href='/sns/controller/SignUpPage' ">회원가입</button>
		</form>
   </div>   
</body>
</html>