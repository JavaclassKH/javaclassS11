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
		width: 100%;
		height: 470px;
		object-position: top;
		object-fit: cover; /* 이미지가 비율을 유지하면서 470px 높이를 채우도록 함 */
		overflow: hidden; /* 초과 부분 잘리도록 설정 */
		opacity: 0.7; 
		margin-bottom: 220px;
		position: absolute;
	}
	
	#introduce {
		font-size: 33px;
		color: purple; 
		float: left;
		margin-top: 10px;
		margin-left: 10px;
		opacity: 1; 
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
	
	// 관리자모드 진입 확인
	function adminLobby() {
		let answer = confirm("관리자모드에 진입하시겠습니까?");
		let sLevel = '${sLevel}';
		if(!answer) {
			alert("관리자모드 진입을 취소합니다");
			location.reload();
			return false;
		}
		else if(sLevel < 110) {
			alert("관리자만 사용 가능한 기능입니다");
		}
		else if(sLevel == null) {		
			alert("비정상적인 접근, 혹은 세션 만료로\n관리자모드 사용이 불가능합니다\n재로그인 후 사용해주세요");				
		}
		location.href="${ctp}/admin/adminLobby";
	}
	
</script>
</head>
  <div class="header">
    <header>    
      <img src="${ctp}/resources/images/HeaderImg.png" id="headerImg" />     
     	<span id="introduce"><b>아이브 비공식 팬사이트 - Second DIVE</b></span>
      <nav class="nav">
				<c:if test="${empty sMid || !empty sMid}">
					<span style="display: none;">
		      	<li><a class="btn btn-light btn-sm" href="javascript:cursorModeChange(1)">달이</a></li> &nbsp;
		      	<li><a class="btn btn-light btn-sm" href="javascript:cursorModeChange(2)">강안지</a></li> &nbsp;
		      	<li><a class="btn btn-light btn-sm" href="javascript:cursorModeChange(3)">나오리</a></li> &nbsp;
		      	<li><a class="btn btn-light btn-sm" href="javascript:cursorModeChange(4)">체리</a></li> &nbsp;
		      	<li><a class="btn btn-light btn-sm" href="javascript:cursorModeChange(5)">치즈</a></li> &nbsp;
		      	<li><a class="btn btn-light btn-sm" href="javascript:cursorModeChange(6)">이랑이</a></li> &nbsp;
		      	<li><a class="btn btn-light btn-sm" href="javascript:cursorModeChange(0)">일반</a></li> &nbsp;
	      	</span>
				</c:if>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
      	<c:if test="${sLevel == 112 || sLevel == 113 || sLevel == 114}">
      		<li><button onclick="adminLobby()" class="btn btn-link"><font color="black">관리자모드</font></button></li> &nbsp;&nbsp;
      	</c:if>
      	<c:if test="${empty sMid}">
	      	<li><a href="${ctp}/" class="btn btn-link"><font color="black">로비</font></a></li> &nbsp;&nbsp;
	        <li><a href="${ctp}/member/memberLogin" class="btn btn-link"><font color="black">로그인</font></a></li> &nbsp;&nbsp;
	        <li><a href="${ctp}/member/memberJoinAgreement" class="btn btn-link"><font color="black">회원가입</font></a></li> &nbsp;&nbsp;
      	</c:if>
      	<c:if test="${!empty sMid}">
	      	<li><a href="${ctp}/" class="btn btn-link"><font color="black">로비</font></a></li> &nbsp;&nbsp;
        	<li><a href="${ctp}/member/memberLogout?mid=${sMid}" class="btn btn-link"><font color="black">로그아웃</font></a></li> &nbsp;&nbsp;
      	</c:if>
      </nav>
    </header>
    <br/>
  </div>