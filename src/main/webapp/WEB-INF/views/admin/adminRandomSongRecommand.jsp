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
<title>Second DIVE - adminRandomSongRecommand</title>
<script>
	'use strict';
	
	// 랜덤노래추천 노래 추가 
	function songInsert() {
		let songName = randomSongManagementForm.songName.value;
		let singer = randomSongManagementForm.singer.value;
		let genre = randomSongManagementForm.genre.value;
		let recAlbumImg = randomSongManagementForm.recAlbumImg.value;
		let recVibe = randomSongManagementForm.recVibe.value;
		
		if(songName.trim() == "") {
			alert("노래 제목을 입력하세요!");
			$("#songName").focus();
			return false;
		}
		else if(singer.trim() == "") {
			alert("가수명을 입력하세요!");
			$("#singer").focus();
			return false;
		}
		else if(genre.trim() == "") {
			alert("장르명을 입력하세요!");
			$("#genre").focus();
			return false;
		}
		else if(recVibe.trim() == "") {
			alert("검색 분위기를 입력하세요!");
			$("#recVibe").focus();
			return false;
		}
		else if(recAlbumImg.trim() == "") {
			let check = confirm("등록하실 곡의 유튜브 공식 뮤직비디오 코드를 입력해주세요!\n공식영상이 없다면 취소를 눌러주세요");
			if(check) {
				$("#recAlbumImg").focus();
				return false;
				location.reload(false);
			}
			else {
				$("#recAlbumImg").val("noImage.jpg");
				return false;
				location.reload(false);
			}
		}
		
		let recommandSong = {
				songName: songName,
				singer: singer,
				genre: genre,
				recAlbumImg: recAlbumImg,
				recVibe: recVibe
		}
		
		$.ajax({
			url : "${ctp}/admin/adminRandomSongRecommand",
			type : "post",
			data : recommandSong,
			success:function(res){
				if(res != "0") {
					alert("노래가 정상적으로 등록되었습니다");		
					location.reload();
					return false;
				}
				else {
					alert("노래가 정상적으로 등록되었습니다");		
					location.reload();				
					return false;
				}
			},
			error:function(){
				alert("전송중 오류 발생");
			}
		});		
	}
	
	// 노래목록보기
	function songListShow() {
		$(".songList").show();
		$("#h").show();
		$("#s").hide();
	}
	
	// 노래목록닫기
	function songListHide() {
		$(".songList").hide();
		$("#h").hide();
		$("#s").show();
	} 
	
	// 노래추천 곡 삭제
	function randomSongRecommandDelete(songName, idx) {
		let answer = confirm("정말로 해당 곡 ["+songName+"]을 삭제하시겠습니까?");
		if(!answer) return false;
		
		location.href="${ctp}/admin/adminRandomSongRecommandDelete?idx="+idx+"&songName="+songName;
	}

	// 노래추천 곡 수정
	function randomSongRecommandUpdate(songName, idx) {
		let answer = confirm("해당 곡 ["+songName+"]을 수정하시겠습니까?");
		if(!answer) return false;
		
		location.href="${ctp}/admin/adminRandomSongRecommandUpdate?idx="+idx;
	}


	
