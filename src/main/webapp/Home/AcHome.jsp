<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix = "c"	 uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>

<head>

<%
	String m2id=request.getParameter("m2id");
	if(m2id!=null){
		if (request.getAttribute("boardlist") == null) {
			response.sendRedirect("/sns/controller/selectAc?pageRoute=selectAc&m2id="+m2id);
		} 
	} else { %>  <%} 
	
%>
<link rel = "stylesheet" href = "http://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css">
<style>	<%@ include file="style.jsp" %>	
</style><meta charset="UTF-8">
<title>AcHome - 계정 홈</title>
<jsp:include page="../Nav/AcNav.jsp"/>




</head>	



<body>


	<div class="container" id="profile">
		<div class="box">
		    <img class="profile" src="../profilephoto/${memberlist.getPfp() }">
		    <p> 
		</div>
		
		<div class="profile">
		    <p> 게시물 : ${len }
		    <p> 팔로워 : ${memberlist.getFollower() }
		    <p> 팔로우 : 0
		    <p><button class="btn btn-secondary" onclick="location.href='/sns/controller/follow?pageRoute=follow&mid=${memberlist.getMid()}'">팔로우</button>
		    
		</div>
		<p> 아이디 : ${memberlist.getMid() } <br/>
		<p> 사진 : ${memberlist.getPfp() }
	</div>
	
	<div class="container" style="margin-bottom:100px;">

		
	</div>
	
	
 	<c:set var="arr" value="${(len%3>0) ? len/3+1 : len/3}"/>	
 	<c:set var="loops" value="false"/> 		 
 	<c:if test="${len>0}">	
			<c:set var="counts" value="0"/>
	 	<c:forEach var="k" begin="0" end="${arr-1}">
	 		<c:set var="a" value="${(len%3!=0)?(k<=len/3-1) ? 3:(len%3==1)?1:2 : 3}"/>
	 		<c:if test="${not loops}">				 			 
		 		<div class="container" id="bphotos">		
			 		<c:forEach var="i" begin="${0}" end="${a-1}">				 							 			
			 			<div class="child">
<!-- 		============    이게 컨텐트에서 불러오는 이미지파일의 쿼리셀렉터 주소로 쓰일 아이디 -->
			 				<img id="bphoto" 
			 				src="../ImageFile/${boardlist.get(i+k*3).getPhoto()}"	
			 				style="margin-right:10px; margin-bottom:10px;"		 				
			 				onclick="location.href='/sns/controller/AcContentPage?m2id=${param.m2id}&index=${i+k*3}'"/>				 				
			 				<p>	좌표:	${boardlist.get(i+k*3).getPhoto()}
				 		</div>								 		
				 		<c:set var="counts" value="${counts+1}"/>							 							 					 		
			 		</c:forEach>						 		
				</div>						
				
			</c:if>
		</c:forEach>
	</c:if>		

	

</body>


</html>