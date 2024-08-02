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
<title>Second DIVE - songSuggestionsInput</title>
<script>
	'use strict';
	
	function songSuggestionsInput() {
		let songSuggestionsTitle = songSuggestionsInputForm.songSuggestionsTitle.value;
		let songSuggestionsContent = CKEDITOR.instances.CKEDITOR.getData();
		
		let fName = document.getElementById("file").value;
		if(fName.trim() != "") {
			let ext = fName.substring(fName.lastIndexOf(".") + 1).toLowerCase();
			let maxSize = 1024 * 1024 * 5;
			let fileSize = document.getElementById("file").files[0].size;
			
			if(ext != 'mp2' && ext != 'mp3' && ext != 'mp4') {
				alert("음악파일만 업로드 가능합니다.");
				return false;
			}
			else if(fileSize > maxSize) {
				alert("업로드할 파일의 최대용량은 5MByte입니다.");
				return false;
			}
		}
		

		if (songSuggestionsTitle.trim() == "") {
			alert("제목을 작성하세요");
			$("#songSuggestionsTitle").focus();
			return false;
		} else if (songSuggestionsContent.trim() == "") {
			alert("내용을 작성하세요");
			$("#songSuggestionsContent").focus();
			return false;
		} else
			songSuggestionsInputForm.submit();
	}
	
	
</script>
</head>
<body>
<jsp:include page="/WEB-INF/views/include/header.jsp" /> 
<jsp:include page="/WEB-INF/views/include/leftSide.jsp" /> 
<div class="rightSide">
	<h2>노래제안하기</h2><br/>
	<form name="songSuggestionsInputForm" method="post" enctype="multipart/form-data">
		<table class="table">
			<tr>
				<th width="10%">제목</th>
				<td><input type="text" name="songSuggestionsTitle" id="songSuggestionsTitle" class="form-control" /></td>
			</tr>
			<tr>
				<th width="10%">제안이유</th>
	      <td><textarea name="songSuggestionsContent" id="CKEDITOR" rows="6" class="form-control" required></textarea></td>
	      <script>
				  CKEDITOR.replace("songSuggestionsContent",{
					  height:480,
					  filebrowserUploadUrl:"${ctp}/imageUpload",	/* 파일(이미지)를 업로드시키기위한 매핑경로(메소드) */
					  uploadUrl:"${ctp}/imageUpload"             /* uploadUrl : 여러개의 그림파일을 드래그&드롭으로 올릴 수 있다 */ 
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
	<button onclick="songSuggestionsInput()" class="btn btn-info" style="float: right; margin-right: 10px;">등록</button>
</div>
<jsp:include page="/WEB-INF/views/include/footer.jsp" />  
</body>
</html>


