<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="java.sql.*" %>
<%@taglib prefix = "c"	 uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
<head>
<link href='//spoqa.github.io/spoqa-han-sans/css/SpoqaHanSansNeo.css' rel='stylesheet' type='text/css'>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/css/bootstrap.min.css">

<script src="https://cdn.jsdelivr.net/npm/jquery@3.6.0/dist/jquery.slim.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/js/bootstrap.bundle.min.js"></script>

<meta charset="UTF-8">
<title>SettingPage</title>
<style>
	* { font-family: 'Spoqa Han Sans Neo', 'sans-serif'; }
	#editPage{
		display:flex;
		border:1px solid black;
		border-radius : 7px;
	}
	#editPage>.names{
		margin-left:7%;
		border:1px solid red;
		border-radius : 7px;
		width:27%;
		text-align:center;
	}
	#editPage>.contents{
		border:1px solid green;
		border-radius : 7px;
		width:60%;
		padding-left:30%;
	}
	#editPage ul{
		list-style:none;
		padding-left:0px;
		padding-top:20px;
	}
	#editPage li{
		margin-bottom:25px;
	}
	#editPage .Logout{
		
	}
	#editPage .delAccount > a{
		color:red;
	}
</style>
</head>	
<!-- 회원삭제시 비밀번호끼리 틀리게 적거나, 데이터베이스에 있는 비밀번호와 입력된 비밀번호가 틀리다면 회원이 삭제되지 않게 -->
<script>
	
	function deleteSubmit(){
		var form = document.deleteAccountForm;
		var pw = document.deleteAccountForm.password.value;
		var cpw = document.deleteAccountForm.confirmPassword.value;
		var el = document.getElementsByClassName('deleteInputPw');
		if(pw!==cpw){	
			for(var i=0; i<el.length; i++){	el[i].value = '';}
			alert("입력한 두 비밀번호가 일치하지 않습니다.")
		}else{
			form.submit();
		}
	}
</script>

<jsp:include page="../Nav/HomeNav.jsp" flush="true" />
<body>
<div class="container">
	<div id="editPage">
			<div class="names">
				<ul>
					<li>아이디</li>
					<li>이름</li>
					<li>이메일</li>
					<li>전화번호</li>
					<li>생년월일</li>
					<br/>
					<br/>
					<li class="Logout"><a href="#" data-toggle="modal" data-target="#logout">로그아웃</a></li>
					<li class = "delAccount"><a href="#" data-toggle="modal" data-target="#delAcModal">회원탈퇴</a></li>
				</ul>
			</div>
			<div class="contents">
				<ul>
					<li>${memberId}</li>
					<li>${memberInfo.getName()}</li>
					<li>${memberInfo.getEmail() }</li>
					<li>${memberInfo.getPhone() }</li>
					<li>${memberInfo.getBirth() }</li>
				</ul>
			</div>
	</div>
</div>

<!-- 모달창 -->
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
				</div>

				<!-- Modal footer -->
				<div class="modal-footer">
					<button type="button" class="btn btn-primary" data-dismiss="modal">취소</button>
					<button type="button" class="btn btn-primary" data-dismiss="modal"onclick="location.href='/sns/controller/Logout'">로그아웃</button>
				</div>
			</div>
		</div>
	</div>

	<div class="modal" id="delAcModal">
		<div class="modal-dialog">
			<div class="modal-content">

				<!-- Modal Header -->
				<div class="modal-header">
					<h4 class="modal-title">회원탈퇴</h4>
				</div>

				<!-- Modal body -->
				<div class="modal-body">
					<p>회원탈퇴를 위해서 패스워드를 입력해 주십시오
					<form id="deleteAccountForm" name="deleteAccountForm" class="was-validated" action="/sns/controller/deleteAccount">
						<div>
							<input type="password" name="password" class="form-control deleteInputPw" required />
							<div class="valid-feedback"></div>
							<div class="invalid-feedback">비밀번호를 입력해 주세요</div>
						</div>
						<div>
							<input type="password" name="confirmPassword" class="form-control deleteInputPw" required />
							<div class="valid-feedback"></div>
							<div class="invalid-feedback">비밀번호를 입력해 주세요</div>
						</div>
						<div>
							<button type="button" class="btn btn-primary" data-dismiss="modal" style="margin-left:60%;">취소</button>
							<button type="button" class="btn btn-danger" data-dismiss="modal"onclick="deleteSubmit()">회원탈퇴</button>
						</div>
					</form>
				</div>

				
				
			</div>
		</div>
	</div>



</body>
</html>