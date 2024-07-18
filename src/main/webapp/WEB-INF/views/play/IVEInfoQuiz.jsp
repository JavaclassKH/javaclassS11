<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<html>
<head>
<jsp:include page="/WEB-INF/views/include/bs4.jsp" />
<script>
	'use strict';
	// 컨트롤러에 시작신호 보내기 
	function start() {
		location.href="${ctp}/play/IVEInfoQuiz/start";
	}
	
	// 정답여부 확인하기! 정답이면 점수 증가 후 다음 문제로
	function answerCheck(ans) {
		if(ans == '${vo.quizAnswer}') {
			alert("정답여부 체크 테스트!");			
			location.href="${ctp}/play/IVEInfoQuiz/start?score=10";
		}
		else { // 오답이면 화면에 오답여부만 띄워주기! 
			alert("오답여부 체크 테스트!");
			setTimeout(function(){
				$("#wrong").show();
			}, 200);		
		
		}
	}
	
	let count = 0;
	let stopper = 0;
	
	
	$(document).ready(function() {
		if('${check}' == 'start') {
			$("#before").hide();
			$("#start").show();
			
  	 	let timerValue = 10; // 타이머 시작 값
      let timerId; // 타이머를 저장할 변수
      let autoResetId; // 자동 리셋 타이머를 저장할 변수
      let count; // 타이머 값을 저장할 변수
	
	    // HTML 요소 선택
	    const timerDisplay = document.getElementById('timer');
	    const resetButton = document.getElementById('resetButton');

	    const updateTimer = () => {
        timerDisplay.textContent = timerValue;
        count = timerValue; // 타이머 값을 count 변수에 저장
        if (count <= 1) { // script상에서 0을 출력하기 전, 즉 1까지의 값을 출력하고 10으로 다시 초기화시키므로 0이라는 숫자가 count변수에 담기지 않음
          location.href="${ctp}/play/IVEInfoQuiz/start?score=0"; // 타이머가 1 이하가 되면 해당 경로로 이동
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
	
	    // 버튼 클릭 시 타이머 초기화 및 퀴즈 종료
	    resetButton.addEventListener('click', () => {
        clearInterval(timerId); // 기존 타이머 멈추기
        clearTimeout(autoResetId); // 기존 자동 리셋 타이머 멈추기
        location.href="${ctp}/play/IVEInfoQuiz/before";
	    });
	    
	
	    // 페이지 로드 시 타이머 시작
	    startTimer();
		}
		// 10문제 출제 완료(퀴즈 종료)
		else if('${check}' == 'finish') {
			clearInterval(timerId); // 기존 타이머 멈추기
		  clearTimeout(autoResetId); // 기존 자동 리셋 타이머 멈추기
		}
	});

		
	
		
</script>
</head>
<body>
	<div id="before">
		<div>
			<img src="${ctp}/images/IVEInfoQuizMain.png" width="100%" height="65%" style="margin-left: 20px;" />
			<p style="margin-top: 20px; margin-bottom: 50px; text-align: center;">아이브 상식 퀴즈</p>
			<div style="text-align: center;">
			<button onclick="start()" class="btn btn-light mr-5">퀴즈시작</button>
			<a href="window.parent.location.href='${ctp}/play/IVEQuiz';" class="btn btn-dark ml-4">퀴즈파크</a>
			</div>
		</div>
	</div>
	<div id="start" style="display: none;">
		<p style="margin-top: 20px; margin-bottom: 150px; text-align: center;">
			아이브 상식 퀴즈 도전중~ &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <span id="timer"></span><br/>
		</p>
		<p class="text-center" style="margin-bottom: 40px;">문제 : ${vo.quizQuestion}</p><br/>
		<div class="text-center">
			<c:if test="${!empty vo}"><c:set var="quizbogi" value="${fn:split(vo.quizbogi,'/')}" /></c:if>
			<button onclick="answerCheck('${quizbogi[0]}')" id="b1" class="btn btn-light mb-3">${quizbogi[0]}</button><br/>
			<button onclick="answerCheck('${quizbogi[1]}')" id="b2" class="btn btn-light mb-3">${quizbogi[1]}</button><br/>
			<button onclick="answerCheck('${quizbogi[2]}')" id="b3" class="btn btn-light mb-3">${quizbogi[2]}</button><br/>
			<button onclick="answerCheck('${quizbogi[3]}')" id="b4" class="btn btn-light">${quizbogi[3]}</button><br/>
		</div><br/><br/>
		<div class="text-right mr-5">
			<button id="resetButton" class="btn btn-danger">퀴즈종료</button>
		</div>
		<div id="wrong" style="display: none;" class="text-center">오답~</div>
		
	</div>
</body>
</html>
