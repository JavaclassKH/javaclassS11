<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <jsp:include page="/WEB-INF/views/include/bs4.jsp" />
<title>Second DIVE - timerTest</title>
<style>
  body {
    display: flex;
    flex-direction: column;
    align-items: center;
    justify-content: center;
    height: 100vh;
    background-color: #f0f0f0;
    font-family: Arial, sans-serif;
  }
  #timer {
    font-size: 3em;
    margin-bottom: 20px;
  }
  #resetButton {
    padding: 10px 20px;
    font-size: 1em;
    cursor: pointer;
  }
</style>
<script>
	document.addEventListener('DOMContentLoaded', () => {
	    let timerValue = 10; // 타이머 시작 값
	    let timerId; // 타이머를 저장할 변수
	    let autoResetId; // 자동 리셋 타이머를 저장할 변수
	
	    // HTML 요소 선택
	    const timerDisplay = document.getElementById('timer');
	    const resetButton = document.getElementById('resetButton');
	
	    // 타이머를 갱신하는 함수
	    const updateTimer = () => {
	        timerDisplay.textContent = timerValue;
	        if (timerValue === 0) {
	            clearInterval(timerId); // 타이머가 0이 되면 타이머를 멈춤
	            startTimer(); // 타이머 다시 시작
	        }
	        timerValue--; // 타이머 값을 1씩 감소
	    };
	
	    // 타이머를 시작하는 함수
	    const startTimer = () => {
	        timerValue = 10; // 타이머 값을 10으로 설정
	        timerDisplay.textContent = timerValue; // 초기 값 표시
	        clearInterval(timerId); // 기존 타이머가 있다면 정리
	        timerId = setInterval(updateTimer, 1000); // 1초마다 updateTimer 호출
	
	        clearTimeout(autoResetId); // 기존 자동 리셋 타이머가 있다면 정리
	        autoResetId = setTimeout(() => {
	            clearInterval(timerId); // 10초 후에 타이머 멈춤
	            startTimer(); // 타이머 다시 시작
	        }, 10000); // 10초 후에 자동 리셋
	    };
	
	    // 버튼 클릭 시 타이머 초기화 및 다시 시작
	    resetButton.addEventListener('click', () => {
	        clearInterval(timerId); // 기존 타이머 멈추기
	        clearTimeout(autoResetId); // 기존 자동 리셋 타이머 멈추기
	        startTimer(); // 타이머 다시 시작
	    });
	
	    // 페이지 로드 시 타이머 시작
	    startTimer();
	});
</script>
</head>
<body>
	<div style="margin-left: 400px; margin-top: 300px;">
		<div id="timer">10</div>
	  <button id="resetButton">타이머 초기화</button>
	  <script src="timer.js"></script>
	</div><br/><hr/><br/>
	<p>
		<a href="${ctp}/">Back</a>
	</p>	
</body>
</html>