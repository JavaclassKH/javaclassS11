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
<title>Second DIVE - officialArticle</title>
<script>
	'use strict';
	
	$(document).ready(function(){
		if(${vos} != null) {
			for(let i=0; i<=${vos}.length; i++) {
				$("#title").html('${vo.item2Image}');
				$("#image").html('${vo.item1Title}');
				$("#content").html('${vo.item3Content}');
			}
		}
	});
	
</script>
</head>
<body>
<jsp:include page="/WEB-INF/views/include/header.jsp" /> 
<jsp:include page="/WEB-INF/views/include/leftSide.jsp" /> 
<div class="rightSide">
  <h1 class="text-center"><b>공식기사</b></h1><br/>
  <div class="officialArticleDiv">
  	<table class="table table-border">
  		<thead>
	  		<tr class="table-hover">
					<th class="text-center">기사 사진</th>
					<th class="text-center">제목</th>
					<th class="text-left">기사내용</th>
	  		</tr>
  		</thead>
  		<tbody>
  			<tr>
  				<td id="image"></td>
  				<td id="title"></td>
  				<td id="content"></td>
  			</tr>
  		</tbody>
  	</table>
  </div>
</div>
<jsp:include page="/WEB-INF/views/include/footer.jsp" />  
</body>
</html>