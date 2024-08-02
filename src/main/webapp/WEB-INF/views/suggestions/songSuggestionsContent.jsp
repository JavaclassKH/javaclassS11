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
  <title>Second DIVE - songSuggestionsContent</title>
  <style>
    .btns .rightBtns {
      float: right;
    }
    .info-bar {
      display: flex;
      align-items: center;
      justify-content: space-between;
      margin-top: 2px;
    }
  </style>
  <script>
    'use strict';
  </script>
</head>
<body>
  <jsp:include page="/WEB-INF/views/include/header.jsp" /> 
  <jsp:include page="/WEB-INF/views/include/leftSide.jsp" /> 
  <div class="rightSide"><br/>
    <div class="btns">
      <a href="${ctp}/suggestions/songSuggestions?pag=${pageVo.pag}&pageSize=${pageVo.pageSize}" class="btn btn-light mr-2">목록</a>
      <button onclick="${ctp}/board/freeBoard" class="btn btn-light mr-2">이전글</button>
      <button onclick="${ctp}/board/freeBoard" class="btn btn-light">다음글</button>
      <c:if test="${sMid == vo.mid}">
        <div class="rightBtns">
          <button onclick="location.href='${ctp}/suggestions/songSuggestionsUpdate?idx=${vo.idx}'" class="btn btn-light mr-2">수정</button>
          <button onclick="location.href='${ctp}/suggestions/songSuggestionsDelete?idx=${vo.idx}'" class="btn btn-light">삭제</button>
        </div>
      </c:if>
    </div>
    <hr/>
    <h3><b>노래제안</b></h3>
    <div class="info-bar">
      <div>
        ${vo.nickName} &nbsp;&nbsp;&nbsp; 
        작성날짜 ${fn:substring(vo.writeDate,2,16)}
      </div>
      <span> 첨부파일 : 
        <a href="${ctp}/resources/data/songSuggestions/${vo.songFileName}" class="btn btn-outline-light" download="${vo.songFileOriginName}" >
        	<font color="gray">${fn:substring(vo.songFileOriginName, 0, fn:length(vo.songFileOriginName) - 4)}</font>
        </a>
      </span>
    </div>
    <br/><br/><br/><br/>
    <div>
      ${vo.songSuggestionsContent}
    </div>
    <br/>
    <hr/>
  </div>
  <jsp:include page="/WEB-INF/views/include/footer.jsp" />  
</body>
</html>















