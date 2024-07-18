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
<title>Second DIVE - adminAuthorityManage</title>
<script>
	'use strict';
	
	// 대표운영자 외 접근금지 보안 추가
	$(document).ready(function(){
		let memLevel = ${sLevel};
		if(memLevel == 113) {
			alert("전체운영자님 전용 권한관리 시스템을 가동합니다");
			return false;
		}
		else if(memLevel == 114) {			
			alert("대표운영자님 전용 권한관리 시스템을 가동합니다");
			return false;
		}
		else if(memLevel != 114) {
			alert("비정상적인 접근을 감지했습니다");
			alert("대표운영자 전용 기능입니다");
			location.href="${ctp}/";
			return false;
		}
	});
	
	// 권한 수정하기
	function authorityChange() {
		let idx = ${vo.idx};
		let memLevel = $("#authorityControlLevel").val();
		let part = $("#authorityControlPart").val();

		if(memLevel == null) {
			alert("부여할 권한을 선택하세요");
			return false;
		}
		else if(part == null) {
			alert("담당파트를 선택하세요");
			return false;
		}
		
		$.ajax({
			url : "${ctp}/admin/adminAuthorityManage",
			type : "post",
			data : {
				idx : idx,
				memLevel : memLevel,
				part : part
			},
			success:function(result){
				if(result == "1") {
					alert("권한수정이 완료되었습니다!");
					location.reload(true);
				}
				else if(result == "111"){
					alert("해당 파트를 담당하는 운영자가 존재합니다\n해당 운영자의 권한을 제거해야 수정이 가능합니다");
					return false;
				}
				else if(result == "112"){
					alert("해당 파트를 담당하는 관리자가 존재합니다\n해당 관리자의 권한을 제거해야 수정이 가능합니다");
					return false;
				}
				else {
					alert("권한수정 명령을 실행 중 오류가 발생했습니다");					
					return false;
				}
			},
			error:function(){
				alert("권한수정 명령 요청중 오류가 발생했습니다");
			}
		});		
		
	}
	
	// 권한 제거하기 
	function authorityDelete(idx,memLevel) {
		let who = "";
		if(memLevel == 111) who = "운영자";
		if(memLevel == 112) who = "관리자";
		
		let answer = confirm("정말로 해당 "+who+"의 권한을 제거하시겠습니까?");
		if(!answer) return false;
		
		$.ajax({
			url : "${ctp}/admin/authorityDelete",
			type : "post",
			data : { idx : idx },
			success:function(res){
				if(res != "0") {
					alert("권한 제거가 정상적으로 완료되었습니다\n해당 회원의 등급은 정회원으로 변경되었습니다");
					location.href="${ctp}/admin/adminLobby";
				}
			},
			error:function(){
				alert("전송오류");
			}
		});
			
	}

</script>
</head>
<body>
<jsp:include page="/WEB-INF/views/include/header.jsp" /> 
<jsp:include page="/WEB-INF/views/include/adminLeftSide.jsp" /> 
<div class="rightSide">
  <div class="infoShow">
		<h1 style="margin-bottom: 50px;">[대표운영자 전용]</h1>
		<h1 style="margin-bottom: 100px;">${vo.nickName} 정보/권한조회</h1><br/>
	 	<p>담당파트 :&nbsp; 
	 		<c:if test="${vo.part == 'freeBoard'}">자유게시판</c:if>
	 		<c:if test="${vo.part == 'fromIVE'}">fromIVE</c:if>
	 		<c:if test="${vo.part == 'notice'}">전체공지</c:if>
	 		<c:if test="${vo.part == 'randomsongRecommand'}">랜덤노래추천</c:if> 		
	 		<c:if test="${vo.part == 'limitAll'}">전체관리</c:if> 		
	 		<c:if test="${vo.part == 'All'}">대표운영</c:if> 		
	 	</p><br/> 
	 	<p>권한 :&nbsp; 
		 	<c:if test="${vo.memLevel == 111}">운영자</c:if>
		 	<c:if test="${vo.memLevel == 112}">관리자</c:if>
		 	<c:if test="${vo.memLevel == 113}">전체관리자</c:if>
		 	<c:if test="${vo.memLevel == 114}">대표운영자</c:if>
	 	</p><br/>
	 	<p>이름 :&nbsp; ${vo.name}</p><br/> 
	 	<p>생년월일 :&nbsp; ${vo.birthday}</p><br/> 
	 	<p>연락처 :&nbsp; ${vo.tel}</p><br/> 
	 	<p>주소 :&nbsp; ${vo.address}</p><br/> 
	 	<p>이메일 :&nbsp; ${vo.email}</p><br/> 
	 	<p>가입일 :&nbsp; ${fn:substring(vo.joinDate,0,11)}</p><br/> 
	 	<p>방문횟수 :&nbsp; ${vo.visitCnt}</p><br/> 
	 	<p>작성 글 수 :&nbsp; ${vo.totWriteCnt}</p><br/> 
	 	<p>작성댓글 수 :&nbsp; ${vo.totReplyWriteCnt}</p><br/><br/><br/>
	 	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	  <div class="btns">
	  	<button onclick="javascript:$('#authorityControl').show();" class="btn btn-warning mr-2">권한수정</button>
	  	<c:if test="${sLevel == 114}">
		  	<button onclick="authorityDelete(${vo.idx},${vo.memLevel})" class="btn btn-danger">권한제거</button>
	  	</c:if>
	  	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	  	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	  	<button onclick="location.href='${ctp}/admin/adminLobby';" class="btn btn-info">돌아가기</button>
	  </div>
	</div><p><br/></p><br/> 
	<div id="authorityControl" style="display: none;">
		<select name="authorityControlLevel" id="authorityControlLevel" class="form-control mb-5">
			<option value="">부여할 권한을 선택하세요</option>
			<option value="111">운영자</option>
			<option value="112">관리자</option>
		</select>
		<select name="authorityControlPart" id="authorityControlPart" class="form-control mb-4">
			<option value="">담당파트를 선택하세요</option>
			<option value="notice">전체공지</option>
			<option value="freeBoard">자유게시판</option>
			<option value="fromIVE">fromIVE</option>
			<option value="toIVE">toIVE</option>
			<option value="suggestSong">노래제안</option>
			<option value="suggestChoreography">안무제안</option>
			<option value="suggestSelfContent">자체컨텐츠제안</option>
			<option value="randomSongRecommand">랜덤노래추천</option>
			<option value="IVEQuiz">퀴즈파크</option>
			<option value="gradrManage">등업관리</option>
		</select>
		<div class="text-right">
			<button onclick="authorityChange()" class="btn btn-success mt-4 mr-3">수정</button>
			<button onclick="javascript:$('#authorityControl').hide();" class="btn btn-warning mt-4">닫기</button>
		</div>
	</div>
	
	
</div>
<jsp:include page="/WEB-INF/views/include/footer.jsp" />  
</body>
</html>




















