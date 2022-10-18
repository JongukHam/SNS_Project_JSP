<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
   <style type="text/css">
      
      /* 무한 스크롤 */
      html, body{
         margin: 0;
      }
      
      h1 {
        position: fixed; top: 0; width: 100%; height: 60px; 
        text-align: center; background: white; margin: 0; line-height: 60px;
      }
      section .box {height: 500px; background: red;}
      section .box p {margin: 0; color: white; padding: 80px 20px;}
      section .box:nth-child(2n) {background: blue;}
      
      /* 게시글 사진 */
      img {
          width: 300px;
          height: 300px;
      }
      
   </style>
<link rel = "stylesheet" href = "http://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css">
<meta charset="UTF-8">
<title>Home</title>
</head>   
<body>
   
   <jsp:include page="../Nav/HomeNav.jsp"/>
   
   <!-- Home 페이지로 처음 오거나 다른 페이지에서 왔을때 게시물의 정보를 출력하기 위해 DB에 있는 게시물 정보를 가져옴 -->
   <c:if test="${listBoard == null }">
      <script>
         location.href="/sns/controller/selectBoard?pageRoute=selectBoard";
      </script>
   </c:if>
   
   
   <!-- 게시물 몇번째까지 출력할것인지 설정하는 변수 -->
<%--    <c:set var="boardEnd" value="${listBoard}"></c:set> --%>
<%--    <c:choose> --%>
<%--       <c:when test="${listBoard.size() > 5}"> --%>
<%--          <c:set var="end" value="5"></c:set> --%>
<%--       </c:when> --%>
<%--       <c:otherwise> --%>
<%--          <c:set var="end" value="${listBoard.size()}"></c:set> --%>
<%--       </c:otherwise> --%>
<%--    </c:choose> --%>
   
   
   <!-- ─────────────────────────────────────────────────────────────────────────── -->
   <!-- 전체 게시물 출력 시작 -->
   
   <div class="container">
      <section>
         <p>─────────────────────────────────────────────────────────────
         <c:choose>
            <%-- 버튼 안눌렀을때 --%>
            <c:when test="${boardCount == null}">
               <c:forEach var="i"  begin="0" end="2">
                     <%-- 게시글 번호(나중엔 삭제 예정) --%>
                       <p><h3>${listBoard.get(i).getBid()}번 게시글</h3>
                       
                       <%-- 게시글 작성자 프사(작성자 페이지 링크), 아이디(작성자 페이지 링크) --%>
                      <p>작성자 프사 <a href="/sns/controller/AcHomePage?m2id=${listBoard.get(i).getId()}">${listBoard.get(i).getPfp()}</a> 아이디 <a href="/sns/controller/AcHomePage?m2id=${listBoard.get(i).getId()}">${listBoard.get(i).getId()}</a>
                      
                      
                      
                     <c:if test="${photo.size() - 1 >= 0}">
                        <div id="demo${i}" class="carousel slide" data-ride="carousel" style="width: 300px;" data-interval="false">
                           <div class="carousel-inner">
                              <div class="carousel-inner" role="listbox">
                                  <c:set var="pCount" value="0"></c:set>
                                  
                                  <%-- 사진 뿌리기 시작 --%>
                                    <c:forEach var="p"  begin="0" end="${photo.size() - 1}">
                                     <c:if test="${photo.get(p).getBid() eq listBoard.get(i).getBid()}">
                                       <c:choose>
                                          <c:when test="${pCount == 0}">
                                          
                                             <div class="carousel-item active">
                                                <img class="" src="../ImageFile/${photo.get(p).getPhoto()}" alt="...">
                                                </div>
                                                <c:set var="pCount" value="${pCount + 1}"></c:set>
                                          </c:when>
                                          
                                          <c:otherwise>
                                             <div class="carousel-item">
                                                <img class="" src="../ImageFile/${photo.get(p).getPhoto()}" alt="...">
                                                </div>
                                                <c:set var="pCount" value="${pCount + 1}"></c:set>
                                          </c:otherwise>
                                          
                                       </c:choose>
                                     </c:if>
                                  </c:forEach>
                                  <%-- 사진 뿌리기 종료 --%>
                              </div>
                              
                               <%-- 화살표 버튼 시작 --%>
                               <a class="carousel-control-prev" href="#demo${i}" data-slide="prev" style="height: 300px;">
                                    <span class="carousel-control-prev-icon" aria-hidden="true"></span>
                                 </a>
                               <a class="carousel-control-next" href="#demo${i}" data-slide="next" style="height: 300px;">
                                    <span class="carousel-control-next-icon" aria-hidden="true"></span>
                               </a>
                               <%-- 화살표 버튼 종료 --%>
                            
                                 <%-- 인디케이터 시작 --%>
                               <ul class="carousel-indicators" style="height: 40px;">
                                    <li data-target="#demo" data-slide-to="0" class="active"></li>
                                    <li data-target="#demo" data-slide-to="1"></li>
                                    <li data-target="#demo" data-slide-to="2"></li>
                               </ul>
                               <%-- 인디케이터 종료 --%>
                             </div>
                        </div>         
                      </c:if>
                      <br>
                      
                      
                      <%-- 좋아요(모달), 댓글(모달), 공유(모달) 버튼 --%>
                     <p>
                        <button class="btn btn-secondary" onclick="scrollStop('likeWho', ${listBoard.get(i).getBid()}, ${i})">좋아요</button>
                        <button class="btn btn-secondary" onclick="scrollStop()">댓글</button>
                        <button class="btn btn-secondary">공유</button>
                        
                     <%-- 좋아요 1개 이상일때만 보여주기 --%>
                     <c:if test="${listBoard.get(i).getLikeCount() != 0}">
                        <p><a href="#" data-toggle="modal" data-target="#logout" data-bid="${listBoard.get(i).getBid()}" onclick="z()">모달 좋아요 ${listBoard.get(i).getLikeCount()}개</a>
                     </c:if>
                     <p>게시글 내용 ${listBoard.get(i).getContent()}
                     
                     <%-- 댓글 1개 이상일때만 보여주기 --%>
                     <c:if test="${listBoard.get(i).getCommentCount() != 0}">
                        <p><a href="/sns/controller/selectBoardDetail?pageRoute=selectBoardDetail&bid=${listBoard.get(i).getBid()}">댓글 ${listBoard.get(i).getCommentCount()}개 보기</a>
                        <p>────────────────────────────
                     </c:if>
                     
                     <%-- 게시글 작성 날짜 --%>
                     <p>${listBoard.get(i).getBirth()}
                     
                     <%-- 댓글 --%>
                     <p>
                        <form name="form${listBoard.get(i).getBid()}" method="post" action="/sns/controller/insertComment?pageRoute=insertComment&bid=${listBoard.get(i).getBid()}&commentDetail=Home">
                           <input id="comment" name="comment" type="text" class="form-control" placeholder="댓글 달기" style="width: 200px; float: left;">
                           <button class="btn btn-secondary">등록</button>
                        </form>
                     <br>
                     <p>─────────────────────────────────────────────────────────────
               </c:forEach>
            </c:when>
            
            <%-- 버튼 눌렀을때 --%>
            <c:otherwise>
               <c:forEach var="i"  begin="0" end="${boardCount + 2}">
                  <%-- 게시글 번호(나중엔 삭제 예정) --%>
                       <p><h3>${listBoard.get(i).getBid()}번 게시글</h3>
                       
                       <%-- 게시글 작성자 프사(작성자 페이지 링크), 아이디(작성자 페이지 링크) --%>
                      <p>작성자 프사 <a href="/sns/controller/AcHomePage?m2id=${listBoard.get(i).getId()}">${listBoard.get(i).getPfp()}</a> 아이디 <a href="/sns/controller/AcHomePage?m2id=${listBoard.get(i).getId()}">${listBoard.get(i).getId()}</a>
                      
                      
                      
                     <c:if test="${photo.size() - 1 >= 0}">
                        <div id="demo${i}" class="carousel slide" data-ride="carousel" style="width: 300px;" data-interval="false">
                           <div class="carousel-inner">
                              <div class="carousel-inner" role="listbox">
                                  <c:set var="pCount" value="0"></c:set>
                                  
                                  <%-- 사진 뿌리기 시작 --%>
                                    <c:forEach var="p"  begin="0" end="${photo.size() - 1}">
                                     <c:if test="${photo.get(p).getBid() eq listBoard.get(i).getBid()}">
                                       <c:choose>
                                          <c:when test="${pCount == 0}">
                                          
                                             <div class="carousel-item active">
                                                <img class="" src="../ImageFile/${photo.get(p).getPhoto()}" alt="...">
                                                </div>
                                                <c:set var="pCount" value="${pCount + 1}"></c:set>
                                          </c:when>
                                          
                                          <c:otherwise>
                                             <div class="carousel-item">
                                                <img class="" src="../ImageFile/${photo.get(p).getPhoto()}" alt="...">
                                                </div>
                                                <c:set var="pCount" value="${pCount + 1}"></c:set>
                                          </c:otherwise>
                                          
                                       </c:choose>
                                     </c:if>
                                  </c:forEach>
                                  <%-- 사진 뿌리기 종료 --%>
                              </div>
                              
                               <%-- 화살표 버튼 시작 --%>
                               <a class="carousel-control-prev" href="#demo${i}" data-slide="prev" style="height: 300px;">
                                    <span class="carousel-control-prev-icon" aria-hidden="true"></span>
                                 </a>
                               <a class="carousel-control-next" href="#demo${i}" data-slide="next" style="height: 300px;">
                                    <span class="carousel-control-next-icon" aria-hidden="true"></span>
                               </a>
                               <%-- 화살표 버튼 종료 --%>
                            
                                 <%-- 인디케이터 시작 --%>
                               <ul class="carousel-indicators" style="height: 40px;">
                                    <li data-target="#demo" data-slide-to="0" class="active"></li>
                                    <li data-target="#demo" data-slide-to="1"></li>
                                    <li data-target="#demo" data-slide-to="2"></li>
                               </ul>
                               <%-- 인디케이터 종료 --%>
                             </div>
                        </div>         
                      </c:if>
                      <br>
                      
                      
                      <%-- 좋아요(모달), 댓글(모달), 공유(모달) 버튼 --%>
                     <p>
                        <button class="btn btn-secondary" onclick="scrollStop('likeWho', ${listBoard.get(i).getBid()}, ${i})">좋아요</button>
                        <button class="btn btn-secondary" onclick="scrollStop()">댓글</button>
                        <button class="btn btn-secondary">공유</button>
                        
                     <%-- 좋아요 1개 이상일때만 보여주기 --%>
                     <c:if test="${listBoard.get(i).getLikeCount() != 0}">
                        <p><a href="#" data-toggle="modal" data-target="#logout" data-bid="${listBoard.get(i).getBid()}" onclick="z()">모달 좋아요 ${listBoard.get(i).getLikeCount()}개</a>
                     </c:if>
                     <p>게시글 내용 ${listBoard.get(i).getContent()}
                     
                     <%-- 댓글 1개 이상일때만 보여주기 --%>
                     <c:if test="${listBoard.get(i).getCommentCount() != 0}">
                        <p><a href="/sns/controller/selectBoardDetail?pageRoute=selectBoardDetail&bid=${listBoard.get(i).getBid()}">댓글 ${listBoard.get(i).getCommentCount()}개 보기</a>
                        <p>────────────────────────────
                     </c:if>
                     
                     <%-- 게시글 작성 날짜 --%>
                     <p>${listBoard.get(i).getBirth()}
                     
                     <%-- 댓글 --%>
                     <p>
                        <form name="form${listBoard.get(i).getBid()}" method="post" action="/sns/controller/insertComment?pageRoute=insertComment&bid=${listBoard.get(i).getBid()}&commentDetail=Home">
                           <input id="comment" name="comment" type="text" class="form-control" placeholder="댓글 달기" style="width: 200px; float: left;">
                           <button class="btn btn-secondary">등록</button>
                        </form>
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
      
   // 스크롤 할때마다 현재 Y축 좌표를 sessionStorage.Y에 담는다. sessionStorage는 자바의 session과 비슷하다 
   window.addEventListener('scroll', () => { 
      sessionStorage.Y = window.scrollY;
   });
   
   // Java → JSTL(EL) → JavaScript 순으로 정보를 옮겨담음 
   // listBoard 가져오기
   var listBoard = new Array();
   <c:forEach items="${listBoard}" var="listBoard">         
      listBoard.push({
         bid            : "${listBoard.getBid()}",
         id            : "${listBoard.getId()}",
         content         : "${listBoard.getContent()}" ,
         birth         : "${listBoard.getBirth()}" ,
         likeCount      : "${listBoard.getLikeCount()}" ,
         pfp            : "${listBoard.getPfp()}" ,
         photo         : "${listBoard.getPhoto()}" ,
         commentCount   : "${listBoard.getCommentCount()}" 
      }); 
    </c:forEach> 
   
   // photo 가져오기
   var listPhoto = new Array();
   <c:forEach items="${photo}" var="photo">         
      listPhoto.push({
         bid            : "${photo.getBid()}",
         photo         : "${photo.getPhoto()}",
         photo2         : "${photo.getPhoto2()}"
      }); 
    </c:forEach>  
   
   // 버튼(좋아요, 댓글 등)을 눌렀을때 몇번째 게시물인지 알수 있는 함수 
   var boardCount = <c:out value="${boardCount}"></c:out>
        
   
   <!-- ─────────────────────────────────────────────────────────────────────────── -->
   <!-- 무한 스크롤 시작 -->
   
   // 버튼(좋아요, 댓글 등)을 눌렀을때 boardCount에 담긴 게시물 index값의 +2번째부터 무한 스크롤 적용
   // 2번째 게시물의 버튼을 눌렀으면 5번째 게시물부터 무한 스크롤 적용(4번째 게시물까지는 미리 만들어놓기 때문)
   if (boardCount != -1) {
      var index = boardCount + 3;
      var index2 = index;
      window.onscroll = function(e) {
         if((window.innerHeight + window.scrollY) >= document.body.offsetHeight) { 
            var addContent = document.createElement("div");
//             addContent.classList.add("box");

            // 좋아요 if
            if (listBoard[index].likeCount > 0) {
               var like = '<p><a href="#" data-toggle="modal" data-target="#logout" data-bid="' + listBoard[index].bid + '">모달 좋아요 ' + listBoard[index].likeCount + '개</a>';
            }
            else {
               var like = '';
            }
            
            // 댓글 if
            if (listBoard[index].commentCount > 0) {
               var comment = '<p><a href="/sns/controller/selectBoardDetail?pageRoute=selectBoardDetail&bid=' + listBoard[index].bid + '">댓글' + listBoard[index].commentCount + '개 보기</a>';
            }
            
            else {
               var comment = '';
            }
            
            // 사진 뿌리기
            var pCount = 0;
            
            if (listPhoto.length -1 >= 0) {
               var photoDivStart = '<div id="demo' + index2 + '" class="carousel slide" data-ride="carousel" style="width: 300px;" data-interval="false">' +
                                   '<div class="carousel-inner">' +
                                      '<div class="carousel-inner" role="listbox">';
                  // listPhoto.length : 12
                  // listPhoto[p].bid : 각 게시물 번호
                  // index : 1부터 올라감
//                   for (var i = 0; i < 2; i++) {
                     for (var p = 0; p < listPhoto.length - 1; p++) {
                        if (listPhoto[p].bid == listBoard[index2].bid) {
                           
                           if (pCount == 0) {
                              photoDivStart +='<div class="carousel-item active">' +
                                             '<img class="" src="../ImageFile/' + listPhoto[p].photo2 + '" alt="...">' +
                                             '</div>';
                                 pCount += 1;
                           }
                           else {
                              photoDivStart +='<div class="carousel-item">' +
                                             '<img class="" src="../ImageFile/' + listPhoto[p].photo2 + '" alt="...">' +
                                             '</div>';
                                 pCount += 1;
                           }
                        }
                     }
//                   }
                                         
                                         
                                         
                                         
               var photoDivEnd =          '</div>' +
               
                                     '<a class="carousel-control-prev" href="#demo' + index2 + '" data-slide="prev" style="height: 300px;">' + 
                                          '<span class="carousel-control-prev-icon" aria-hidden="true"></span>' + 
                                       '</a>' + 
                                     '<a class="carousel-control-next" href="#demo' + index2 + '" data-slide="next" style="height: 300px;">' + 
                                          '<span class="carousel-control-next-icon" aria-hidden="true"></span>' + 
                                     '</a>' + 
                               
                                     '<ul class="carousel-indicators" style="height: 40px;">' + 
                                          '<li data-target="#demo" data-slide-to="0" class="active"></li>' + 
                                          '<li data-target="#demo" data-slide-to="1"></li>' +
                                          '<li data-target="#demo" data-slide-to="2"></li>' +
                                     '</ul>' +
                                 '</div>' +
                              '</div>'
                              ;
            }
            
            
            addContent.innerHTML =  '<p><h3>게시글 번호 ' + listBoard[index].bid + '</h3>' +
//                               '<p>' + 
//                                  '작성자 프사 ' + '<a href="/sns/controller/AcHomePage?m2id=' + listBoard[index].id + '">' + listBoard[index].pfp + '</a> ' +
//                                  '아이디 ' + '<a href="/sns/controller/AcHomePage?m2id=' + listBoard[index].id + '">' + listBoard[index].id + '</a> ' + 
                              photoDivStart + 
                              photoDivEnd + 

//                               '<p>' + 
//                                  '<button class="btn btn-secondary" onclick="scrollStop(\'likeWho\', ' + listBoard[index].bid + ', ' + index + ')">좋아요</button>' +
//                                  '<button class="btn btn-secondary" onclick="scrollStop(' + listBoard[index].bid + ')">댓글</button>' + 
//                                  '<button class="btn btn-secondary">공유</button>' +
                              like +
//                               '<p>게시글 내용 ' + listBoard[index].content +
                              comment + 
//                               '<p>' + listBoard[index].birth +
//                               '<p>' + 
//                                   '<form name="form' + listBoard[index].bid + '" method="post" action="/sns/controller/insertComment?pageRoute=insertComment&bid=' + listBoard[index].bid + '&commentDetail=Home">' + 
//                                      '<input id="comment" name="comment" type="text" class="form-control" placeholder="댓글 달기" style="width: 200px; float: left;">' + 
//                                      '<button class="btn btn-secondary">등록(완료)</button>' + 
//                                   '</form>' + 
                              '<p>─────────────────────────────────────────────────────────────'
                              ;
            document.querySelector('section').appendChild(addContent);
            
            index++;
            index2++;
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
//             addContent.classList.add("box");

            // 좋아요 if
            if (listBoard[index].likeCount > 0) {
               var like = '<p><a href="#" data-toggle="modal" data-target="#logout" data-bid="' + listBoard[index].bid + '">모달 좋아요 ' + listBoard[index].likeCount + '개</a>';
            }
            else {
               var like = '';
            }
            
            // 댓글 if
            if (listBoard[index].commentCount > 0) {
               var comment = '<p><a href="/sns/controller/selectBoardDetail?pageRoute=selectBoardDetail&bid=' + listBoard[index].bid + '">댓글' + listBoard[index].commentCount + '개 보기</a>';
            }
            
            else {
               var comment = '';
            }
            
            // 사진 뿌리기
            var pCount = 0;
            
            if (listPhoto.length -1 >= 0) {
               var photoDivStart = '<div id="demo' + index2 + '" class="carousel slide" data-ride="carousel" style="width: 300px;" data-interval="false">' +
                                   '<div class="carousel-inner">' +
                                      '<div class="carousel-inner" role="listbox">';
                  // listPhoto.length : 12
                  // listPhoto[p].bid : 각 게시물 번호
                  // index : 1부터 올라감
//                   for (var i = 0; i < 2; i++) {
                     for (var p = 0; p < listPhoto.length - 1; p++) {
                        if (listPhoto[p].bid == listBoard[index2].bid) {
                           
                           if (pCount == 0) {
                              photoDivStart +='<div class="carousel-item active">' +
                                             '<img class="" src="../ImageFile/' + listPhoto[p].photo2 + '" alt="...">' +
                                             '</div>';
                                 pCount += 1;
                           }
                           else {
                              photoDivStart +='<div class="carousel-item">' +
                                             '<img class="" src="../ImageFile/' + listPhoto[p].photo2 + '" alt="...">' +
                                             '</div>';
                                 pCount += 1;
                           }
                        }
                     }
//                   }
                                         
                                         
                                         
                                         
               var photoDivEnd =          '</div>' +
               
                                     '<a class="carousel-control-prev" href="#demo' + index2 + '" data-slide="prev" style="height: 300px;">' + 
                                          '<span class="carousel-control-prev-icon" aria-hidden="true"></span>' + 
                                       '</a>' + 
                                     '<a class="carousel-control-next" href="#demo' + index2 + '" data-slide="next" style="height: 300px;">' + 
                                          '<span class="carousel-control-next-icon" aria-hidden="true"></span>' + 
                                     '</a>' + 
                               
                                     '<ul class="carousel-indicators" style="height: 40px;">' + 
                                          '<li data-target="#demo" data-slide-to="0" class="active"></li>' + 
                                          '<li data-target="#demo" data-slide-to="1"></li>' +
                                          '<li data-target="#demo" data-slide-to="2"></li>' +
                                     '</ul>' +
                                 '</div>' +
                              '</div>'
                              ;
            }
            
            
            addContent.innerHTML =  '<p><h3>게시글 번호 ' + listBoard[index].bid + '</h3>' +
//                               '<p>' + 
//                                  '작성자 프사 ' + '<a href="/sns/controller/AcHomePage?m2id=' + listBoard[index].id + '">' + listBoard[index].pfp + '</a> ' +
//                                  '아이디 ' + '<a href="/sns/controller/AcHomePage?m2id=' + listBoard[index].id + '">' + listBoard[index].id + '</a> ' + 
                              photoDivStart + 
                              photoDivEnd + 

//                               '<p>' + 
//                                  '<button class="btn btn-secondary" onclick="scrollStop(\'likeWho\', ' + listBoard[index].bid + ', ' + index + ')">좋아요</button>' +
//                                  '<button class="btn btn-secondary" onclick="scrollStop(' + listBoard[index].bid + ')">댓글</button>' + 
//                                  '<button class="btn btn-secondary">공유</button>' +
                              like +
//                               '<p>게시글 내용 ' + listBoard[index].content +
                              comment + 
//                               '<p>' + listBoard[index].birth +
//                               '<p>' + 
//                                   '<form name="form' + listBoard[index].bid + '" method="post" action="/sns/controller/insertComment?pageRoute=insertComment&bid=' + listBoard[index].bid + '&commentDetail=Home">' + 
//                                      '<input id="comment" name="comment" type="text" class="form-control" placeholder="댓글 달기" style="width: 200px; float: left;">' + 
//                                      '<button class="btn btn-secondary">등록(완료)</button>' + 
//                                   '</form>' + 
                              '<p>─────────────────────────────────────────────────────────────'
                              ;
            document.querySelector('section').appendChild(addContent);
            
            index++;
            index2++;
         }
      }
   }
   
   <!-- 무한 스크롤 종료 -->
   <!-- ─────────────────────────────────────────────────────────────────────────── -->
   
   
   
   // 버튼 눌렀을때 오는 함수
   function scrollStop(pageRoute, bid, boardCount) { 
      
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

   // 버튼을 눌렀을때 다시 그 위치까지 가게 해줌
    window.scrollTo(0, sessionStorage.Y);
    
   </script>
    
    <!-- 자바스크립트 코드 종료 -->
    <!-- ─────────────────────────────────────────────────────────────────────────── -->
   
</body>
</html>