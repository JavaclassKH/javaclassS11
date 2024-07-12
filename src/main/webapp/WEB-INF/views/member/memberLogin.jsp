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
<title>Second DIVE - MemberLogin</title>
<style>
	body {
	  margin: 0;
	  padding: 0;
	  font-size: 14px;
	  opacity: 0.8; 
	  cursor : url('${ctp}/images/c${c}.gif') 15 13, auto;  
	}

	#loginTitle {
		font-size: 3em; 
	}

	#loginTable {
		display: inline-block;
		margin-left: 500px;
		text-align: center;
	}
	
	.btns {
		text-align: center;
	}

	
</style>
<script>
	'use strict';
	
	// 로그인하기
	function loginCheck() {
		
	}
	
	
</script>

</head>
<body>
<jsp:include page="/WEB-INF/views/include/header.jsp" /> 
<jsp:include page="/WEB-INF/views/include/leftSide.jsp" /> 
<div class="rightSide">	
	<div id="loginTable">
	<span id="loginTitle" class="text-center">Second DIVE</span><br/><br/><br/><br/><br/>
		<form name="memberLoginForm" method="post">
			<table class="table table-borderless">
				<tr>
					<td>
						<div class="input-group">
							<div class="input-group-prepend">
								<span class="btn btn-warning">아이디</span>
							</div>
							<input type="text" name="mid" id="mid" title="아이디를 입력하세요" class="form-control" autofocus required />
						</div>
					</td>
				</tr>
				<tr>
					<td>
						<div class="input-group">
							<div class="input-group-prepend">
								<span class="btn btn-danger">비밀번호</span>
							</div>
							<input type="password" name="pwd" id="pwd" title="비밀번호를 입력하세요" class="form-control" required />
						</div>
					</td>
				</tr>
				<tr><td></td></tr>
				<tr><td></td></tr>
				<tr class="btns">
					<td>
						<button onclick="loginCheck()" class="btn btn-link">로그인</button>
						<button onclick="location.href='${ctp}/member/memberJoin';" class="btn btn-link">회원가입</button>
					</td>
				</tr>
				<tr class="btns">
					<td>
						<button onclick="idFind()" class="btn btn-link">아이디 찾기</button>
						<button onclick="pwdReset()" class="btn btn-link">비밀번호 찾기</button>
					</td>
				</tr>
			</table>
		</form><br/>
	</div>
</div>
<jsp:include page="/WEB-INF/views/include/footer.jsp" />  
</body>
</html>

