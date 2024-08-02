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
<title>Second DIVE - luckyvicky</title>
</head>
<body>
<jsp:include page="/WEB-INF/views/include/header.jsp" /> 
<jsp:include page="/WEB-INF/views/include/leftSide.jsp" /> 
<div class="rightSide">
  <h1 class="text-center text-primary">원영적 사고</h1><br/>
  <br/><br/><br/><br/><p class="text-center"><b>구글 로그인 후 이용 가능합니다! <br/>(원영적 사고는 1일에 10회 가능)</b></p><br/><br/><br/>
  <iframe src="https://lucky-vicky.vercel.app/" scrolling="no" style="overflow: hidden; border: none;"  width="100%" height="1050px"></iframe>
</div>
<jsp:include page="/WEB-INF/views/include/footer.jsp" />  
</body>
</html>