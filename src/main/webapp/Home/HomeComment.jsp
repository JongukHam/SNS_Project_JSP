<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="java.sql.*" %>
<%@taglib prefix = "c"	 uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
<head>
<link rel = "stylesheet" href = "http://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css">
<meta charset="UTF-8">
<title>HomeComment</title>
</head>	
<body>

	<jsp:include page="../Nav/HomeNav.jsp"/>
	
	<br><br>
	<div class = "container">
		<p>─────────────────────────────────────────────────────────────
		<p>작성자 프사 ${listBoardDetail[0].pfp} // 작성자 아이디${listBoardDetail[0].id}
		<p>작성자 프사 <a href="/sns/controller/selectBoardDetail?pageRoute=selectBoardDetail&bid=${listBoard.pfp}">${listBoard.id}</a> 작성자 아이디 <a href="/sns/controller/selectBoardDetail?pageRoute=selectBoardDetail&bid=${listBoard.bid}">${listBoard.id}</a>
		<p>게시글 내용 ${listBoardDetail[0].content}
		<p>게시글 날짜 ${listBoardDetail[0].birth}
		<p>─────────────────────────────────────────────────────────────
		<c:forEach var="listCommentDetail" items="${listCommentDetail}" varStatus="status">
			<p>댓글 작성자 프사 ${listCommentDetail.pfp} // 댓글 작성자 아이디 ${listCommentDetail.cid}
			<p>댓글 내용 ${listCommentDetail.content}
			<p>댓글 날짜 ${listCommentDetail.birth} 좋아요 ${listCommentDetail.likeCount}
			<p>────────────────────────────
		</c:forEach>
		<form method="post" action="/sns/controller/insertComment?pageRoute=insertComment&bid=${listBoardDetail[0].bid}&commentDetail=HomeComment">
			<input name="comment" type="text" class="form-control" id="comment" placeholder="댓글 달기" style="width: 200px; float: left;">
			<button type="submit" class="btn btn-secondary" onclick="/sns/controller/insertComment?pageRoute=insertComment&bid=${listBoardDetail[0].bid}&commentDetail=HomeComment">등록</button>
		</form>
		<p>─────────────────────────────────────────────────────────────
	</div>
	
	
	
	
	
	
</body>
</html>