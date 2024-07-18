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
				if(res != "0" || res === "1") {
					alert("노래가 정상적으로 등록되었습니다");		
					location.reload();
				}
				else {
					alert("노래가 정상적으로 등록되었습니다");		
					location.reload();				
				}
			},
			error:function(){
				alert("전송중 오류 발생");
			}
		});		
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
					<input type="button" class="btn btn-light" value="장르" onclick="javascript:alert('가수명을 입력하세요');" />
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
			<div class="text-center">
				<button onclick="songInsert()" class="btn btn-success">노래등록</button>
			</div>
		</form>
	</div><br/><br/><br/><br/><br/>

  
  
  
</div>
<jsp:include page="/WEB-INF/views/include/footer.jsp" />  
</body>
</html>