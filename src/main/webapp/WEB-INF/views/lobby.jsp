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
<link rel="icon" type="image/png" sizes="16x16" href="${ctp}/images/favicons/favicon-16x16.png">
<meta name="msapplication-TileColor" content="#ffffff">
<meta name="theme-color" content="#ffffff">
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
	
  a {
    color: black;
  }
	
	.input-group {
		margin-top: 30px;
		margin-left: 105px;
		height: 50px;
	}

   #postBox {
     margin-left: 119px;
     width: 1022px;
     height: 976px;
     overflow: scroll;
     padding-right: 5px;
   } 

   #postBox::-webkit-scrollbar {
     width: 9px;
   } 

   #postBox::-webkit-scrollbar-thumb {
     background-color: gray;
     border-radius: 7px;
   } 
    
   #posts {
     display: flex;
     align-items: center; 
     padding: 8px 7px 15px 7px;
     text-align: left;
     border: 1px solid gray;
     border-radius: 6px;
     margin-bottom: 3px;
     word-wrap: break-word; 
     box-sizing: border-box;
   }
    
    .nickname {
      margin-right: 10px; 
      white-space: nowrap; 
    }
    
    .content {
      flex: 1;
      display: flex;
      flex-wrap: wrap; 
    }

    .separator {
      margin-right: 17px; 
    }

</style>
<script>
	'use strict';
	
	$(document).ready(function(){
		let sMid = '${sMid}';
		if(sMid === null || sMid === "") {
			$("#lobbyPost").prop('placeholder',' 로그인 후 이용 가능합니다');
			$("#b1").attr('disabled',true);
		}
		else $("#lobbyPost").prop('placeholder', ' ' + sMid + '님! Second DIVE에 포스트를 남겨보세요~');
	});
	
	function lobbyPostInsert() {
		let sMid = '${sMid}';
		if(sMid === null || sMid === "") {
			alert("로그인 후 포스트 작성이 가능합니다");
			return false;
		}
		
		else {
			let mid = '${sMid}';
			let post = $("#lobbyPost").val();
			
			if(post.trim() == "") {
				alert('포스트 내용을 입력하세요');
				return false;
			}
			
			$.ajax({
				url : "${ctp}/lobbyPostInsert",
				type : "post",
				data : {
					mid : mid,
					post : post
				},
				success:function(res){
					if(res != "0") {
						$('.forReload').load(location.href + ' .forReload');
						$("#lobbyPost").val("");
						$("#lobbyPost").focus();
					}
					else {
						alert("포스트 작성에 실패하였습니다");
						return false;						
					}
				},
				error:function(){
					alert("5 Ryu");
				}
			});
		}
	}


</script>
</head>
<body>
  <jsp:include page="/WEB-INF/views/include/header.jsp" /> 
  <jsp:include page="/WEB-INF/views/include/leftSide.jsp" /> 
  <div class="rightSide">
    <div class="MainWindow">
      <div class="lobbyMusicVideo">
        <iframe width="1020" height="580" src="https://www.youtube.com/embed/07EzMbVH3QE?si=_32IRk9wWbzsiBep" title="YouTube video player" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share" referrerpolicy="strict-origin-when-cross-origin" allowfullscreen></iframe>
      </div>
			<div class="lobbyPost">
				<table class="table table-borderless">
					<tr>
						<td>
							<div class="input-group">
								<input type="text" name="lobbyPost" id="lobbyPost" style="border-radius: 7px; width: 925px;" />
								<div class="input-group-append">
									<button onclick="lobbyPostInsert()" id="b1" style="border-radius: 7px;" class="btn btn-primary">포스트쓰기</button>
								</div>
							</div>
						</td>
					</tr>	
				</table>
				<div class="forReload">
					<div id="postBox">
				    <c:forEach var="vo" items="${vos}">
			        <div id="posts">
		            <div class="nickname">${vo.nickName}</div>
		            <div class="separator">||</div>
		            <div class="content">${vo.post}</div>
			        </div>
				    </c:forEach>
					</div>
				</div>
			</div>
    </div>  	
  </div><br/><br/><br/><br/><br/><br/>
<jsp:include page="/WEB-INF/views/include/footer.jsp" />  
</body>
</html>