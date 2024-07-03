<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>   
<head>
	<style>
		nav {
			margin-top: 4px;
			margin-right: 4px;
		}
		
		#headerImg {
			overflow: hidden;
		}
		
	</style>
</head>
  <div class="header">
    <header>    
      <img src="${ctp}/resources/images/HeaderImg.jpg" id="headerImg" width="100%" height="490px" style="position: absolute; opacity: 0.8;">
      <nav class="nav">
				<c:if test="${empty sMid || !empty sMid}">
	      	<li><a class="btn btn-light btn-sm" href="${ctp}/cursorMode?c=1">달이</a></li> &nbsp;
	      	<li><a class="btn btn-light btn-sm" href="${ctp}/cursorMode?c=2">강안지</a></li> &nbsp;
	      	<li><a class="btn btn-light btn-sm" href="${ctp}/cursorMode?c=3">나오리</a></li> &nbsp;
	      	<li><a class="btn btn-light btn-sm" href="${ctp}/cursorMode?c=4">체리</a></li> &nbsp;
	      	<li><a class="btn btn-light btn-sm" href="${ctp}/cursorMode?c=5">치즈</a></li> &nbsp;
	      	<li><a class="btn btn-light btn-sm" href="${ctp}/cursorMode?c=6">이랑이</a></li> &nbsp;
	      	<li><a class="btn btn-light btn-sm" href="${ctp}/">일반</a></li> &nbsp;
				</c:if>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
      	<c:if test="${sLevel == 112 || sLevel == 113 || sLevel == 114}">
      		<li><a href="${ctp}/admin/adminLobby">관리자메뉴</a></li> &nbsp;&nbsp;
      	</c:if>
      	<c:if test="${empty sMid}">
	      	<li><a href="${ctp}/">로비</a></li> &nbsp;&nbsp;
	        <li><a href="${ctp}/member/memberLogin">로그인</a></li> &nbsp;&nbsp;
	        <li><a href="${ctp}/member/memberJoin">회원가입</a></li> &nbsp;&nbsp;
      	</c:if>
      	<c:if test="${!empty sMid}">
	      	<li><a href="${ctp}/">로비</a></li> &nbsp;&nbsp;
        	<li><a href="${ctp}/member/memberLogout?mid=${sMid}">로그아웃</a></li> &nbsp;&nbsp;
      	</c:if>
      </nav>
    </header>
  </div>
  
  
 