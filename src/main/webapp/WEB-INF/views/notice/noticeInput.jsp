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
<title>Second DIVE - noticeInput</title>
<script>
	'use strict';
	
	function noticeInput() {
		let noticeTitle = noticeInputForm.noticeTitle.value;
		let noticeContent = noticeInputForm.noticeContent.value;
		
		if(title.trim() == "") {
			alert("제목을 작성하세요");
			noticeInputForm.title.focus();
			return false;
		}
		else if(content.trim() == "") {
			alert("내용을 작성하세요");
			noticeInputForm.noticeContent.focus();
			return false;
		}
		 
		noticeInputForm.submit();
		
	}


</script>
</head>
<body>
<jsp:include page="/WEB-INF/views/include/header.jsp" /> 
<jsp:include page="/WEB-INF/views/include/leftSide.jsp" /> 
<div class="rightSide">
	<h2>전체공지 작성</h2><br/>
	<form name="noticeInputForm" method="post">
		<table class="table">
			<tr>
				<th>제목</th>
				<td><input type="text" name="noticeTitle" id="noticeTitle" class="form-control" /></td>
			</tr>
			<tr>
				<th>내용</th>
	      <td><textarea name="noticeContent" id="CKEDITOR" rows="6" class="form-control" required></textarea></td>
	      <script>
				  CKEDITOR.replace("noticeContent",{
					  height:480,
					  filebrowserUploadUrl:"${ctp}/imageUpload",	/* 파일(이미지)를 업로드시키기위한 매핑경로(메소드) */
					  uploadUrl:"${ctp}/imageUpload"             /* uploadUrl : 여러개의 그림파일을 드래그&드롭으로 올릴 수 있다 */ 
					});
	      </script>
			</tr>
		</table><br/>
		<button onclick="noticeInput()" class="btn btn-info" style="float: right; margin-right: 10px;">전체공지등록</button>
		<input type="hidden" name="mid" value="${sMid}" />
		<input type="hidden" name="nickName" value="${sNickName}" />
	</form>
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