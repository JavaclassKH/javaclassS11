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
<title>Second DIVE - memberJoinAgreement</title>
<style>
	.checkBoxes {
		width: 516px;
		margin-left: 350px;
		margin-top: 70px;
		text-align: left;
	}

	#agree1,	#agree2,	#agree3 {
		width: 512px;
		height: 180px;
		border: 1px solid gray;
		border-radius: 3px;
		opacity: 0.8;
		display: none;
		overflow: scroll;
	}
	 
</style>
<script>
	'use strict';
	
	// 체크박스 전체선택
	function selectAll() {
		alert("가입약관을 꼼꼼히 확인해주십시오.\n가입약관 미확인으로 벌어진 일들에 대한 귀책사유는\n모두 회원님에게 돌아갑니다");
		let checkboxes = document.getElementsByName('checkboxes');

    for(let i=0; i<checkboxes.length; i++) {
      checkboxes[i].checked = true;
    }			
		
	}
	
	
	function agreeCheck() {
	 // 모든 체크박스를 이름으로 가져옵니다
	  let checkboxes = document.getElementsByName('checkboxes');
	  let allChecked = true;
	
	  // 체크박스 전체선택여부 확인
	  for(let i=0; i<checkboxes.length; i++) {
	    if (!checkboxes[i].checked) {
	      allChecked = false;
	      break;
	    }
	  }
	
	  // 모든 체크박스가 선택되었다면 회원가입 화면으로 이동
	  if (allChecked) {
		  alert("회원가입 페이지로 이동합니다");
	    location.href = '${ctp}/member/memberJoin';
	  } else {
	    alert('모든 약관에 동의해야 회원가입을 진행할 수 있습니다');
	  }
	}
</script>
</head>
<body>
<jsp:include page="/WEB-INF/views/include/header.jsp" /> 
<jsp:include page="/WEB-INF/views/include/leftSide.jsp" /> 
<div class="rightSide">
  <h2 class="text-center"><b>Second DIVE 회원가입을 환영합니다~</b></h2>
  <form name="checkboxesForm">
  	<div class="checkBoxes">
  		<input type="checkbox" name="checkboxes" id="c1" /> 이용약관 동의(필수) <br/><br/>
  		<input type="checkbox" name="checkboxes" id="c2" /> 개인정보 수집, 이용 동의(필수) <br/><br/>
  		<input type="checkbox" name="checkboxes" id="c3" /> 개인정보 이용 동의(필수) <br/><br/>
  	</div>
  </form><br/>
 	<div class="mt-5" style="margin-left: 352px;">
 		<button id="checkAll" onclick="selectAll()" class="btn btn-danger"><b>전체선택</b></button><br/><br/>
 	</div>
  <div class="text-center" style="margin-top: 150px;">  	
	  <button onclick="agreeCheck()" class="btn btn-success">가입동의</button>
  </div>
</div>
<jsp:include page="/WEB-INF/views/include/footer.jsp" />  
</body>
</html>









