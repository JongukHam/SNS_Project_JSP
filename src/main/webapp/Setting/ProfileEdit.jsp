<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix = "c"	 uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
<head>

<%
	String memberId=(String)session.getAttribute("memberId");
		
%>
<link rel = "stylesheet" href = "http://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css">
<meta charset="UTF-8">
<title>?</title>
</head>	

<body>

 	<div class="parent" style="display:flex; width: 100%; height: 200px; position:relative;">	
		<script type="text/javascript">	function CheckAddProduct(){formA.submit();}	</script>
		<div class="child" style="margin-left:11%;">
			<p> 인트로
			<p> 프로필 사진
			<p> <input type = "submit" value="등록"  onclick="CheckAddProduct()"
				style="border:0px; background-color:#A1C7E0; color:white; border-radius: 5%;"> 
				<input type = "button" value="취소"  onclick="location.href='../Home/AcHome.jsp';"
				style="border:0px; background-color:#A1C7E0; color:white; border-radius: 5%;"> 
				<input type = "button" value="계정 편집"  onclick="location.href='/sns/controller/AcEditPage';"
				style="border:0px; margin-left:50%; background-color:#A1C7E0; color:white; border-radius: 5%;">
		</div>
		
		<form name="formA"  action = "/sns/controller/Pedit" method="post" enctype="multipart/form-data">
		    <p> <input type = "text" class="form-control"  name = "intro"/> 	   
		    <p> <input type="file" name = "pfp">             
	    </form>
    </div>
	
</body>
</html>