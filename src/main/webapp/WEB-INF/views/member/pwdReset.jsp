<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <jsp:include page="/WEB-INF/views/include/bs4.jsp" />
  <link rel="stylesheet" href="${ctp}/resources/css/bodyLeftRight.css">
<title>Second DIVE - pwdReset</title>
<style>
	#pwdResetFormDiv {
		margin-left: 400px;
		width: 400px;
		height: 435px;
		border: 1px solid #dee2e6;
		border-radius: 4px;
		padding: 50px 25px 0px 25px;
	}
	
	#findCompletePwd {
		margin-top: 60px;
		margin-left: 400px;
		width: 400px;
		height: 332px;
		border: 1px solid #eff4f8;
		border-radius: 3px;
		padding: 30px 25px 0px 25px;
	}
</style>
<script>
	'use strict';
	
	//
	$(document).ready(function(){
		$("#resetPwdBtn").hover(function(e){
			$("#resetPwd").prop("type", "text");
		}, function(e) {
			$("#resetPwd").prop("type", "password");
		});			
		
		$("#resetPwdCheckBtn").hover(function(f){
			$("#resetPwdCheck").prop("type", "text");
		}, function(f) {
			$("#resetPwdCheck").prop("type", "password");
		});			
	});

	
	// 아이디 찾기 체크
	function pwdResetCheck() {
		let mid = $("#mid").val();
		let nickName = $("#nickName").val();
		let email = $("#email").val();
		
		if(mid.trim() == "") {
			alert("올바른 아이디를 입력해주세요\n아이디를 분실하셨다면 아이디찾기를 이용해주세요");
			$("#midFind").show();
			$("#mid").focus();
			return false;
		}
		else if(nickName.trim() == "") {
			alert("올바른 닉네임을 입력해주세요");
			$("#nickName").focus();
			return false;
		}
		else if(email.trim() == "") {
			alert("올바른 이메일을 입력해주세요");
			$("#email").focus();
			return false;
		}
		
		let d = {
			mid : mid,		
			nickName : nickName,		
			email : email		
		}
		
		$("#mailLoading").show();
		$("#notMailLoading").hide();
		
		$.ajax({
			url : "${ctp}/member/pwdReset",
			type : "post",
			data : d,
			success:function(result){
				$("#mailLoading").hide();
				$("#notMailLoading").show();
				let r = result.split("/");
				let res = r[0];
				let authNo = r[1];
				if(res == "exits") {					
					alert("회원정보 확인 완료!\n이메일로 발송된 인증문자를 입력해주세요");
					$("#auth").show();			
					$("#authNoHidden").val(authNo);			
					$("#before").hide();			
					return false;
				}
				else {
					alert("회원정보 확인 실패!\n올바른 회원정보를 입력해주세요");
					location.reload();					
					return false;
				}
			},
			error:function(){
				alert("5Ryu");
			}
		});

	}
	
	// 인증번호 확인
	function authNoCheck() {
		let authNo = $("#authNoHidden").val();		
		let no = $("#no").val();	
		
		if(no != authNo) {
			alert("인증문자가 일치하지 않습니다");
			location.href="${ctp}/member/authNoDelete";
			return false;
		}
		
		alert("입력하신 인증문자가 일치합니다\n비밀번호 재설정시스템이 가동됩니다");
		$("#findCompletePwd").show();
		$("#pwdResetFormDiv").hide();
	}

	// 비밀번호 재설정 완료하기
	function pwdResetExecute() {
		let resetPwd = $("#resetPwd").val();
		let resetPwdCheck = $("#resetPwdCheck").val();
		
		if(resetPwd.trim() == "") {
			alert("비밀번호를 입력하세요");
			$("#resetPwd").focus();
			return false;
		}
		else if(resetPwdCheck.trim() == "") {
			alert("비밀번호확인을 입력하세요");
			$("#resetPwdCheck").focus();
			return false;
		}
		else if(resetPwd != resetPwdCheck) {
			alert("비밀번호가 일치하지 않습니다\n정확히 입력해주세요");
			$("#resetPwd").focus();
			return false;
		}
		
		location.href="${ctp}/member/pwdResetExecute?resetPwd="+resetPwd;
		return false;
	}
	
	
