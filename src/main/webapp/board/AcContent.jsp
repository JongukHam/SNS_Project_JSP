<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix = "c"    uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>




<%   
   
   String index=request.getParameter("index");   
   String m2id=request.getParameter("m2id");
   int len=0;
//    index="4";//테스트 끝나고 삭제
//    m2id="admin";//테스트 끝나고 삭제
   
   
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
    <h1 class="pageTitle">Infinity scroll(index : ${param.index+1 }, 게시물 갯수 : ${len }) </h1>
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



var index = '${param.index+3}';
var indexs = '${param.index-3}';
window.onscroll = function(e) {   
    if(arr.length>0){
    	
       if((window.innerHeight + window.scrollY) >= document.body.offsetHeight-50 && ${param.index}<${len-2}) {           
	          //실행할 로직 (콘텐츠 추가), 바로윗구문 오른쪽에 -100해주면 스크롤 바닥 닿기전 페이지 로드                  
	           var addContent = document.createElement("div");
	            addContent.classList.add("container")      
	            addContent.innerHTML = "<div id='bphoto"+index+"'><div style='display:flex;'>"+
	            " <div class='box'>"+
	            "<img class='profile' src='${memberlist.getPfp() }'/>"+
	            "</div><div class='profile'><p onclick='location.href=\"../Home/Achome.jsp\";'/> id:<%=m2id %>, "+
	            arr[index].bid+"번째글, infinity</div></div>"+
	            "<img id='bphoto' src='"+arr[index].photo+"'/></div>"
	            document.querySelector('section').appendChild(addContent);
	          
	           ++index;  
	       
               
        }else if(window.scrollY<=50){
    	   var addContent = document.createElement("div");
           addContent.classList.add("container")      
           addContent.innerHTML = "<div id='bphoto"+indexs+"'><div style='display:flex;'>"+
           " <div class='box'>"+
           "<img class='profile' src='${memberlist.getPfp() }'/>"+
           "</div><div class='profile'><p onclick='location.href=\"../Home/Achome.jsp\";'/> id:<%=m2id %>, "+
           arr[indexs].bid+"번째글, infinity</div></div>"+
           "<img id='bphoto' src='"+arr[indexs].photo+"'/></div>"
           document.querySelector('section').prepend(addContent);
         
          --indexs;  
       }

    }
};
</script> 

<c:set var="index" value="2"/>
   <section>
    <c:choose>
       <c:when test="${param.index-2<=0}"> <!--3번째 미만의 게시글부터 -->
         <c:forEach var="i" begin="0" end="${param.index+2}">  
             <div class="container" >
             	<div id="bphoto${i }">
	                <div style="display:flex;">
	                  <div class="box" style="width: 40px; height: 40px;border-radius: 70%;overflow: hidden;background: #BDBDBD;" >
	                      <img class="profile" src="${memberlist.getPfp() }"/>                                     
	                  </div>               
	                  <div class="profile">                  
	                  	<p onclick="location.href='../Home/AcHome.jsp';" > id:<%=m2id %>, ${i+1}번째글 , 글갯수 : ${len }
	                  </div>
	                </div>
					<p > ${boardlist.get(i).getPhoto()} <p/>     
				</div>            
             </div>         
         </c:forEach>
       </c:when> 
       
       <c:otherwise>
	       	 <c:choose>
			       <c:when test="${param.index-2>0&&param.index<len-2}"> <!--3번째 게시글부터 -->
			         <c:forEach var="i" begin="${param.index-2}" end="${param.index+2}">  
			             <div class="container" >
			             	<div id="bphoto${i }">
				                <div style="display:flex;">
				                  <div class="box" style="width: 40px; height: 40px;border-radius: 70%;overflow: hidden;background: #BDBDBD;" >
				                      <img class="profile" src="${memberlist.getPfp() }"/>                                     
				                  </div>               
				                  <div class="profile">                  
				                  	<p onclick="location.href='../Home/AcHome.jsp';" > id:<%=m2id %>, ${i+1}번째글, 글갯수 : ${len }
				                  </div>
				                </div>
								<p > ${boardlist.get(i).getPhoto()} <p/>     
							</div>            
			             </div>         
			         </c:forEach>
			       </c:when> 
			        
			               
			     	<c:otherwise>
			     		
			     		<c:if test="${len-1>0 }">
					         <c:forEach var="i" begin="${param.index-2}" end="${len-1}">  
					             <div class="container" >
					             	<div id="bphoto${i }">
						                <div style="display:flex;">
						                  <div class="box" style="width: 40px; height: 40px;border-radius: 70%;overflow: hidden;background: #BDBDBD;" >
						                      <img class="profile" src="${memberlist.getPfp() }"/>                                     
						                  </div>               
						                  <div class="profile">                  
						                  	<p onclick="location.href='../Home/AcHome.jsp';" > id:<%=m2id %>, ${i+1}번째글 , 글갯수 : ${len}, ${boardlist.size()-1}
						                  </div>
						                </div>
										<p > ${boardlist.get(i).getPhoto()} <p/>     
									</div>            
					             </div>         
					         </c:forEach>
				         </c:if>
			    	</c:otherwise>
		    	</c:choose>
    	</c:otherwise>
     </c:choose>
    </section> 
</div>

<script>
//선택한 게시글 위치
var selectedboard = document.querySelector("#bphoto${param.index}").offsetTop;
//상단의 고정메뉴 높이값
var menus = document.querySelector(".pageTitle").offsetHeight + 30; 

//해당위치로 스크롤 이동
window.scrollTo({top:selectedboard-menus, behavior:'auto'});
</script> 


</html>