</script>
</head>
<body>
<jsp:include page="/WEB-INF/views/include/header.jsp" /> 
<jsp:include page="/WEB-INF/views/include/adminLeftSide.jsp" /> 
<div class="rightSide">
  <h1 class="text-center" style="margin-bottom: 70px;"><strong>&lt; 랜덤노래추천 관리 &gt;</strong></h1><br/>
  
	<div class="songAddForm">
		<form name="randomSongManagementForm">
			<div class="input-group">
				<div class="input-prepend">
					<input type="button" class="btn btn-light" value="제목" onclick="javascript:alert('노래 제목을 입력하세요');" />
				</div>
				<input type="text" name="songName" id="songName" class="form-control mb-5" autofocus required />
			</div>
			<div class="input-group">
				<div class="input-prepend">
					<input type="button" class="btn btn-light" value="가수" onclick="javascript:alert('가수명을 입력하세요');" />
				</div>
				<input type="text" name="singer" id="singer" class="form-control mb-5" required />
			</div>
			<div class="input-group">
				<div class="input-prepend">
					<input type="button" class="btn btn-light" value="장르" onclick="javascript:alert('노래 장르를 입력하세요');" />
				</div>
				<input type="text" name="genre" id="genre" class="form-control mb-5" required />
			</div>
			<div class="input-group">
				<div class="input-prepend">
					<input type="button" class="btn btn-light" value="분위기" onclick="javascript:alert('추천 분위기를 입력하세요');" />
				</div>
				<input type="text" name="recVibe" id="recVibe" class="form-control mb-5" required />
			</div>
			<div class="input-group">
				<div class="input-prepend">
					<input type="button" class="btn btn-light" value="링크" onclick="javascript:alert('코드를 붙여넣어주세요');" />
				</div>
				<input type="text" name="recAlbumImg" id="recAlbumImg" placeholder=" ※ 주의 : 유튜브에서 공식 영상의 iframe코드(&lt;&gt;)를 붙여넣어주세요" class="form-control mb-5" required />
			</div><br/><br/>
		</form>
		<div class="text-center">
			<button onclick="songInsert()" class="btn btn-success mr-4">노래등록</button>
			<button onclick="songListShow()" id="s" class="btn btn-warning mr-4">목록보기</button>
			<!-- <input type="button" onclick="songListShow()" id="s" value="목록보기" class="btn btn-warning mr-4" /> -->
			<button onclick="songListHide()" id="h" class="btn btn-warning" style="display: none;">목록닫기</button>
		</div>
	</div><br/><br/><br/>
	<div class="songList" style="display: none;">
		<table class="table table-border table-hover">
			<tr class="text-center">
				<th width="5%">선택</th>
				<th width="10%">제목</th>
				<th width="10%">가수</th>     
				<th width="59%">분위기</th>
				<th width="8%">수정</th>
				<th width="8%">삭제</th>
			</tr>
			<c:forEach var="vo" items="${vos}" varStatus="st">
				<tr class="text-center">
					<td width="5%">
						<input type="checkbox" name="songs" id="songs${vo.idx}" value="${vo.idx}" />
					</td>
					<td width="10%">${vo.songName}</td>	
					<td width="10%">${vo.singer}</td>     
					<td width="59%">${vo.recVibe}</td>
					<td width="8%">
						<a class="btn btn-warning btn-sm" href="javascript:randomSongRecommandUpdate('${vo.songName}',${vo.idx})">수정</a>
					</td>		
					<td width="8%">
						<a class="btn btn-danger btn-sm" href="javascript:randomSongRecommandDelete('${vo.songName}',${vo.idx})">삭제</a>
					</td>		
				</tr>
			</c:forEach>
			<tr><td colspan="6" class="m-0 p-0"></td></tr>
		</table>
	</div>
	<!-- 노래목록도 블럭페이지 만들기 -->

  
  
  
</div>
<jsp:include page="/WEB-INF/views/include/footer.jsp" />  
</body>
</html>




<!-- 

	<br/><br/><div class="text-center">
	  <ul class="pagination justify-content-center">
		  <c:if test="${pageVo.pag > 1}"><li class="page-item"><a class="page-link text-secondary" href="${ctp}/board/freeBoard?pag=1&pageSize=${pageVo.pageSize}">첫페이지</a></li></c:if>
		  <c:if test="${pageVo.curBlock > 0}"><li class="page-item"><a class="page-link text-secondary" href="${ctp}/board/freeBoard?pag=${(pageVo.curBlock-1)*pageVo.blockSize + 1}&pageSize=${pageVo.pageSize}">이전블록</a></li></c:if>
		  <c:forEach var="i" begin="${(pageVo.curBlock*pageVo.blockSize)+1}" end="${(pageVo.curBlock*pageVo.blockSize) + pageVo.blockSize}" varStatus="st">
		    <c:if test="${i <= pageVo.totPage && i == pag}"><li class="page-item active"><a class="page-link bg-secondary border-secondary" href="${ctp}/board/freeBoard?pag=${i}&pageSize=${pageVo.pageSize}">${i}</a></li></c:if>
		    <c:if test="${i <= pageVo.totPage && i != pag}"><li class="page-item"><a class="page-link text-secondary" href="${ctp}/board/freeBoard?pag=${i}&pageSize=${pageVo.pageSize}">${i}</a></li></c:if>
		  </c:forEach>
		  <c:if test="${pageVo.curBlock < pageVo.lastBlock}"><li class="page-item"><a class="page-link text-secondary" href="${ctp}/board/freeBoard?pag=${(pageVo.curBlock+1)*pageVo.blockSize+1}&pageSize=${pageVo.pageSize}">다음블록</a></li></c:if>
		  <c:if test="${pageVo.pag < pageVo.totPage}"><li class="page-item"><a class="page-link text-secondary" href="${ctp}/board/freeBoard?pag=${pageVo.totPage}&pageSize=${pageVo.pageSize}">마지막페이지</a></li></c:if>
	  </ul>
	</div>

 -->