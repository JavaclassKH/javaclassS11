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
<title>Second DIVE - midFind</title>
<style>
	#midFindFormDiv {
		margin-left: 400px;
		width: 400px;
		height: 280px;
		border: 1px solid #dee2e6;
		border-radius: 4px;
		padding: 50px 25px 0px 25px;
	}
	
	#findCompleteMid {
		margin-top: 80px;
		margin-left: 400px;
		width: 400px;
		height: 120px;
		border: 1px solid #eff4f8;
		border-radius: 4px;
	}
</style>
<script>
	'use strict';
	
	// 아이디 찾기 체크
	function midFindCheck() {
		let nickName = $("#nickName").val();
		let email = $("#email").val();
		
		if(email.trim() == "") {
			alert("이메일을 입력해주세요");
			$("#email").focus();
			return false;
		}
		else if(nickName.trim() == "") {
			alert("닉네임을 입력해주세요");
			$("#nickName").focus();
			return false;
		}
		
		$.ajax({
			url : "${ctp}/member/midFindCheck",
			type : "post",
			data: {
				nickName : nickName,
				email : email
			},
			success:function(mid){
				let mid_1 = mid.substring(0,3);
				let mid_2 = mid.substring(3).replaceAll(/./g, "★");
				let yourMid = mid_1 + mid_2;
				
				alert(mid);
				alert(yourMid);
				
				if(mid == 'notFoundMid') {
					alert("해당 닉네임과 이메일로 등록된 회원이 존재하지 않습니다");
					return false;
				}
				
				$("#findCompleteMid").show();
				$("#yourMid").text(yourMid);
				$("#findMid").val(mid);
			},
			error:function(){
				alert("전송오류");
			}
		});
	}
	
	// 아이디 찾은 후 로그인
	function findAfterLogin() {
		let findMid = document.getElementById("findMid").value;
		location.href="${ctp}/member/memberLogin?mid="+findMid+"&check=true";
	}
	
	
</script>
</head>
<body>
<jsp:include page="/WEB-INF/views/include/header.jsp" /> 
<jsp:include page="/WEB-INF/views/include/leftSide.jsp" /> 
<div class="rightSide">
  <h1 class="text-center"><b>아이디 찾기</b></h1><br/><br/><br/>
  <div id="midFindFormDiv">
 		<div class="input-group mb-4">
 			<div class="input-group-prepend">
 				<input type="button" value="닉네임" title="닉네임" class="btn btn-light" disabled />
 			</div>
  		<input type="text" name="nickName" id="nickName" placeholder="닉네임을 입력하세요" style="opacity: 0.5;" class="form-control" autofocus required />
 		</div>
 		<div class="input-group mb-5">
 			<div class="input-group-prepend">
 				<input type="button" value="이메일" title="이메일" class="btn btn-light" disabled />
 			</div>
  		<input type="email" name="email" id="email" placeholder="이메일을 입력하세요" style="opacity: 0.5;" class="form-control" required />
 		</div>
 		<div class="mt-2 text-center">
 			<button onclick="midFindCheck()" class="btn btn-info">찾기</button>
 		</div><br/><br/>
  </div>
	<div id="findCompleteMid" style="text-align: center; display: none;">
		<div style="margin-top: 34px;">
			<p>회원님의 아이디는 : <span id="yourMid"></span> 입니다</p>
			<p><a href="javascript:findAfterLogin()" class="btn btn-link">로그인하러가기</a></p>
			<p><input type="hidden" id="findMid" /></p>
		</div>
	</div>
</div>
<jsp:include page="/WEB-INF/views/include/footer.jsp" />  
</body>
</html>