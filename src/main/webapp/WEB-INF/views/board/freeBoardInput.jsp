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
  <script src="${ctp}/ckeditor/ckeditor.js"></script>
<title>Second DIVE - freeBoardInput</title>
<script>
	'use strict';
	
	function freeBoardInput() {
		let freeBoardTitle = freeBoardInputForm.freeBoardTitle.value;
		let freeBoardContent = CKEDITOR.instances.CKEDITOR.getData();

		if (freeBoardTitle.trim() == "") {
			alert("제목을 작성하세요");
			$("#freeBoardTitle").focus();
			return false;
		} else if (freeBoardContent.trim() == "") {
			alert("내용을 작성하세요");
			$("#freeBoardContent").focus();
			return false;
		} else
			freeBoardInputForm.submit();

	}
</script>
</head>
<body>
<jsp:include page="/WEB-INF/views/include/header.jsp" /> 
<jsp:include page="/WEB-INF/views/include/leftSide.jsp" /> 
<div class="rightSide">
	<h2>전체공지 작성</h2><br/>
	<form name="freeBoardInputForm" method="post">
		<table class="table">
			<tr>
				<th>제목</th>
				<td><input type="text" name="freeBoardTitle" id="freeBoardTitle" class="form-control" /></td>
			</tr>
			<tr>
				<th>내용</th>
	      <td><textarea name="freeBoardContent" id="CKEDITOR" rows="6" class="form-control" required></textarea></td>
	      <script>
				  CKEDITOR.replace("freeBoardContent",{
					  height:480,
					  filebrowserUploadUrl:"${ctp}/imageUpload",	/* 파일(이미지)를 업로드시키기위한 매핑경로(메소드) */
					  uploadUrl:"${ctp}/imageUpload"             /* uploadUrl : 여러개의 그림파일을 드래그&드롭으로 올릴 수 있다 */ 
					});
	      </script>
			</tr>
		</table><br/>
		<input type="hidden" name="mid" value="${sMid}" />
		<input type="hidden" name="nickName" value="${sNickName}" />
		<input type="hidden" name="writerIp" value="${pageContext.request.remoteAddr}" />		
	</form><br/>
	<button onclick="freeBoardInput()" class="btn btn-info" style="float: right; margin-right: 10px;">등록</button>
</div>
<jsp:include page="/WEB-INF/views/include/footer.jsp" />  
</body>
</html>



<!--  

    <td>
    	<textarea name="content" id="CKEDITOR" rows="6" class="form-control" required></textarea>
    </td>
	        <script>
	          CKEDITOR.replace("content",{
	        	  height:480,
	        	  filebrowserUploadUrl:"${ctp}/imageUpload",	/* 파일(이미지)를 업로드시키기위한 매핑경로(메소드) */
	        	  uploadUrl:"${ctp}/imageUpload"             /* uploadUrl : 여러개의 그림파일을 드래그&드롭으로 올릴 수 있다 */
	        	  
	          });
	        </script>








-->