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
<title>Second DIVE - blockManagement</title>
</head>
<body>
<jsp:include page="/WEB-INF/views/include/header.jsp" /> 
<jsp:include page="/WEB-INF/views/include/adminLeftSide.jsp" /> 
<div class="rightSide">
  <h1 class="text-center"><font size="21"><strong>제재내역 조회</strong></font></h1><br/><br/>
    <div class="adminMemberList">
	  <table class="table table-bordered">
	  	<tr class="text-center table-hover">
	  		<th style="width: 15%">아이디</th>
	  		<th style="width: 13%">닉네임</th>
	  		<th style="width: 39%">제재사유</th>
	  		<th style="width: 10%">시작일</th>
	  		<th style="width: 10%">종료일</th>
	  		<th style="width: 10%">제재부여자</th>
	  	</tr>
	  	<c:forEach var="vo" items="${vos}" varStatus="st">
	  		<tr class="text-center" style="vertical-align: middle;">
	  			<td>${vo.mid}</td>
	  			<td>${vo.nickName}</td>
	  			<td>${vo.blockReason}</td>
	  			<td>${vo.blockStartDate}</td>
	  			<td>${vo.blockEndDate}</td>
	  			<td>${vo.blockGiver}</td>
	  		</tr>
	  	</c:forEach>	  	
	  	<tr><td colspan="7" class="p-0 m-0"></td></tr>
	  </table>
  </div>  
</div>
<jsp:include page="/WEB-INF/views/include/footer.jsp" />  
</body>
</html>