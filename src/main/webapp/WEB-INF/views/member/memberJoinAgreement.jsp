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
<script>
	'use strict';
	
	// 회원가입 약관동의 확인!
	function agreeCheck() {
	 // 모든 체크박스를 이름으로 가져옵니다
	  var checkboxes = document.getElementsByName('checkboxes');
	  var allChecked = true;
	
	   // 모든 체크박스가 선택되었는지 확인합니다
	  for (var i = 0; i < checkboxes.length; i++) {
	    if (!checkboxes[i].checked) {
	      allChecked = false;
	      break;
	    }
	  }
	
	   // 모든 체크박스가 선택되었다면 리디렉션합니다
	  if (allChecked) {
	    location.href = '${ctp}/member/memberJoin';
	  } else {
	    alert('모든 약관에 동의해야 회원가입을 진행할 수 있습니다.');
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
  	<div>
  		<input type="checkbox" name="checkboxes" /> 이용약관 동의(필수)
  		<input type="checkbox" name="checkboxes" /> 개인정보 수집, 이용 동의(필수)
  		<input type="checkbox" name="checkboxes" /> 개인정보 이용 동의(필수)
  	</div>
  </form><br/>
  <button onclick="agreeCheck()" class="btn btn-success">가입동의</button>
</div>
<jsp:include page="/WEB-INF/views/include/footer.jsp" />  
</body>
</html>









