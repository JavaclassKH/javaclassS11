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
<title>Second DIVE - myPage</title>
<style>
	.infoShow {
		margin-left: 100px;
	}


</style>
</head>
<body>
<jsp:include page="/WEB-INF/views/include/header.jsp" /> 
<jsp:include page="/WEB-INF/views/include/leftSide.jsp" /> 
<div class="rightSide">
  <div class="infoShow">
 		<h1 style="margin-bottom: 100px;">마이페이지</h1><br/>
  	<p>닉네임 :&nbsp; ${vo.nickName}</p><br/>
  	<p>회원등급 :&nbsp; ${strLevel}</p><br/> 
  	<p>생년월일 :&nbsp; ${vo.birthday}</p><br/> 
  	<p>연락처 :&nbsp; ${vo.tel}</p><br/> 
  	<p>주소 :&nbsp; ${vo.address}</p><br/> 
  	<p>이메일 :&nbsp; ${vo.email}</p><br/> 
  	<p>가입일 :&nbsp; ${fn:substring(vo.joinDate,0,11)}</p><br/> 
  	<p>방문횟수 :&nbsp; ${vo.visitCnt}</p><br/> 
  	<p>작성 글 수 :&nbsp; ${totWriteCnt}</p><br/> 
  	<p>작성댓글 수 :&nbsp; ${vo.totReplyWriteCnt}</p><br/><br/>
  	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
  	<br/><p> 대표이미지 </p><br/>
  	<div>
  		<c:if test="${memberImage != 'eImg.jpg'}">
	  		<img src="${ctp}/resources/data/member/${memberImage}" width="400" height="315" style="border: 1px dotted gray; border-radius: 10%;" />
  		</c:if>
  	</div><br/><br/>
	  <div class="btns">
	  	<a href="${ctp}/member/memberInfoUpdate" class="btn btn-danger mr-4">정보수정</a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	  	<button onclick="" class="btn btn-warning mr-4">비밀번호변경</button>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	  	<button onclick="location.href='${ctp}/';" class="btn btn-info">로비</button>
	  </div>
	</div> 
</div>
<jsp:include page="/WEB-INF/views/include/footer.jsp" />  
</body>
</html>