</script>
</head>
<body>
<jsp:include page="/WEB-INF/views/include/header.jsp" /> 
<jsp:include page="/WEB-INF/views/include/leftSide.jsp" /> 
<div class="rightSide">
	<div id="mailLoading" style="display: none;">
		<div class="container">
			<img src="${ctp}/images/loading.gif" width="100%" /><br/>
			<p class="text-center" style="font-size: 28px;">메일로 인증문자를 발송중입니다</p>
		</div>
	</div>
	<div id="notMailLoading">
	  <h1 class="text-center"><b>비밀번호 재설정하기</b></h1><br/><br/><br/>
	  <div id="pwdResetFormDiv">
	  	<div id="before">
		 		<div class="input-group mb-4">
		 			<div class="input-group-prepend">
		 				<input type="button" value="아이디" title="아이디" class="btn btn-warning" disabled />
		 			</div>
		  		<input type="text" name="mid" id="mid" placeholder="아이디를 입력하세요" style="opacity: 0.8;" class="form-control" autofocus required />
		 			<div class="input-group-append">
		 				<input type="button" value="아이디찾기" id="midFind" onclick="location.href='${ctp}/member/midFind';" class="btn btn-secondary" style="display: none;" /> 				
		 			</div>
		 		</div><br/>
		 		<div class="input-group mb-4">
		 			<div class="input-group-prepend">
		 				<input type="button" value="닉네임" title="닉네임" class="btn btn-primary" disabled />
		 			</div>
		  		<input type="text" name="nickName" id="nickName" placeholder="닉네임을 입력하세요" style="opacity: 0.8;" class="form-control" required />
		 		</div><br/>
		 		<div class="input-group mb-5">
		 			<div class="input-group-prepend">
		 				<input type="button" value="이메일" title="이메일" class="btn btn-dark" disabled />
		 			</div>
		  		<input type="email" name="email" id="email" placeholder="정확한 이메일을 입력하세요" style="opacity: 0.8;" class="form-control" required />
		 		</div>
	 		</div>
	 		<div class="input-group mb-5" id="auth" style="display: none;">
	 			<input type="hidden" name="authNoHidden" id="authNoHidden" />
	 			<div class="input-group-prepend">
	 				<input type="button" value="인증번호" title="인증번호" class="btn btn-dark" disabled />
	 			</div>
	  		<input type="text" name="no" id="no" placeholder="메일로 발송된 인증번호를 입력하세요" style="opacity: 0.8;" class="form-control mb-5" />
	 			<div>
		 			<input type="button" onclick="authNoCheck()" value="인증번호확인" title="인증번호확인" class="btn btn-secondary" />
	 			</div>
	 		</div><br/>
	 		<div class="mt-2 text-center">
	 			<button onclick="pwdResetCheck()" class="btn btn-info">확인</button>
	 		</div><br/>
	  </div><p><br/></p><br/>
	  <div id="findCompletePwd" style="display: none;">
	  	<p class="text-center text-danger" style="font-size: 25px;"><b>비밀번호 재설정${midBackUp}</b></p><br/>
	  	<div class="input-group mb-3">
	  		<div>
	  			<button class="btn btn-light" id="resetPwdBtn">비밀번호</button>
	  		</div>
	  		<input type="password" name="cc" id="resetPwd" class="form-control" />
	  	</div><br/>
	  	<div class="input-group">
	  		<div>
	  			<button class="btn btn-light" id="resetPwdCheckBtn">비밀번호확인</button>
	  		</div>
	  		<input type="password" name="resetPwdCheck" id="resetPwdCheck" class="form-control" />
	  	</div><br/>
	  	<div id="sameCheck" class="text-center mb-3"></div>
	  	<div class="text-center">
	  		<button type="button" onclick="pwdResetExecute()" class="btn btn-info">재설정하기</button>
	  	</div>
	  </div>  
  </div>
</div>
<jsp:include page="/WEB-INF/views/include/footer.jsp" />  
</body>
</html>