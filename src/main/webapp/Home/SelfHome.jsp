<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix = "c"	 uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>

<head>

<%
	String memberId=(String)session.getAttribute("memberId");
	if(memberId!=null){
		if (request.getAttribute("boardlist") == null) {
			response.sendRedirect("/sns/controller/selectAc?pageRoute=selectAc&memberId="+memberId);
		} 
	} else { %>  <%} 
	
%>
<link rel = "stylesheet" href = "http://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css">
<style>	<%@ include file="style.jsp" %>	
</style><meta charset="UTF-8">
<title>SelfHome</title>
<jsp:include page="../Nav/SelfHomeNav.jsp"/>



<script>

//  let location = document.querySelector("#champPre").offsetTop;
 window.scrollTo(0,100);

</script>


</head>	



<body style="background-color:grey;">
	
	<div class="container" id="profile">
		<div class="box">
		    <img class="profile" src="../profilephoto/${memberlist.getPfp() }">
		    <p> 
		</div>
		
		<div class="profile">
			<div style="display:flex;">
			    <p> 게시물 : ${len } &nbsp;
			    <p> 팔로워 : ${memberlist.getFollower() } &nbsp;
			    <p> 팔로우 : 0 
		    </div>
		    <div>
		    	<p> 아이디 : ${memberlist.getMid() }
				<p> 사진 : ${memberlist.getPfp() }
		    </div>
		</div>

	</div>
	
	<div class="container" style="margin-bottom:100px; margin-top:20px;">
		<button class="btn btn-secondary" onclick="location.href='/sns/controller/ProfileEditPage';" > 프로필 편집</button>
		
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
			 				<img id="bphoto"
			 				src="../ImageFile/${boardlist.get(i+k*3).getPhoto()}"	
			 				style="margin-right:10px; margin-bottom:10px;"		 				
			 				onclick="location.href='/sns/controller/AcContentPage?m2id=<%=memberId %>&index=${i+k*3}'"/>				 				
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