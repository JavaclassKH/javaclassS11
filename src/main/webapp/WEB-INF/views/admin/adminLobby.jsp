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
</head>
<body>
<jsp:include page="/WEB-INF/views/include/header.jsp" /> 
<jsp:include page="/WEB-INF/views/include/adminLeftSide.jsp" /> 
<div class="rightSide"> 
  <h1><font size="16"><strong>관리자로비</strong>(관리자명단)</font></h1>
  <div class="adminList">
	  <table class="table table-bordered">
	  	<tr class="text-center">
	  		<th style="width: 28%">닉네임</th>
	  		<th style="width: 28%">권한</th>
	  		<th style="width: 28%">담당파트</th>
	  		<th style="width: 16%">비고</th>
	  	</tr>
	  	<c:forEach var="vo" items="${vos}" varStatus="st">
	  		<tr class="text-center">
	  			<td style="width: 28%">${vo.nickName}</td>
	  			<td style="width: 28%">
		  			<c:if test="${vo.memLevel == 111}">운영자</c:if>
		  			<c:if test="${vo.memLevel == 112}">관리자</c:if>
		  			<c:if test="${vo.memLevel == 113}">전체관리자</c:if>
		  			<c:if test="${vo.memLevel == 114}">대표운영자</c:if>  			
	  			</td>
	  			<td style="width: 28%">${vo.part}</td>
	  			<td style="width: 16%" class="text-center">
	  				<c:if test="${sLevel == 113}">
		  				<button onclick="" class="btn btn-danger">권한수정</button>
	  				</c:if>
	  				<c:if test="${sLevel == 114}">
		  				<button onclick="" class="btn btn-danger">권한수정/삭제</button>
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



















