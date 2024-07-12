<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<jsp:include page="/WEB-INF/views/include/bs4.jsp" />
<link rel="stylesheet" href="${ctp}/resources/css/bodyLeftRight.css">
<title>Second DIVE - lobby</title>

<style>
	body {
	  margin: 0;
	  padding: 0;
	  font-size: 14px;
	  opacity: 0.8; 
	  cursor : url('${ctp}/images/c${c}.gif') 15 13, auto;  
	}

  .MainWindow {
    text-align: center;
  }

  .lobbyMusicVideo {
    margin: 0px;
    padding: 0px;
    margin-left: 40px;
  }
	
	.todaySong {
	  width: 1020px;
	  margin-top: 60px;
    margin-left: 80px;
	}
	
  a {
    color: black;
  }
  
  table {
  	width: 820px;
  }
	

</style>
</head>
<body>
  <jsp:include page="/WEB-INF/views/include/header.jsp" /> 
  <jsp:include page="/WEB-INF/views/include/leftSide.jsp" /> 
  <div class="rightSide">
    <div class="MainWindow">
      <div class="lobbyMusicVideo">
        <iframe width="1020" height="580" src="https://www.youtube.com/embed/07EzMbVH3QE?si=_32IRk9wWbzsiBep" title="YouTube video player" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share" referrerpolicy="strict-origin-when-cross-origin" allowfullscreen></iframe>
      </div>
	   	<div class="todaySong">
	   		<h3 class="text-center" style="font-size: 4em;"><b>- 오늘의 추천곡 -</b></h3>
	   		<p style="font-size: 3em;">Today : yyyy년 MM월 dd일의 추천곡입니다</p><br/>
	   		<div>
		   		임시이미지<img src="${ctp}/images/HeaderImg.jpg" width="720px" />
	   		</div><br/>
	   		<p style="font-size: 20px;">
	   			제목 : imsiSongTitle <br/>
	   			가수 : imsiSinger 
	   		</p>
	   	</div><br/><br/> 
	   	<div>
	   		<table class="table table-borderless table-hover">
	   			<tr>
	   				<th>멤버</th>
	   				<th>제목</th>
	   				<th>작성일</th>
	   			</tr>
		   		<tr>
		   			<td>IVE.유진</td>
		   			<td>다이브들 안녕~</td>
		   			<td>2024.06.28</td>
		   		</tr>
	   		</table>
	   	</div>
    </div>  	
  </div><br/>
<jsp:include page="/WEB-INF/views/include/footer.jsp" />  
</body>
</html>