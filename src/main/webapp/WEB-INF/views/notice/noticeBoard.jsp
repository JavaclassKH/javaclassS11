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
<title>Second DIVE - noticeBoard</title>
<style>
	.tab {
		margin-top: 40px;
		width: 1000px;
		text-align: center;
	}
	
	.table {
		margin-left: 90px;
	}
	
	.h {
		margin-left: 80px;
	}

	
	#write {
		float: right;
		margin-right: 120px;
		margin-bottom: 5px;
	}

</style>
<script>
	'use strict';
	
	function pageSizeCheck(pageSize) {
		location.href="${ctp}/notice/noticeBoard?pag="+${pageVo.pag}+"&pageSize="+pageSize;
	}

</script>
</head>
<body>
<jsp:include page="/WEB-INF/views/include/header.jsp" /> 
<jsp:include page="/WEB-INF/views/include/leftSide.jsp" /> 
<div class="rightSide">
	<h1 class="h"><b><font size="7">전 체 공 지</font></b></h1><br/>
	<h5 class="h">Second DIVE 전체공지 게시판입니다</h5><br/>
	<div id="write">
	  <c:if test="${sLevel == 114 || sLevel == 113 || sLevel == 111 && sPart == 'noticeBoard' || sLevel == 112 && sPart == 'noticeBoard'}">
		  <button onclick="location.href='${ctp}/notice/noticeInput';" id="writeBtn" class="btn btn-light">공지작성</button>
		</c:if> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
    <select name="pageSize" id="pageSize" onchange="pageSizeCheck(this.value)">
      <option ${pageVo.pageSize == 5  ? "selected" : ""} value="5">5개씩 보기</option>
      <option ${pageVo.pageSize == 10 ? "selected" : ""} value="10">10개씩 보기</option>
      <option ${pageVo.pageSize == 15 ? "selected" : ""} value="15">15개씩 보기</option>
      <option ${pageVo.pageSize == 20 ? "selected" : ""} value="20">20개씩 보기</option>
      <option ${pageVo.pageSize == 30 ? "selected" : ""} value="30">30개씩 보기</option>
    </select>
	</div>
  <div class="tab">
	  <table class="table">
		  <thead>
		    <tr>
		      <th scope="col">&nbsp;</th>
		      <th scope="col">제목</th>
		      <th scope="col">글쓴이</th>
		      <th scope="col">작성일</th>
		      <th scope="col">조회수</th>
		    </tr>
		  </thead>
		  <tbody>
		  	<c:set var="curScrStartNo" value="${pageVo.curScrStartNo}"/>
		  	<c:forEach var="vo" items="${vos}" varStatus="st">
		  		<tr>
		  			<td scope="row">
		  				${curScrStartNo}
		  			</td>
		  			<td scope="row">
		  				<a href="${ctp}/notice/noticeContent?idx=${vo.idx}">
			  				${vo.noticeTitle}
		  				</a>
		  			</td>
		  			<td scope="row">
		  				${vo.nickName}
		  			</td>
		  			<td scope="row">
		  				${fn:substring(vo.noticeWDate,0,11)}
		  			</td>
		  			<td scope="row">
		  				${vo.noticeReadNum}
		  			</td>
		  		</tr>
		  		<c:set var="curScrStartNo" value="${curScrStartNo - 1}"/>
		  	</c:forEach>
		  </tbody>
		  <tr><td colspan="5" class="p-0 m-0"></td></tr>
		</table>
  </div>
  <!-- 블록페이지 시작 -->
		<br/><br/><div class="text-center">
		  <ul class="pagination justify-content-center">
			  <c:if test="${pageVo.pag > 1}"><li class="page-item"><a class="page-link text-secondary" href="${ctp}/notice/noticeBoard?pag=1&pageSize=${pageVo.pageSize}">첫페이지</a></li></c:if>
			  <c:if test="${pageVo.curBlock > 0}"><li class="page-item"><a class="page-link text-secondary" href="${ctp}/notice/noticeBoard?pag=${(pageVo.curBlock-1)*pageVo.blockSize + 1}&pageSize=${pageVo.pageSize}">이전블록</a></li></c:if>
			  <c:forEach var="i" begin="${(pageVo.curBlock*pageVo.blockSize)+1}" end="${(pageVo.curBlock*pageVo.blockSize) + pageVo.blockSize}" varStatus="st">
			    <c:if test="${i <= pageVo.totPage && i == pag}"><li class="page-item active"><a class="page-link bg-secondary border-secondary" href="${ctp}/notice/noticeBoard?pag=${i}&pageSize=${pageVo.pageSize}">${i}</a></li></c:if>
			    <c:if test="${i <= pageVo.totPage && i != pag}"><li class="page-item"><a class="page-link text-secondary" href="${ctp}/notice/noticeBoard?pag=${i}&pageSize=${pageVo.pageSize}">${i}</a></li></c:if>
			  </c:forEach>
			  <c:if test="${pageVo.curBlock < pageVo.lastBlock}"><li class="page-item"><a class="page-link text-secondary" href="${ctp}/notice/noticeBoard?pag=${(pageVo.curBlock+1)*pageVo.blockSize+1}&pageSize=${pageVo.pageSize}">다음블록</a></li></c:if>
			  <c:if test="${pageVo.pag < pageVo.totPage}"><li class="page-item"><a class="page-link text-secondary" href="${ctp}/notice/noticeBoard?pag=${pageVo.totPage}&pageSize=${pageVo.pageSize}">마지막페이지</a></li></c:if>
		  </ul>
		</div>
	<!-- 블록페이지 끝 -->
</div>
<jsp:include page="/WEB-INF/views/include/footer.jsp" />  
</body>
</html>