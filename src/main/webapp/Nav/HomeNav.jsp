<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="java.sql.*" %>
<%@taglib prefix = "c"	 uri="http://java.sun.com/jsp/jstl/core"%>

<jsp:include page="../CssLink/CssLink.jsp" flush="true" />
<!-- style here -->
<style>
	* { font-family: 'Spoqa Han Sans Neo', 'sans-serif'; }
#homeNav {
  width: 100%;
  position: relative;
  text-align: center;
  margin-top:15px;
  margin-bottom:100px;
}
#homeNav>a {
  display: block;
  font-size: 25px;
  font-weight: 900;
  position: absolute;
  left: 10%;
}

#homeNav>form {
	display:inline-block;
	top:50%;
}
#homeNav>form>input{
	width:240px;
	height:35px;
	border:1px solid #BEC3C9;
	border-radius: 7px;
	background-color:#EFEFEF;
}

/* width 가 1100이상일 때 */
@media(min-width :1000px){
	#homeNav>ul {
	  padding: 0 20px;
	  height: 30px;
	  color: #fff;
	  position: absolute;
	  transform: translateY(-20px);
	  right: 30px;
	  
	  display: inline-block;
	  list-style:none;
	  padding-left:0px;
	}
	#homeNav>ul li {
	  float: left;
	  line-height: 80px;
	  padding: 0 15px;
	}
	#homeNav .sideBar{
	display:none;
	}
}

/* width 가 1100이하로 내려가면 아이콘들 숨기게 하기 */
@media(max-width :1000px){
	#homeNav>ul>.n-sideBar{
		display:none;
	}
	#homeNav>ul>.sideBar {
	  padding: 0 20px;
	  height: 30px;
	  color: #fff;
	  position: absolute;
	  
	  right: 10%;
	  top:10px;
	  display: inline-block;
	  list-style:none;
	  padding-left:0px;
	}
	#homeNav>ul{
	margin-bottom:0px;
	}
}

</style>


<!-- html here -->
<nav id="homeNav">
    <a href="/sns/controller/HomePage">StarGram</a>
    
    <form method="post" name="searchForm" action="/sns/controller/getSearch">
    	<input type="text" name="searchText" />
    </form>

    <ul >
<!--알림 -->
      <li class="n-sideBar"><a href="/sns/controller/checkNoti">
      	<c:choose>
			<c:when test="${notiCount > 0 }"><i class="fa-solid fa-heart"></i></c:when>
			<c:when test="${empty notiCount || notiCount==0 }"><i class="fa-regular fa-heart"></i></c:when>
		</c:choose>
      </a></li>
<!--DM-->
      <li class="n-sideBar"><a href="#"><i class="fa-solid fa-paper-plane"></i></a></li>
<!--글쓰기-->
      <li class="n-sideBar"><a href="/sns/controller/WritePage"><i class="fa-solid fa-pen"></i></a></li>
<!--내페이지-->      
      <li class="n-sideBar"><a href="/sns/controller/goMyPage"><i class="fa-solid fa-circle-user"></i></a></li>
<!--햄버거-->      
      <li class="sideBar"><a href="#"><i class="fa-solid fa-bars"></i></a></li>
    </ul>

  </nav>
