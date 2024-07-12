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
<title>Second DIVE - memberInfoUpdate</title>
</head>
<body>
<jsp:include page="/WEB-INF/views/include/header.jsp" /> 
<jsp:include page="/WEB-INF/views/include/leftSide.jsp" /> 
<div class="rightSide">
    <div class="infoShow">
 		<h1 style="margin-bottom: 100px;">마이페이지</h1><br/>
 		<form name="memberInfoUpdateForm" method="post">
	  	<p>닉네임 [닉네임 변경은 관리자에게 문의하세요] 
	  		<input type="text" name="nickName" id="nickName" value="${vo.nickName}" readonly class="form-control" />
	  	</p>
	  	<p>생년월일  
	  		<input type="date" name="birthday" id="birthday" value="${vo.birthday}" class="form-control" />
	  	</p><br/> 
	  	<p>연락처 [010-0000-0000 형식을 정확히 지켜주세요!!]
	  		<input type="text" name="tel" id="tel" value="${vo.tel}" class="form-control" />
	  	</p><br/> 
	  	<p>주소  
	  		<input type="text" name="address" id="address" value="${vo.address}" class="form-control" />
	  	</p><br/> 
	  	<p>이메일  
	  		${vo.email}
	  	</p><br/> 
	  	<p>가입일  
	  		${fn:substring(vo.joinDate,0,11)}
	  	</p><br/> 
	  	<p>방문횟수  
	  		${vo.visitCnt}
	  	</p><br/> 
	  	<p>작성 글 수  
	  		${vo.totWriteCnt}
	  	</p><br/> 
	  	<p>작성댓글 수 
	  	  ${vo.totReplyWriteCnt}
	  	</p><br/><br/><br/>
	  	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
 		</form>
	  <div class="btns">
	  	<button onclick="" class="btn btn-danger mr-5">수정하기</button>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	  	<button onclick="location.href='${ctp}/';" class="btn btn-info mr-5">마이페이지</button>
	  	<button onclick="location.href='${ctp}/';" class="btn btn-light">로비</button>
	  </div>
	</div> 
</div>
<jsp:include page="/WEB-INF/views/include/footer.jsp" />  
</body>
</html>