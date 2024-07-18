<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <jsp:include page="/WEB-INF/views/include/bs4.jsp" />
  <link rel="stylesheet" href="${ctp}/resources/css/bodyLeftRight.css">
<title>Second DIVE - adminMemberInfoWatch</title>
<script>
	'use strict';
	
	// 회원 아이디/닉네임 강제변경
	function adminMemberMidNickNameChange(idx) {
		let mid = $("#mid").val();
		let nickName = $("#nickName").val();
		
		if(mid.trim() == "" || nickName.trim() == "") {
			alert("변경할 아이디와 닉네임을 입력해주세요");
			return false;
		} 		
		location.href="${ctp}/admin/adminMemberMidNickNameChange?mid="+mid+"&nickName="+nickName+"&idx="+idx;
	}
	
</script>
</head>
<body>
<jsp:include page="/WEB-INF/views/include/header.jsp" /> 
<jsp:include page="/WEB-INF/views/include/adminLeftSide.jsp" />
<div class="rightSide">
  <div class="infoShow">
		<h1 style="margin-bottom: 100px;"><b>회원 상세정보 조회</b></h1><br/>
		<c:if test="${flag != 0}">
			<div class="mb-4">
				아이디 <input type="text" placeholder="${vo.mid}" class="form-control" readonly /><br/>
				닉네임 <input type="text" placeholder="${vo.nickName}" class="form-control" readonly />
			</div>
		</c:if>
		<c:if test="${flag == 0}">
			<div class="mb-4">
				아이디 <input type="text" name="mid" id="mid" value="${vo.mid}" class="form-control" autofocus /><br/>
				닉네임 <input type="text" name="nickName" id="nickName" value="${vo.nickName}" class="form-control mb-3" /><br/>
				<button onclick="adminMemberMidNickNameChange(${vo.idx})" class="btn btn-danger form-control">회원아이디/닉네임 변경</button>
			</div>
		</c:if>
		<p>회원등급 :&nbsp; 
			<c:if test="${vo.memLevel == 5}">★아이브★</c:if> 
			<c:if test="${vo.memLevel == 4}">우수회원</c:if> 
			<c:if test="${vo.memLevel == 3}">정회원</c:if> 
			<c:if test="${vo.memLevel == 2}">준회원</c:if> 
		</p><br/> 
		<p>이름 :&nbsp; ${vo.name}</p><br/> 
		<p>생년월일 :&nbsp; ${vo.birthday}</p><br/> 
		<p>연락처 :&nbsp; ${vo.tel}</p><br/> 
		<p>주소 :&nbsp; ${vo.address}</p><br/> 
		<p>이메일 :&nbsp; ${vo.email}</p><br/> 
		<p>가입일 :&nbsp; ${fn:substring(vo.joinDate,0,11)}</p><br/> 
		<p>방문횟수 :&nbsp; ${vo.visitCnt}</p><br/> 
		<p>작성 글 수 :&nbsp; ${vo.totWriteCnt}</p><br/> 
		<p>작성댓글 수 :&nbsp; ${vo.totReplyWriteCnt}</p><br/> 
		<p>재제여부 :&nbsp;
			<c:if test="${vo.memLevel != 99 && vo.blockCnt <= 2}">정상활동중</c:if>
			<c:if test="${vo.memLevel == 99}">제재중 (${vo.blockDate_diff}일)</c:if>
			<c:if test="${vo.memLevel == 99 && vo.blockCnt >= 3}">회원자격심사중</c:if>
		</p><br/> 
		<p>제재횟수 :&nbsp; ${vo.blockCnt}</p><br/><br/><br/><br/>
		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	 	<div class="btns">
	 		<button onclick="location.href='#';" class="btn btn-danger mr-4">강제탈퇴(미완성)</button>
		 	<c:if test="${vo.memLevel == 99 && vo.blockCnt >= 3}">
		 		<button onclick="location.href='#';" class="btn btn-primary mr-4">회원자격복구(미완성)</button>
		 	</c:if>
		 	<a href="${ctp}/admin/adminMemberList?level=100" class="btn btn-info">회원리스트</a>
	  </div>
</div> 
</div>
<jsp:include page="/WEB-INF/views/include/footer.jsp" />  
</body>
</html>




















