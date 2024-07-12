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
<title>Second DIVE - Quiz Park</title>
<style>
	#quizTime {
		font-size: 140px;
	}
</style>
<script>
	'use strict';
	
	$(document).ready(function(){
		history.scrollRestoration = "auto";
	});
	
	// 아이브상식퀴즈 불러오기 (초기화면)
	function IVEInfoQuiz(part) {
		location.href='${ctp}/play/IVEQuiz/'+part;
	}
	
	// 아이브가사퀴즈 불러오기 (초기화면)
	function IVELyricsQuiz(part) {
		location.href='${ctp}/play/IVEQuiz/'+part;
	}
	
	// 일반상식퀴즈 불러오기 (초기화면)
	function commonQuiz(part) {
		location.href='${ctp}/play/IVEQuiz/'+part;
	}
	
	// 넌센스퀴즈 불러오기 (초기화면)
	function nonsenseQuiz(part) {
		location.href='${ctp}/play/IVEQuiz/'+part;
	}
	
	
	
</script>
</head>
<body>
<jsp:include page="/WEB-INF/views/include/header.jsp" /> 
<jsp:include page="/WEB-INF/views/include/leftSide.jsp" /> 
<div class="rightSide">
	<h2 class="text-center"><b><font size="30px">Quiz Park</font></b></h2>
	<p><br/></p>
	<c:if test="${part == 'main'}">
		<iframe src="${ctp}/play/quizMain" width="1080" height="700" style="margin-left: 70px;" name="quizMain" id="quizMain"></iframe>	
	</c:if>
	<c:if test="${part == 'IVEInfoQuiz'}">
		<iframe src="${ctp}/play/IVEInfoQuiz" width="1080" height="700" style="margin-left: 70px;" name="IVEInfoQuiz" id="IVEInfoQuiz"></iframe>
	</c:if>
</div>
<jsp:include page="/WEB-INF/views/include/footer.jsp" />  
</body>
</html>






















