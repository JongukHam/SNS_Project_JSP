<%@page import="java.sql.*" %>
<%@page import="board.boardDAO"%>
<%@page import="member.memberDAO"%>
<%@page import="member.memberDTO"%>
<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<script src="https://cdn.jsdelivr.net/npm/jquery@3.6.0/dist/jquery.slim.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/js/bootstrap.bundle.min.js"></script>
<head>

<%
	if (request.getAttribute("listBoard") == null) {
		response.sendRedirect("/sns/controller/selectBoard?pageRoute=selectBoard");
	}
%>
	<style type="text/css">
		p {
			width: 800px;
		}
		.parent {
			height: 500px;
			background: #EB5050;
		}
	</style>
<link rel = "stylesheet" href = "http://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css">
<meta charset="UTF-8">
<title>Home</title>
<jsp:include page="../Nav/HomeNav.jsp"/>
</head>	

<body>


	<!-- ─────────────────────────────────────────────────────────────────────────── -->
	<!-- 모달 시작 -->
	
	<div class="modal fade" id="#logout" tabindex="-1" role="dialog"></div>
	<div class="modal" id="logout">
		<div class="modal-dialog">
			<div class="modal-content">
	
				<!-- Modal Header -->
				<div class="modal-header">
					<h4 class="modal-title">로그아웃</h4>
				</div>
	
				<!-- Modal body -->
				
				<div class="modal-body">
					<p>로그아웃 하시겠습니까?
					<p>${listBoard[0].bid}
					
				</div>
	
				<!-- Modal footer -->
				<div class="modal-footer">
					<button type="button" class="btn btn-primary" data-dismiss="modal">취소</button>
				</div>
			</div>
		</div>
	</div>
	
	<!-- 모달 종료 -->
	<!-- ─────────────────────────────────────────────────────────────────────────── -->
	
	
	

	
	
	
	
	<!-- ─────────────────────────────────────────────────────────────────────────── -->
	<!-- 전체 게시물 출력 시작-->
	
	<br><br>
	<div class="container" style="" id="d">
		
		<p>─────────────────────────────────────────────────────────────
        <c:forEach var="listBoard" items="${listBoard}" varStatus="status">
        	<p><h3>게시글 번호 ${listBoard.bid}</h3>
		    <p>작성자 프사 <a href="/sns/controller/AcHomePage?m2id=${listBoard.id}">${listBoard.id}</a> 작성자 아이디 <a href="/sns/controller/AcHomePage?m2id=${listBoard.id}">${listBoard.id}</a>
		    <p style="height: 100px;">게시글 사진 ${listBoard.photo}
			<p>
				<button class="btn btn-secondary" onclick="scrollStop('likeWho', ${listBoard.bid})">좋아요</button>
				<!-- 댓글 해야함 -->
				<button class="btn btn-secondary" onclick="scrollStop('likeWho', ${listBoard.bid})">댓글</button>
				<button class="btn btn-secondary">메세지</button>
				
			<!-- ─────────────────────────────────────────────────────────────────────────── -->
			<!-- 모달 -->
			
			<p><a href="#" data-toggle="modal" data-target="#logout" data-bid="${listBoard.bid}">좋아요 ${listBoard.likeCount}개</a>
			
			<!-- ─────────────────────────────────────────────────────────────────────────── -->
			
			<p>작성자 아이디 ${listBoard.id}
			<p>게시글 내용 ${listBoard.content}
			
			<c:if test="${listBoard.commentCount != 0}">
				<p><a href="/sns/controller/selectBoardDetail?pageRoute=selectBoardDetail&bid=${listBoard.bid}">댓글 ${listBoard.commentCount}개 보기</a>
				<p>────────────────────────────

			</c:if>
			<p>${listBoard.birth}
			<p>
				<form name="form${listBoard.bid}" method="post" action="/sns/controller/insertComment?pageRoute=insertComment&bid=${listBoard.bid}&commentDetail=Home">
					<input id="comment" name="comment" type="text" class="form-control" placeholder="댓글 달기" style="width: 200px; float: left;">
					<button class="btn btn-secondary">등록</button>
					
					
				</form>
				
				<br>
			<br>
			<p>─────────────────────────────────────────────────────────────
		</c:forEach>
	</div>
	<br><br><br>
	
	<!-- 전체 게시물 출력 종료 -->
	<!-- ─────────────────────────────────────────────────────────────────────────── -->
	
	
	
	
	<!-- ─────────────────────────────────────────────────────────────────────────── -->
	<!-- 자바스크립트 코드 시작 -->
	
	<script>
		
		function z() {
			console.log('hi');
			console.log(document.form.comment.value);
		}
		
 		function scrollStop(pageRoute, bid) { 
	        var y = window.scrollY;
	        
	        // 좋아요
	        if (pageRoute == 'likeWho') {
	        	location.href="/sns/controller/likeWho?pageRoute=likeWho&bid=" + bid + "&scroll=" + y;
			}
	        
	   	  	// 댓글
	   	  	else if (pageRoute == 'insertComment') {
	        	location.href="/sns/controller/insertComment?pageRoute=insertComment&bid=" + bid + "&scroll=" + y + "&commentDetail=Home&content=con1";
			}
		} 

     </script>
    
    <!-- 자바스크립트 코드 종료 -->
    <!-- ─────────────────────────────────────────────────────────────────────────── -->

<%
	if (session.getAttribute("scroll") != null) {
%>
		<script>
			window.scrollTo(0, ${scroll});
		</script>
<%
	}
%>
	
</body>
</html>