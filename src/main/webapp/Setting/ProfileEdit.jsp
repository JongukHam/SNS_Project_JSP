<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix = "c"	 uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
<head>

<%
	String memberId=(String)session.getAttribute("memberId");
		
%>
<script>
window.onpageshow = function(event) {
    if ( event.persisted || (window.performance && window.performance.navigation.type == 2)) {
    // Back Forward Cache로 브라우저가 로딩될 경우 혹은 브라우저 뒤로가기 했을 경우
    history.back();
    
  }
}
</script>
<style>
.buttons {border:0px; color:white; background:#81BEF7;}
.parent {display: flex; width: 100%; height: 200px; position:relative;}
p{height:30px; margin:16px;}
</style>
<link rel = "stylesheet" href = "http://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css">
<meta charset="UTF-8">
<title>?</title>
</head>	

<body>

 	<div class="parent" style="display:flex; margin-top:50px; width: 100%; height: 200px; position:relative;">	
		<script type="text/javascript">	function pedit(){formP.submit();}	</script>
		<div class="child" style="margin-left:11%;">
			<p> 인트로
			<p> 프로필 사진
			<p> <input type = "submit" value="등록"  onclick="pedit()"
				class="btn btn-secondary" style="border:0px;"> 
				<input type = "button" value="취소"  onclick="history.back()"
				class="btn btn-secondary" style="border:0px;"> 
				<input type = "button" value="계정 편집"  onclick="location.href='/sns/controller/AcEditPage';"
				class="btn btn-secondary" style="border:0px;">
		</div>
		
		<form name="formP"  action = "/sns/controller/Pedit" method="post" enctype="multipart/form-data">
		    <p> <input type = "text" class="form-control"  name = "intro"/> 	   
		    <p> <input type="file" name = "ImageFile">             
	    </form>
    </div>
	
</body>
</html>