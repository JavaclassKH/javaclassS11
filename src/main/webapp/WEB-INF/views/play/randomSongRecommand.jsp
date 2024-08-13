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
<title>Second DIVE - randomSongRecommand</title>
<script>
	'use strict';
	
	let reSw = 0;
	let recAlbumImg = "";
	
	
	$(document).ready(function() {
		$("#resultBox").hide();		
		$("#resultBoxImg").hide();		
	});
	
	
	
	// 분위기에 맞는 곡 찾기
	function search() {
		let search = $("#search").val();
		
		if(reSw == 1) {
			$("#resultBox").hide();		
			$("#resultBoxImg").hide();			
		}
		
		if(search.trim() == "") {
			alert("검색할 곡의 분위기를 입력하세요");
			$("#search").focus();
			return false;
		}
		
		$.ajax({
			url : "${ctp}/play/randomSongRecommandSearch",
			type : "post",
			data : {search:search},
			success:function(vo) {
				if(vo.songName == "empty") {
					alert("검색된 곡이 없습니다");
					$("#search").val("");	
					return false;
				}
				else {
					recAlbumImg = vo.recAlbumImg;
					
					if(recAlbumImg.indexOf("<iframe") == -1) {
						recAlbumImg = "<img src='${ctp}/images/"+recAlbumImg+"' width='100%' height='650px' />";											
					}
					
					$("#resultBox").show();	
					$("#resultBoxImg").show();	
					$("#songName").text(vo.songName);
					$("#singer").text(vo.singer);
					$("#genre").text(vo.genre);
					$("#recVibe").text(vo.recVibe);
					$("#resultBoxImg").html(recAlbumImg);
					reSw = 1;
				}
			},
			error:function(){
				alert("검색 중 오류가 발생했습니다. 다시 검색해주세요");
			}
		});	
		
	}
	
	// 랜덤노래찾기
	function random() {
		$.ajax({
			url : "${ctp}/play/randomSongRecommand",
			type : "post",
			success:function(vo) {
				recAlbumImg = vo.recAlbumImg;

				if(recAlbumImg.indexOf("<iframe") == -1) {
					recAlbumImg = "<img src='${ctp}/images/"+recAlbumImg+"' width='100%' height='650px' />";											
				}
				$("#resultBox").show();	
				$("#resultBoxImg").show();	
				$("#songName").text(vo.songName);
				$("#singer").text(vo.singer);
				$("#genre").text(vo.genre);
				$("#recVibe").text(vo.recVibe);
				$("#resultBoxImg").html(recAlbumImg);
				reSw = 1;			
			},
			error:function(){
				alert("추천곡 선정 중 오류가 발생했습니다. 다시 검색해주세요");
			}
		});	
	}
	
	
</script>
</head>
<body>
<jsp:include page="/WEB-INF/views/include/header.jsp" /> 
<jsp:include page="/WEB-INF/views/include/leftSide.jsp" /> 
<div class="rightSide">
  <h1 class="text-center"><strong>&lt; 랜덤노래추천 &gt;</strong></h1><br/>
	<div class="rec">
		<p>원하는 곡의 분위기를 입력하세요</p>
		<div class="input-group">
			<input type="text" name="search" id="search" placeholder="ex)신나는,슬플때,지칠때" class="form-control mr-6" autofocus />
			<div class="input-group-append">
				<button onclick="search()" class="btn btn-light">검색</button>
			</div>
			<div class="input-group-append">
				<button onclick="random()" class="btn btn-info">랜덤</button>
			</div>
		</div>
	</div><br/><br/>  
	<div id="resultBox">
		<p style="margin-left: 10px;"><b><font size="6px">이 노래는 어떠세요??</font></b></p>
		<table class="table text-center">
			<tr class="text-center">
				<th scope="col">제목</th>
				<th scope="col">가수</th>
				<th scope="col">장르</th>
			</tr>
			<tr class="text-center">
				<td scope='row'><span id="songName"></span></td>
				<td scope='row'><span id="singer"></span></td>
				<td scope='row'><span id="genre"></span></td>
			</tr>
			<tr class="table-borderless"><td></td></tr>
			<tr class="text-center"><th colspan="3">분위기</th></tr>
			<tr class="text-center"><td colspan="3"><span id="recVibe"></span></td></tr>
		</table>
	</div><br/>
	<div id="resultBoxImg"></div>
  
  
  
</div>
<jsp:include page="/WEB-INF/views/include/footer.jsp" />  
</body>
</html>