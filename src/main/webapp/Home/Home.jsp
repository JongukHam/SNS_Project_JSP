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
<head>
	<style type="text/css">
		p {
			width: 800px;
		}
		.parent {
			height: 500px;
			background: #EB5050;
		}
		
		/* 무한 스크롤 */
		html, body{ margin: 0; }
		h1 {
		  position: fixed; top: 0; width: 100%; height: 60px; 
		  text-align: center; background: white; margin: 0; line-height: 60px;
		}
		section .box {height: 500px; background: red;}
		section .box p {margin: 0; color: white; padding: 80px 20px;}
		section .box:nth-child(2n) {background: blue;}
	</style>
<link rel = "stylesheet" href = "http://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css">
<meta charset="UTF-8">
<title>Home</title>
</head>	
<body>
	
	<jsp:include page="../Nav/HomeNav.jsp"/>
	


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
					<p>${listBoard.get(i).getBid()}
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

	<!-- Home 페이지로 처음 오거나 다른 페이지에서 왔을때 게시물의 정보를 출력하기 위해 DB에 있는 게시물 정보를 가져옴 -->
	<c:if test="${listBoard == null }">
		<script>
			location.href="/sns/controller/selectBoard?pageRoute=selectBoard";
		</script>
	</c:if>
	
	
	<!-- 게시물 몇번째까지 출력할것인지 설정하는 변수 -->
	<c:set var="boardEnd" value="2"></c:set>
	
	
	<!-- ─────────────────────────────────────────────────────────────────────────── -->
	<!-- 전체 게시물 출력 시작 -->
	
	<div class="container">
		<section>
			<p>─────────────────────────────────────────────────────────────
			<c:choose>
				<%-- 버튼 안눌렀을때 --%>
				<c:when test="${boardCount == null}">
					<c:forEach var="i"  begin="0" end="${boardEnd }">
			        	<p><h3>게시글 번호 ${listBoard.get(i).getBid()}</h3>
					    <p>작성자 프사 <a href="/sns/controller/AcHomePage?m2id=${listBoard.get(i).getId()}">${listBoard.get(i).getPfp()}</a> 아이디 <a href="/sns/controller/AcHomePage?m2id=${listBoard.get(i).getId()}">${listBoard.get(i).getId()}</a>
					    
<%-- 					    <p>작성자 프사 <a href="/sns/controller/AcHomePage?m2id=${listBoard.id}">${listBoard.id}</a> 작성자 아이디 <a href="/sns/controller/AcHomePage?m2id=${listBoard.id}">${listBoard.id}</a> --%>
					    
					    
					    <p style="height: 100px;">${listBoard.get(i).getPhoto()}
						<p>
							<button class="btn btn-secondary" onclick="scrollStop('likeWho', ${listBoard.get(i).getBid()}, ${i})">좋아요</button>
							<button class="btn btn-secondary" onclick="scrollStop()">모달댓글</button>
							<button class="btn btn-secondary">공유</button>
							
							
							
							
						<%-- 게시글 좋아요 1개 이상일때만 갯수 보여주기 --%>
						<c:if test="${listBoard.get(i).getLikeCount() != 0}">
							<p><a href="#" data-toggle="modal" data-target="#logout" data-bid="${listBoard.get(i).getBid()}" onclick="z()">모달 좋아요 ${listBoard.get(i).getLikeCount()}개</a>
						</c:if>
						
						
						
						
						
						
						<p>게시글 내용 ${listBoard.get(i).getContent()}
						
						<%-- 게시글 댓글 1개 이상일때만 갯수 보여주기 --%>
						<c:if test="${listBoard.get(i).getCommentCount() != 0}">
							<p><a href="/sns/controller/selectBoardDetail?pageRoute=selectBoardDetail&bid=${listBoard.get(i).getBid()}">댓글 ${listBoard.get(i).getCommentCount()}개 보기</a>
							<p>────────────────────────────
						</c:if>
						<p>${listBoard.get(i).getBirth()}
						<p>
							<form name="form${listBoard.get(i).getBid()}" method="post" action="/sns/controller/insertComment?pageRoute=insertComment&bid=${listBoard.get(i).getBid()}&commentDetail=Home">
								<input id="comment" name="comment" type="text" class="form-control" placeholder="댓글 달기" style="width: 200px; float: left;">
								<button class="btn btn-secondary">등록(완료)</button>
							</form>
							<br>
						<br>
						<p>─────────────────────────────────────────────────────────────
					</c:forEach>
				</c:when>
				
				<%-- 버튼 눌렀을때 --%>
				<c:otherwise>
					<c:forEach var="i"  begin="0" end="${boardCount + 2}">
