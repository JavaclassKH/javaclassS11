<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="${ctp}/resources/css/bodyLeftRight.css">
<title>adminLeftSide.jsp</title>
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
		height: 950px;
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
	        <img src="${ctp}/resources/images/HeaderImg.jpg" width="180px" height="150px" />
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
	      <div class="memberImage">
		    	<img src="${ctp}/images/noLogin.jpg" width="180px" height="150px" />
		    </div>
		    <p>관리자모드가 실행중입니다</p>
		    <p>
		    	<a href="${ctp}/">관리자모드 종료</a>
		    </p>
		    </div>
	    <div class="Menu">
	    	<ui>
		      <li class="liTitle">
		        ★ 회원관리 ★
		      </li><br/>
		      <li>
		      	<a href="${ctp}/admin/adminLobby">⊙ 관리자로비(관리자현황)</a>
		      </li><br/>
		      <li>
		      	<a href="${ctp}/admin/adminMemberList">⊙ 전체회원조회 </a>
		      </li><br/><hr/>
		      <li class="liTitle">
		        ★ 문의사항관리 ★
		      </li><br/>
		      <li>
		        <a href="${ctp}/admin/adminLobby">⊙ 문의관리</a> 
		      </li><br/>
		      <li>
		      	<a href="${ctp}/admin/adminLobby">⊙ 등업관리</a> 
		      </li><br/><hr/>
		      <li class="liTitle">
		      	★ 엔터테인먼트 관리 ★
		      </li><br/>
		      <li>
		        <a href="${ctp}/play/randomSongRecommand">⊙ 랜덤노래추천 관리</a>
		      </li><br/>
		      <li>
		        <a href="${ctp}/play/randomSongRecommand">⊙ 아이브 퀴즈 관리</a>
		      </li><br/><hr/>
		      <li class="liTitle">
		        ★ 기타 ★
		      </li><br/>
		      <li>
		        <a href="${ctp}/play/randomSongRecommand">⊙ 기타1</a>
		      </li><br/>
		      <li>
		        <a href="${ctp}/play/randomSongRecommand">⊙ 기타2</a>
		      </li><br/>
		      <li>
		        <a href="${ctp}/play/randomSongRecommand">⊙ 기타3</a> 
		      </li><br/>
		      <li>
		        <a href="${ctp}/play/randomSongRecommand">⊙ 기타4</a>
		      </li>
	   	 </ui>
	    </div>
	  </div>
</body>
</html>

