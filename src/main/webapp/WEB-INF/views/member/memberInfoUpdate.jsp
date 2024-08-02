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
<script>
	'use strict';
	function memberInfoUpdate() {
		
		let tel = memberInfoUpdateForm.tel.value.trim();
		let address = memberInfoUpdateForm.address.value;   
		
		let fName = document.getElementById("file").value;
		if(fName.trim() != "") {
			let ext = fName.substring(fName.lastIndexOf(".") + 1).toLowerCase();
			let maxSize = 1024 * 1024 * 5;
			let fileSize = document.getElementById("file").files[0].size;
			
			if(ext != 'jpg' && ext != 'gif' && ext != 'png') {
				alert("그림파일만 업로드 가능합니다.");
				return false;
			}
			else if(fileSize > maxSize) {
				alert("업로드할 파일의 최대용량은 5MByte입니다.");
				return false;
			}
		}		
		else {
			memberInfoUpdateForm.fName.value = '${vo.memberImage}';
		}
		memberInfoUpdateForm.submit();
	}
	
	// 수정 중단하고 마이페이지로 넘어가기
	function myPageCheck() {
		alert("마이페이지로 돌아갑니다");
		location.href='${ctp}/member/myPage';
	}
	
</script>
</head>
<body>
<jsp:include page="/WEB-INF/views/include/header.jsp" /> 
<jsp:include page="/WEB-INF/views/include/leftSide.jsp" /> 
<div class="rightSide">
    <div class="infoShow">
 		<h1 style="margin-bottom: 100px;">마이페이지</h1><br/>
 		<form name="memberInfoUpdateForm" method="post" enctype="multipart/form-data">
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
	  	</p><br/>
	  	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	  	<div style="padding: 5px; border: 1px dotted gray;">
	  		<input type="file" name="fName" id="file"  class="form-control-file borderless" />
	  	</div><br/>
	  	<div>
	  		<img src="${ctp}/resources/data/member/${vo.memberImage}" width="400px" height="315px" style="border: 1px dotted gray; border-radius: 10%;" />
	  	</div>
	    <input type="hidden" name="fName" />
 		</form><br/><br/>
	  <div class="btns">
	  	<button onclick="memberInfoUpdate()" class="btn btn-danger mr-5">수정하기</button>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	  	<button onclick="myPageCheck()" class="btn btn-info mr-5">마이페이지</button>
	  	<button onclick="location.href='${ctp}/';" class="btn btn-light">로비</button>
	  </div>
	</div> 
</div>
<jsp:include page="/WEB-INF/views/include/footer.jsp" />  
</body>
</html>