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
<title>Second DIVE - choreographySuggestionsInput</title>
<script>
	'use strict';
	
	function choreographySuggestionsInput() {
		let choreographySuggestionsTitle = choreographySuggestionsInputForm.choreographySuggestionsTitle.value;
		let choreographySuggestionsContent = CKEDITOR.instances.CKEDITOR.getData();
		
		let fName = document.getElementById("file").value;
		if(fName.trim() != "") {
			let ext = fName.substring(fName.lastIndexOf(".") + 1).toLowerCase();
			let maxSize = 1024 * 1024 * 1024;
			let fileSize = document.getElementById("file").files[0].size;
			
			if(ext != 'mp4' && ext != 'mkv' && ext != 'avi' && ext != 'wmv' && ext != 'webm' && ext != 'flv' && ext != 'f4v' && ext != 'swf') {
				alert("영상파일만 업로드 가능합니다.");
				return false;
			}
			else if(fileSize > maxSize) {
				alert("업로드할 파일의 최대용량은 1Giga Byte입니다.");
				return false;
			}
		}

		if (choreographySuggestionsTitle.trim() == "") {
			alert("제목을 작성하세요");
			$("#choreographySuggestionsTitle").focus();
			return false;
		} else if (choreographySuggestionsContent.trim() == "") {
			alert("내용을 작성하세요");
			$("#choreographySuggestionsContent").focus();
			return false;
		} else
			choreographySuggestionsInputForm.submit();
	}
	
	
</script>
</head>
<body>
<jsp:include page="/WEB-INF/views/include/header.jsp" /> 
<jsp:include page="/WEB-INF/views/include/leftSide.jsp" /> 
<div class="rightSide">
	<h2>안무제안하기</h2><br/>
	<form name="choreographySuggestionsInputForm" method="post" enctype="multipart/form-data">
		<table class="table">
			<tr>
				<th width="10%">제목</th>
				<td><input type="text" name="choreographySuggestionsTitle" id="choreographySuggestionsTitle" class="form-control" /></td>
			</tr>
			<tr>
				<th width="10%">제안이유</th>
	      <td><textarea name="choreographySuggestionsContent" id="CKEDITOR" rows="6" class="form-control" required></textarea></td>
	      <script>
				  CKEDITOR.replace("choreographySuggestionsContent",{
					  height:480,
					  filebrowserUploadUrl:"${ctp}/imageUpload",	
					  uploadUrl:"${ctp}/imageUpload"              
					});
	      </script>
			</tr>
			<tr>
				<th width="10%">파일첨부</th>
				<td>
					<input type="file" name="fName" id="file" class="form-control-file" style="border: 2px dotted green; padding: 4px 8px 4px 8px;" />
				</td>
			</tr>
		</table><br/>
		<input type="hidden" name="mid" value="${sMid}" />
		<input type="hidden" name="nickName" value="${sNickName}" />
	</form><br/>
	<button onclick="choreographySuggestionsInput()" class="btn btn-info" style="float: right; margin-right: 10px;">등록</button>
</div>
<jsp:include page="/WEB-INF/views/include/footer.jsp" />  
</body>
</html>


