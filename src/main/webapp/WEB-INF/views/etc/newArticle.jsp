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
<title>Second DIVE - newArticle</title>
<script>
	'use strict';

</script>
</head>
<body>
<jsp:include page="/WEB-INF/views/include/header.jsp" /> 
<jsp:include page="/WEB-INF/views/include/leftSide.jsp" /> 
<div class="rightSide">
  <h1 class="text-center"><b>최신 연예뉴스</b></h1><br/>
  <div class="officialArticleDiv">
  	<table class="table table-border table-hover">
  		<thead>
	  		<tr>
					<th class="text-center">기사 사진</th>
					<th class="text-left">제목 (클릭시 새창)</th>
					<th class="text-left">기사내용</th>
	  		</tr>
  		</thead>
  		<c:if test="${!empty vos}">
  		<tbody>
			<c:forEach var="vo" items="${vos}">
  			<tr>
  				<td id="image">${vo.item2Image}</td>
  				<td>${vo.item1Title}</td>
  				<td id="content">${vo.item3Content}</td>
  			</tr>
				</c:forEach>
  		</tbody>
		</c:if>
  	</table>
  </div>
</div>
<jsp:include page="/WEB-INF/views/include/footer.jsp" />  
</body>
</html>