<!-- 						<p>ㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋ -->
						<p><h3>게시글 번호 ${listBoard.get(i).getBid()}</h3>
					    <p>작성자 프사 <a href="/sns/controller/AcHomePage?m2id=${listBoard.get(i).getId()}">${listBoard.get(i).getPfp()}</a> 아이디 <a href="/sns/controller/AcHomePage?m2id=${listBoard.get(i).getId()}">${listBoard.get(i).getId()}</a>
					    <p style="height: 100px;">${listBoard.get(i).getPhoto()}
						<p>
							<button class="btn btn-secondary" onclick="scrollStop('likeWho', ${listBoard.get(i).getBid()}, ${i})">좋아요</button>
							<button class="btn btn-secondary" onclick="scrollStop()">모달댓글</button>
							<button class="btn btn-secondary">공유</button>
							
						<%-- 게시글 좋아요 1개 이상일때만 갯수 보여주기 --%>
						<c:if test="${listBoard.get(i).getLikeCount() != 0}">
							<p><a href="#" data-toggle="modal" data-target="#logout" data-bid="${listBoard.get(i).getBid()}">모달 좋아요 ${listBoard.get(i).getLikeCount()}개</a>
						</c:if>
						
						<p>게시글 내용 ${listBoard.get(i).getContent()}
						
						<%-- 게시글 댓글 1개 이상일때만 갯수 보여주기 --%>
						<c:if test="${listBoard.get(i).getCommentCount() != 0}">
							<p><a href="/sns/controller/selectBoardDetail?pageRoute=selectBoardDetail&bid=${listBoard.get(i).getBid()}">댓글 ${listBoard.get(i).getCommentCount()}개 보기</a>
							<p>────────────────────────────
						</c:if>
						<p>${listBoard.get(i).getBirth()}
						<p>
						
						
						
						
							<form name="form${listBoard.get(i).getBid()}" method="post" action="/sns/controller/insertComment?pageRoute=insertComment&bid=${listBoard.get(i).getBid()}&commentDetail=Home">
								<input id="comment" name="comment" type="text" class="form-control" placeholder="댓글 달기" style="width: 200px; float: left;">
								<button class="btn btn-secondary">등록(완료)</button>
							</form>
							
							
							
							
							
							
							
							<br>
						<br>
						<p>─────────────────────────────────────────────────────────────
					</c:forEach>
				</c:otherwise>
			</c:choose>
		</section>
	</div>
	<br><br><br>
	
	<!-- 전체 게시물 출력 종료 -->
	<!-- ─────────────────────────────────────────────────────────────────────────── -->
	
	
	<!-- 무한 스크롤은 페이지를 처음 띄우거나 다른 페이지에서 왔을때의 경우와 버튼을 눌렀을때의 경우로 나뉨 -->
	<c:if test="${boardCount == null }">
		<c:set var="boardCount" value="-1"></c:set>
	</c:if>
	
	
	<!-- ─────────────────────────────────────────────────────────────────────────── -->
	<!-- 자바스크립트 코드 시작 -->
	
	<script>
		
	function z() {
// 		alert(0);
	}
	
	
	// 스크롤 할때마다 현재 Y축 좌표를 sessionStorage.Y에 담는다. 여기서 sessionStorage는 자바의 session과 비슷하다 
	window.addEventListener('scroll', () => { 
		sessionStorage.Y = window.scrollY;
	});
	
	// Java → JSTL(EL) → JavaScript 순으로 정보를 옮겨담음  
	var arr = new Array();
	<c:forEach items="${listBoard}" var="item">         
		arr.push({
			bid				: "${item.getBid()}",
			id				: "${item.getId()}",
			content			: "${item.getContent()}" ,
			birth			: "${item.getBirth()}" ,
			likeCount		: "${item.getLikeCount()}" ,
			pfp				: "${item.getPfp()}" ,
			photo			: "${item.getPhoto()}" ,
			commentCount	: "${item.getCommentCount()}" 
		}); 
	 </c:forEach> 
	
	// 버튼(좋아요, 댓글 등)을 눌렀을때 몇번째 게시물인지 알수 있는 함수 
	var boardCount = <c:out value="${boardCount}"></c:out>
		  
	
	
	///////////////////////////////////////////////////////////////////////
	//////////////////////////// 무한 스크롤 코드 시작 //////////////////////////
	
	
	// 버튼(좋아요, 댓글 등)을 눌렀을때 boardCount에 담긴 게시물 index값의 +2번째부터 무한 스크롤 적용
	// 2번째 게시물의 버튼을 눌렀으면 5번째 게시물부터 무한 스크롤 적용(4번째 게시물까지는 미리 만들어놓기 때문)
	if (boardCount != -1) {
		var index = boardCount + 3;
		window.onscroll = function(e) {
			if((window.innerHeight + window.scrollY) >= document.body.offsetHeight) { 
				var addContent = document.createElement("div");
// 				addContent.classList.add("box");
				addContent.innerHTML =  '<p><h3>게시글 번호 ' + arr[index].bid + '</h3>' +
										'<p>' + 
											'작성자 프사 ' + '<a href="/sns/controller/AcHomePage?m2id=' + arr[index].id + '">' + arr[index].pfp + '</a> ' +
											'아이디 ' + '<a href="/sns/controller/AcHomePage?m2id=' + arr[index].id + '">' + arr[index].id + '</a> ' + 
										'<p style="height: 100px;">' + arr[index].photo + 
										'<p>' + 
											'<button class="btn btn-secondary" onclick="scrollStop(\'likeWho\', ' + arr[index].bid + ', ' + index + ')">좋아요</button>' +
											'<button class="btn btn-secondary" onclick="scrollStop(' + arr[index].bid + ')">모달댓글</button>' + 
											'<button class="btn btn-secondary">공유</button>' +
										'<p><a href="#" data-toggle="modal" data-target="#logout" data-bid="${listBoard.get(i).getBid()}">모달 좋아요 ' + arr[index].likeCount + '개</a>' +
										'<p>게시글 내용 ' + arr[index].content +
										'<p>' + arr[index].birth +
										'<p>' + 
						 					'<form name="form' + arr[index].bid + '" method="post" action="/sns/controller/insertComment?pageRoute=insertComment&bid=' + arr[index].bid + '&commentDetail=Home">' + 
							 					'<input id="comment" name="comment" type="text" class="form-control" placeholder="댓글 달기" style="width: 200px; float: left;">' + 
							 					'<button class="btn btn-secondary">등록(완료)</button>' + 
						 					'</form>' + 
										'<p>─────────────────────────────────────────────────────────────'
										;
			document.querySelector('section').appendChild(addContent);
			index++;
			}
		}
	}
	
	// 페이지에 처음 오거나 다른 페이지에서 왔을때 boardEnd로 설정한 index값의 +1번째부터 무한 스크롤 적용
	// boardEnd에 4를 설정했으면 5번째 게시물부터 무한 스크롤 적용
	else {
		var index = <c:out value="${boardEnd + 1}"></c:out>
		window.onscroll = function(e) {
			if((window.innerHeight + window.scrollY) >= document.body.offsetHeight) { 
				var addContent = document.createElement("div");
// 				addContent.classList.add("box");
				addContent.innerHTML =  '<p><h3>게시글 번호 ' + arr[index].bid + '</h3>' +
										'<p>' + 
											'작성자 프사 ' + '<a href="/sns/controller/AcHomePage?m2id=' + arr[index].id + '">' + arr[index].pfp + '</a> ' +
											'아이디 ' + '<a href="/sns/controller/AcHomePage?m2id=' + arr[index].id + '">' + arr[index].id + '</a> ' + 
										'<p style="height: 100px;">' + arr[index].photo + 
										'<p>' + 
					 						'<button class="btn btn-secondary" onclick="scrollStop(\'likeWho\', ' + arr[index].bid + ', ' + index + ')">좋아요</button>' +
					 						'<button class="btn btn-secondary" onclick="scrollStop(' + arr[index].bid + ')">모달댓글</button>' + 
					 						'<button class="btn btn-secondary">공유</button>' +
					 					'<p><a href="#" data-toggle="modal" data-target="#logout" data-bid="${listBoard.get(i).getBid()}">모달 좋아요 ' + arr[index].likeCount + '개</a>' +
					 					'<p>게시글 내용 ' + arr[index].content +
					 					'<p>' + arr[index].birth +
					 					'<p>' + 
						 					'<form name="form' + arr[index].bid + '" method="post" action="/sns/controller/insertComment?pageRoute=insertComment&bid=' + arr[index].bid + '&commentDetail=Home">' + 
							 					'<input id="comment" name="comment" type="text" class="form-control" placeholder="댓글 달기" style="width: 200px; float: left;">' + 
							 					'<button class="btn btn-secondary">등록(완료)</button>' + 
						 					'</form>' + 
					 					'<p>─────────────────────────────────────────────────────────────'
										;
				document.querySelector('section').appendChild(addContent);
				index++;
			}
		}
	}
	
	////////////////////////////무한 스크롤 코드 종료 //////////////////////////
	//////////////////////////////////////////////////////////////////////
	
	
	// 버튼 눌렀을때 오는 함수
	function scrollStop(pageRoute, bid, boardCount) { 
		
// 		sessionStorage.Y = window.scrollY;
		var y = window.scrollY;
       
		// 좋아요 눌렀을때
		if (pageRoute == 'likeWho') {
			location.href="/sns/controller/likeWho?pageRoute=likeWho&bid=" + bid + "&boardCount=" + boardCount;
		}
       
  	  	// 댓글 눌렀을때
  	  	else if (pageRoute == 'insertComment') {
	       	location.href="/sns/controller/insertComment?pageRoute=insertComment&bid=" + bid + "&commentDetail=Home&boardCount=" + boardCount;
		}
	}

	// 어떤 버튼을 누르던지 다시 그 위치까지 가게 해줌
 	window.scrollTo(0, sessionStorage.Y);
 	
	</script>
    
    <!-- 자바스크립트 코드 종료 -->
    <!-- ─────────────────────────────────────────────────────────────────────────── -->
	
</body>
</html>