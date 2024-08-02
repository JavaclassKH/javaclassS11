<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="${ctp}/resources/css/bodyLeftRight.css">
<title>leftSide.jsp</title>
<jsp:include page="/WEB-INF/views/include/bs4.jsp" />
<style>
	ui {
		text-align: left;
		margin-left: 3px;
	}
	
	li {
		margin-bottom: 9px;
		margin-left: 8px;
		padding-left: 8px;
	}

	.Menu {
		text-align: left;
		list-style-type: none;
		vertical-align: middle;
		height: 1028px;
	}
	
	.memberImage {
		margin-top: 13px;
		margin-bottom: 3px;
	}

</style>
</head>
<body>
	  <div class="leftSide">
	    <div class="cafeInfoCard">
	      <div class="cafeImage">
	        <img src="${ctp}/resources/images/HeaderImg.png" width="180px" height="150px" />
	      </div><br/>
	      <div class="siteName">
	        아이브(IVE) 팬사이트 <br/>
	        Second DIVE
	      </div>
	      <div class="siteInfoCard">
		      카페지기 : ${sMaster} <br/> 
		      회원수 : ${sCafeMemberCount} <br/> 
		      방문수 : ${sCafeVisitCount} <br/> 
	      </div>
	    </div>
	    <div class="memberInfoCard">
		    	<c:if test="${!empty sMid}">
				    <div class="memberImage mb-3">
				    	<img src="${ctp}/resources/data/member/${memberImage}" width="180px" height="150px" />
				    </div>
				    ★ 내 정보 ★ 
			    	<p>
				      닉네임 : ${sNickName} <br/>
				      회원등급 : ${strLevel} <br/>
				      <a href="${ctp}/member/myPage" class="btn btn-link mt-2">마이페이지</a>
				    </p>
		    	</c:if>
		    	<c:if test="${empty sMid}">
			      <div class="memberImage">
				    	<img src="${ctp}/images/noLogin.jpg" width="180px" height="150px" />
				    </div>
				    <p>로그인 후 이용해주세요</p>
		    	</c:if>
		    </div>
	    <div class="Menu">
	    	<ui>
		      <li class="liTitle">
		        ★ Notice ★
		      </li><br/>
		      <li>
		      	<a href="${ctp}/notice/noticeBoard">⊙ 전체공지</a>
		      </li>
		      <li>
		        <a href="${ctp}/notice/officialArticle">⊙ 공식기사</a>
		      </li>
		      <li>
		        ⊙ 공식스케줄
		      </li>
		      <li>
		        ⊙ 이벤트
		      </li><hr/>
		      <li class="liTitle">
		        ★ Board ★
		      </li><br/>
		      <li>
		        <a href="${ctp}/board/freeBoard">⊙ 자유게시판</a>
		      </li>
		      <li>
		        <a href="${ctp}/board/fromIVE">⊙ from. IVE</a>
		      </li>
		      <li>
		        <a href="${ctp}/board/toIVE">⊙ to. IVE</a>
		      </li><hr/>
		      <li class="liTitle">
		        ★ Suggestions ★
		      </li><br/>
		      <li>
		        <a href="${ctp}/suggestions/songSuggestions">⊙ 노래제안</a>
		      </li>
		      <li>
		        <a href="${ctp}/suggestions/choreographySuggestions">⊙ 안무제안</a>
		      </li>
		      <li>
		        <a href="${ctp}/suggestions/selfContentSuggestions">⊙ 자체컨텐츠 제안</a>
		      </li><hr/>
		      <li class="liTitle">
		      	★ Play ★
		      </li><br/>
		      <li>
		        <a href="${ctp}/play/luckyvicky">⊙ 원영적 사고</a>
		      </li>
		      <li>
		        <a href="${ctp}/play/randomSongRecommand">⊙ 랜덤노래추천</a>
		      </li>
		      <li>
		        <a href="${ctp}/play/IVEQuiz/main">⊙ 퀴즈파크</a>
		      </li><hr/>
		      <li class="liTitle">
		        ★ etc ★
		      </li><br/>
		      <li>
		        ⊙ 등업신청
		      </li>
		      <li>
		        ⊙ 등업반려
		      </li>
		      <li>
		        ⊙ 문의사항
		      </li>
		      <li>
		        <a href="javascript:alert('새로운 기능이 준비중입니다');">⊙ 준비중 1</a>
		      </li>
		      <li>
		        <a href="javascript:alert('새로운 기능이 준비중입니다');">⊙ 준비중 2</a>
		      </li>
		      <li>
		        <a href="javascript:alert('새로운 기능이 준비중입니다');">⊙ 준비중 3</a>
		      </li>
	   	 </ui>
	    </div>
	  </div>
</body>
</html>

