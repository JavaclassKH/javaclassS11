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
<title>Second DIVE - adminLobby</title>
<style>	
	.adminList {
		overflow: scroll;	
	}
	
	.table {
		margin-top: 50px;
	}
</style>
<script>
	'use strict';
	
	// 권한 수정관리 (전체관리자 전용)
	function authorityUpdate(idx) {
		if(idx === 1) {
			alert("대표운영자의 권한수정은 불가능합니다");
			return false;
		}
		let answer = confirm("권한수정 시스템으로 이동하시겠습니까?");
		if(!answer) return false;
		location.href="${ctp}/admin/adminAuthorityUpdate?idx="+idx;
	}
	
	// 권한 수정,삭제,부여관리 (대표관리자 전용)
	function authorityManage(idx) {
		let answer = confirm("권한관리 시스템으로 이동하시겠습니까?");
		if(!answer) return false;
		location.href="${ctp}/admin/adminAuthorityManage?idx="+idx;
	}

</script>
</head>
<body>
<jsp:include page="/WEB-INF/views/include/header.jsp" /> 
<jsp:include page="/WEB-INF/views/include/adminLeftSide.jsp" /> 
<div class="rightSide"> 
  <h1><font size="16"><strong>관리자로비</strong>(관리자명단)</font></h1>
  <div class="adminList">
	  <table class="table table-bordered">
	  	<tr class="text-center">
	  		<th style="width: 26%">닉네임</th>
	  		<th style="width: 26%">권한</th>
	  		<th style="width: 26%">담당파트</th>
	  		<th style="width: 14%">비고</th>
	  	</tr>
	  	<c:forEach var="vo" items="${vos}" varStatus="st">
	  		<tr class="text-center">
	  			<td style="width: 26%">${vo.nickName}</td>
	  			<td style="width: 26%">
		  			<c:if test="${vo.memLevel == 111}">운영자</c:if>
		  			<c:if test="${vo.memLevel == 112}">관리자</c:if>
		  			<c:if test="${vo.memLevel == 113}">전체관리자</c:if>
		  			<c:if test="${vo.memLevel == 114}">대표운영자</c:if>  			
	  			</td>
	  			<td style="width: 26%">
	  				<c:if test="${vo.part == 'All'}">대표운영</c:if>
	  				<c:if test="${vo.part == 'limitAll'}">전체관리</c:if>
	  				<c:if test="${vo.part == 'notice'}">전체공지</c:if>
	  				<c:if test="${vo.part == 'freeBoard'}">자유게시판</c:if>
	  				<c:if test="${vo.part == 'fromIVE'}">fromIVE</c:if>
	  				<c:if test="${vo.part == 'toIVE'}">toIVE</c:if>
	  				<c:if test="${vo.part == 'randomSongRecommand'}">랜덤노래추천</c:if>
	  			</td>
	  			<td style="width: 14%" class="text-center">
	  				<c:if test="${sLevel == 113}">
		  				<button onclick="authorityManage(${vo.idx})" class="btn btn-danger">권한관리</button>
	  				</c:if>
	  				<c:if test="${sLevel == 114}">
		  				<button onclick="authorityManage(${vo.idx})" class="btn btn-danger">권한관리</button>
	  				</c:if>
	  			</td>
	  		</tr>
	  	</c:forEach>
	  	<tr><td colspan="4" class="p-0 m-0"></td></tr>
	  </table>
  </div>
</div>
<jsp:include page="/WEB-INF/views/include/footer.jsp" /> 
</body>
</html>



















