<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix = "c"	 uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
<head>



<link rel = "stylesheet" href = "http://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css">
<meta charset="UTF-8">
<title>?</title>
</head>	


<body>

	
 	<div class="parent" style="display:flex; width: 100%; height: 200px; position:relative;">		
 	
		<script type="text/javascript">
			function CheckAddProduct(){
				formA.submit();
			}		
		</script>
	
		<div class="child" style="margin-left:11%;">
			<p> 아이디 
			<p> 비번
			<p> 비번확인
			<p> 이메일
			<p> 전번
			<p> 이름		
			<p> 생년월일 	
			<br />
			<input type = "submit" value="등록"  onclick="CheckAddProduct();"
				class="btn btn-secondary" style="border:0px;"> 
			<input type = "button" value="취소"  onclick="location.href='../Home/AcHome.jsp';"
				class="btn btn-secondary" style="border:0px;"> 
		</div>
		<div class="form-floating">	
	    <form   name="formA"  action = "/sns/controller/Aedit" method="post">		    
		    <p> <input type = "text" class="form-control" id="floatingInput" name = "pw"/>
		    <p> <input type = "text" class="form-control" id="floatingInput" name = "pw2"/>   
		    <p> <input type = "text" class="form-control" id="floatingInput" name = "email" placeholder="${memberlist.getEmail() }"/>
		    <p> <input type = "text" class="form-control" id="floatingInput" name = "phone" placeholder="${memberlist.getPhone() }"/>
		    <p> <input type = "text" class="form-control" id="floatingInput" name = "name" placeholder="${memberlist.getName() }"/>
		    <p> <input type = "text" class="form-control" id="floatingInput" name = "birth" placeholder="${memberlist.getBirth()}"/>
            
	    </form>
   		</div>
   </div>
	
	
	
	
</body>
</html>