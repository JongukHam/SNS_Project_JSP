<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix = "c"	 uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
<head>
<%
	String memberId=(String)session.getAttribute("memberId");
	if(memberId!=null){
		if (request.getAttribute("memberlist") == null) {
			response.sendRedirect("/sns/controller/selectAc?pageRoute=selectAc&ae=1");
		} 
	} else { %>  <%} 
	
%>
<style>
.buttons {border:0px; color:white; background:#81BEF7;}
.parent {display: flex; width: 100%; height: 200px; position:relative; margin-top:50px;}
p{height:30px; margin:16px;}

</style>

<link rel = "stylesheet" href = "http://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css">
<meta charset="UTF-8">
<title>?</title>
</head>	


<body>

	
 	<div class="parent" >		
 	
		<script type="text/javascript">	function Aedit(){	formA.submit();	} </script>
	
		<div class="child" style="margin-left:11%; ">
			<p> 아이디 
			<p> 비번
			<p> 비번확인
			<p> 이메일
			<p> 전번
			<p> 이름		
			<p> 가입일 	
			<br /><br /><br />
			<p> <input type = "submit" value="등록"  onclick="Aedit();"
				class="btn btn-secondary" style="border:0px;"> 
			 	<input type = "button" value="취소"  onclick="history.back()"
				class="btn btn-secondary" style="border:0px;"> 
		</div>
		<div class="form-floating">	
	    <form   name="formA"  action = "/sns/controller/Aedit" method="post">		    
		    <p> <input disabled="disabled" type = "text" class="form-control" id="floatingInput" name = "mid" value="${memberlist.getMid()}"/> 
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