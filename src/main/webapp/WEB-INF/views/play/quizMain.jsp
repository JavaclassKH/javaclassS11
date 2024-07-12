<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<html>
<head>
<jsp:include page="/WEB-INF/views/include/bs4.jsp" />
<style>
	.text-center {
		margin-bottom: 150px;
	}
	
	.btns {
		text-align: center;
		margin-right: 5px;
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
	<div class="text-center text-info"><font size="40px">IVE 상식 퀴즈~</font></div>
	<div class="btns">
		<button onclick="quizStart('IVEInfoQuiz')" id="startBtn" class="btn btn-link">아이브상식</button>
		<button onclick="quizStart('IVELyricsQuiz')" id="startBtn" class="btn btn-link">아이브가사</button>
		<button onclick="quizStart('commonQuiz')" id="startBtn" class="btn btn-link">일반상식</button>
		<button onclick="quizStart('nonsenseQuiz')" id="startBtn" class="btn btn-link">넌센스</button>
		<button onclick="quizFinish()" id="finishBtn" class="btn btn-link">메인으로</button>
	</div>
</body>
</html>
















