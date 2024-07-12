<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>   
<head>
	<style>
		nav {
			margin-top: 4px;
			margin-right: 4px;
		}
		
		#headerImg {
			overflow: hidden;
		}
		
	</style>
	<script>
		'use strict';
		 
		function cursorModeChange(c) {
			$.ajax({
				url : "${ctp}/cursorMode",
				type : "get",
				data : {c:c}
			});
		}	
	</script>
</head>
  <div class="header">
    <header>    
      <img src="${ctp}/resources/images/HeaderImg.jpg" id="headerImg" width="100%" height="470px" style="position: absolute; opacity: 0.8; margin-bottom: 300px;">
      <nav class="nav">
				<c:if test="${empty sMid || !empty sMid}">
	      	<li><a class="btn btn-light btn-sm" href="javascript:cursorModeChange(1)">달이</a></li> &nbsp;
	      	<li><a class="btn btn-light btn-sm" href="javascript:cursorModeChange(2)">강안지</a></li> &nbsp;
	      	<li><a class="btn btn-light btn-sm" href="javascript:cursorModeChange(3)">나오리</a></li> &nbsp;
	      	<li><a class="btn btn-light btn-sm" href="javascript:cursorModeChange(4)">체리</a></li> &nbsp;
	      	<li><a class="btn btn-light btn-sm" href="javascript:cursorModeChange(5)">치즈</a></li> &nbsp;
	      	<li><a class="btn btn-light btn-sm" href="javascript:cursorModeChange(6)">이랑이</a></li> &nbsp;
	      	<li><a class="btn btn-light btn-sm" href="javascript:cursorModeChange(0)">일반</a></li> &nbsp;
				</c:if>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
      	<c:if test="${sLevel == 112 || sLevel == 113 || sLevel == 114}">
      		<li><a href="${ctp}/admin/adminLobby?adminOn=on">관리자모드</a></li> &nbsp;&nbsp;
      	</c:if>
      	<c:if test="${empty sMid}">
      		<li><a href="${ctp}/test/timerTest">타이머 테스트</a></li>
	      	<li><a href="${ctp}/">로비</a></li> &nbsp;&nbsp;
	        <li><a href="${ctp}/member/memberLogin">로그인</a></li> &nbsp;&nbsp;
	        <li><a href="${ctp}/member/memberJoinAgreement">회원가입</a></li> &nbsp;&nbsp;
      	</c:if>
      	<c:if test="${!empty sMid}">
	      	<li><a href="${ctp}/">로비</a></li> &nbsp;&nbsp;
        	<li><a href="${ctp}/member/memberLogout?mid=${sMid}">로그아웃</a></li> &nbsp;&nbsp;
      	</c:if>
      </nav>
    </header>
    <br/>
  </div>
  
  
 