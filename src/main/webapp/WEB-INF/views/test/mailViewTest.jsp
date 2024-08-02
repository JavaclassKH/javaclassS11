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
<title></title>
</head>
<body>
<jsp:include page="/WEB-INF/views/include/header.jsp" /> 
<jsp:include page="/WEB-INF/views/include/leftSide.jsp" /> 
<div class="rightSide">
	<h2><b>Second DIVE 비밀번호 재설정</b></h2>
  <br><hr><h3> 인증문자를 입력해주세요 : Hj69k4fM </h3><hr><br>
  <p>
  	이 메일은 Second DIVE 비밀번호 재설정을 위해 발송되었습니다 <br>
  	혹시 본인이 재설정하신것이 아니라면 인증번호를 유출하지 마시고 <br>
  	Second DIVE의 운영자에게 바로 제보 부탁드립니다
  </p>
</div>
<jsp:include page="/WEB-INF/views/include/footer.jsp" />  
</body>
</html>

