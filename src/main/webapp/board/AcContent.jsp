<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix = "c"    uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="java.util.*" %>
<%@ page import="board.boardDTO"%>
<!DOCTYPE html>
<html>




<%   
   String index=request.getParameter("index");
   String m2id=request.getParameter("m2id");
   if(m2id!=null){
      if (request.getAttribute("boardlist") == null) {
         response.sendRedirect("/sns/controller/selectAc?pageRoute=selectAc&m2id="+m2id+"&index="+index);
      } 
   } else { %>  <%} 
   
%>




<header>           
   <style>
      <%@ include file="style.jsp" %>         
   </style>   
   <link rel = "stylesheet" href="http://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css">
   
   <button type="button" style="font-color:white;" onclick="location.href='../Home/AcHome.jsp'">AcHome</button>
    <h1 class="pageTitle">Infinity scroll(index : ${param.index+1 }, boardlist : ${len}) </h1>
</header>
   
<div class="infinity">

<script type="text/javascript">

var arr = new Array();
<c:forEach items="${boardlist}" var="item">        
   arr.push({bid: "${item.getBid()}"
   , title : "${item.getTitle()}"
   , content : "${item.getContent()}"
   , birth : "${item.getBirth()}"
   , likecount : "${item.getLikeCount()}"
   , photo : "${item.getPhoto()}"
   ,id : "${item.getId()}"});
</c:forEach>


var index = '${param.index+2}';
window.onscroll = function(e) {   
    if(arr.length>0){
       if((window.innerHeight + window.scrollY) >= document.body.offsetHeight-100) {           
          //실행할 로직 (콘텐츠 추가), 바로윗구문 오른쪽에 -100해주면 스크롤 바닥 닿기전 페이지 로드                  
           var addContent = document.createElement("div");
            addContent.classList.add("container")            
            addContent.innerHTML = "<div style='display:flex;'>"+
            " <div class='box'>"+
            "<img class='profile' src='${memberlist.getPfp() }'/>"+
            "</div><div class='profile'><p onclick='location.href=\"../Home/Achome.jsp\";'/> id:<%=m2id %>, "+
            arr[index].bid+"번째글, infinity</div></div>"+
            "<img id='bphoto' src='"+arr[index].photo+"'/>"
            document.querySelector('section').appendChild(addContent);
          
           ++index;  
               
       } 

    }
};
</script> 

<c:set var="index" value="2"/>
   <section>
    <c:choose>
       <c:when test="${param.index-3>=0}"> 
         <c:forEach var="i" begin="${param.index-3 }" end="${param.index+1}">
             <div class="container" >
                <div style="display:flex;">
                  <div class="box" style="width: 40px; height: 40px;border-radius: 70%;overflow: hidden;background: #BDBDBD;" >
                      <img class="profile" src="${memberlist.getPfp() }"/>                                     
                  </div>               
                  <div class="profile">
                      <p onclick="location.href='../Home/AcHome.jsp';" > id:<%=m2id %>, ${boardlist.get(i).getBid() }번째글 
                  </div>
                </div>
                <img id="bphoto" src="${boardlist.get(i).getPhoto()}"/>                      
             </div>         
         </c:forEach>
       </c:when> 
       <c:otherwise>
           <c:if test="${param.index>=0 && param.index<3}">
             <c:forEach var="i" begin="0" end="${param.index +1}">
                <div class="container" >
                   <div style="display:flex;">
                     <div class="box" style="width: 40px;height: 40px;border-radius: 70%;overflow: hidden;background: #BDBDBD;">
                         <img class="profile" src="${memberlist.getPfp() }" />                                       
                     </div>               
                     <div class="profile">
                         <p onclick="location.href='../Home/AcHome.jsp';" > id:<%=m2id %>, ${boardlist.get(i).getBid() }번째글 
                     </div>
                   </div>
                   <img id="bphoto" src="${boardlist.get(i).getPhoto()}"/>                      
                </div>
             </c:forEach>
          </c:if>
         </c:otherwise>
    </c:choose>   
    </section>
 
</div>
</html>