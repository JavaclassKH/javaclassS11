<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<html>
<head>
<jsp:include page="/WEB-INF/views/include/bs4.jsp" />
<style>
	.text-center {
		margin-bottom: 45px;
	}
	
	.btns {
		text-align: center;
	}
	
	#startBtn1 {
		margin-right: 40px;
	}
	
	#startBtn2 {
		margin-right: 40px;
	}
	
	#startBtn3 {
		margin-right: 40px;
	}
	
	#startBtn4 {
		margin-right: 40px;
	}
	
</style>	
<script>
	'use strict';
	
	// 퀴즈 시작! 
	function quizStart(part) {
		location.href="${ctp}/play/"+part+"/before";
	}
	
</script>
</head>
<body>
	<div>
		<img src="${ctp}/images/quizMainImage.jpg" width="100%" height="70%" />
		<div class="text-center text-info"><font size="40px">Quiz Time</font></div>
		<div class="btns">
			<button onclick="quizStart('IVEInfoQuiz')" id="startBtn1" class="btn btn-light">아이브상식</button>
			<button onclick="quizStart('IVELyricsQuiz')" id="startBtn2" class="btn btn-light">아이브가사</button>
			<button onclick="quizStart('commonQuiz')" id="startBtn3" class="btn btn-light">일반상식</button>
			<button onclick="quizStart('nonsenseQuiz')" id="startBtn4" class="btn btn-light">넌센스</button>
			<button onclick="window.parent.location.href='${ctp}/member/myPage';" class="btn btn-dark">마이페이지</button>
		</div>
	</div>
</body>
</html>
















