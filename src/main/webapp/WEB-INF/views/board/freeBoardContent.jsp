<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<% pageContext.setAttribute("newLine", "\n"); %>
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <jsp:include page="/WEB-INF/views/include/bs4.jsp" />
  <link rel="stylesheet" href="${ctp}/resources/css/bodyLeftRight.css">
<title>Second DIVE - freeBoardContent</title>
<style>
	.btns .rightBtns{
		float: right;
	}
</style>
<script>
	'use strict';
	
    // 댓글 입력처리
    function replyCheck(idx) {
    	let content = $("#content").val();
    	
    	if(content.trim() == "") {
    		alert("댓글을 입력하세요");
    		$("#content").focus();
    		return false;
    	}
    	
    	let query = {
   			boardIdx : idx,
   			mid      : '${sMid}',
   			nickName : '${sNickName}',
   			content  : content
    	}
    	
    	$.ajax({
    		url  : "${ctp}/board/freeBoardReplyInput",
    		type : "post",
    		data : query,
    		success:function(res) {
    			if(res != "0") {
    				$("#forReplylistReload").load(location.href + " #forReplylistReload");
    			}
    			else alert("댓글 입력이 정상적으로 실행되지 않았습니다");
    		},
    		error : function() {
    			alert("전송오류!");
    		}
    	});
    }
    
    // 댓글 삭제하기
    function replyDelete(idx) {
			let answer = confirm("정말로 해당 댓글을 삭제하시겠습니까?");
    	if(!answer) return false;
			
			$.ajax({
				url : "${ctp}/board/freeBoardReplyDelete",
				type : "post",     
				data : {idx : idx},
				success:function(res) {
    			if(res != "0") {
    				$("#forReplylistReload").load(location.href + " #forReplylistReload");
    			}
    			else alert("댓글 삭제가 정상적으로 실행되지 않았습니다");
	    	},
	    	error:function() {
	    		alert("전송오류!");
	    	}
			});
		}

	
</script>
</head>
<body>
<jsp:include page="/WEB-INF/views/include/header.jsp" /> 
<jsp:include page="/WEB-INF/views/include/leftSide.jsp" /> 
<div class="rightSide"><br/>
  <div class="btns">
	  <a href="${ctp}/board/freeBoard?pag=${pageVo.pag}&pageSize=${pageVo.pageSize}" class="btn btn-light mr-2">목록</a>
	  <button onclick="${ctp}/board/freeBoard" class="btn btn-light mr-2">이전글</button>
	  <button onclick="${ctp}/board/freeBoard" class="btn btn-light">다음글</button>
  	<c:if test="${sMid == vo.mid}">
	  	<div class="rightBtns">
			 	<button onclick="location.href='${ctp}/board/freeBoardUpdate?idx=${vo.idx}'" class="btn btn-light mr-2">수정</button>
			 	<button onclick="location.href='${ctp}/board/freeBoardDelete?idx=${vo.idx}'" class="btn btn-light">삭제</button>
	  	</div>
  	</c:if>
  </div><hr/>
  <h3><b>자유게시판</b></h3>
  <div style="margin-top: 2px;">
  	${vo.nickName} &nbsp;&nbsp;&nbsp; 조회수 ${vo.readNum} &nbsp;&nbsp; 
  	작성날짜 ${fn:substring(vo.writeDate,2,16)} &nbsp;&nbsp; 
  </div><br/><br/><br/><br/>
  <div>${vo.freeBoardContent}</div>
  <br/><br/><br/><hr/><br/><br/>
	  
 	<!-- 댓글 시작! (리스트/입력) -->
 	<div id="forReplylistReload">
		<div class="ReplyList">
			<table class="table table-hover text-center">
			  <tr>
			    <th>작성자</th>
			    <th>댓글내용</th>
			    <th>댓글일자</th>
			    <th>삭제하기</th>
			  </tr>
			  <c:forEach var="replyVo" items="${replyVos}" varStatus="st">
			    <tr>
			      <td class="text-center">
			        ${replyVo.nickName}
			      </td>
			      <td class="text-center">${fn:replace(replyVo.content, newLine, "<br/>")}</td>
			      <td class="text-center">${fn:substring(replyVo.writeDate, 0, 10)}</td>
			      <td class="text-center">
			      	<c:if test="${sMid == replyVo.mid || sLevel == 0}">
				        <a href="javascript:replyDelete(${replyVo.idx})" id="replyShowBtn${replyVo.idx}" class="badge badge-danger">삭제</a>
			      	</c:if>
			      </td>
			    </tr>
			  </c:forEach>
			  <tr><td colspan="4" class='m-0 p-0'></td></tr>
		</table>
		
		<!-- 댓글 입력창 -->
		<br/>
		<form name="replyInputForm">
			<table class="table table-secondary table-center">
				<tr>
					<td style="width:85%" class="text-left text-muted">
						<span class="text-center"><b>댓글쓰기</b></span> 
						<textarea rows="4" name="content" id="content" class="form-control mt-3" style="resize: none;"></textarea>
					</td>
					<td style="width:15%">
						<br/><br/>
						<p>작성자 : ${sNickName}</p>
						<p></p>
						<p><input type="button" value="댓글" onclick="replyCheck(${vo.idx})" class="btn btn-success btn-sm" /></p>
					</td>
				</tr>
			</table>
		</form>
	</div>
</div>
<!-- 댓글 끝! -->
	  
	  
</div>
<jsp:include page="/WEB-INF/views/include/footer.jsp" />  
</body>
</html>












