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
<title>Second DIVE - adminMemberList</title>
<style>
	.adminMemberList {
		overflow: scroll;
	}
	
	#modalControlBtns {
		text-align: center;
	}
</style>
<script>
	'use strict';
	
	$(document).ready(function(){
		$("#memberSearch").attr('readonly', true);
	})
	
	
	// 선택등급 회원만 조회!
	function onlyThisLevelShow(level) {
		let answer = confirm("해당 등급의 회원만을 조회하시겠습니까?");
		if(!answer) return false;
		location.href="${ctp}/admin/adminMemberList?level="+level;
	}
	
	// 전체선택 , 전체해제
	function selectChange(x) {
		if(x == 1) {
		  for(let i=0; i<=${fn:length(vos)}; i++) {
		    $("#members"+i).prop("checked",true);
		  }				
		}
		else if(x == 2) {
		  for(let i=0; i<=${fn:length(vos)}; i++) {
		    $("#members"+i).prop("checked",false);
		  }
		}
	}
	
	// 선택회원들을 지정 등급으로 변경
	function memLevelChange() {
		let members = document.querySelectorAll('input[name=members]:checked');
    let level = $("#levelChange").val();
    
		if(members.length === 0) {
			alert("등급을 변경할 회원을 1명 이상 선택해주세요");
			return false;
		}
		
		let idxArr = "";
    members.forEach(function(member) {
    	idxArr += member.value+"/";
     });
		
   	$.ajax({
        url: "${ctp}/admin/adminMemberLevelChange",
        type: "post",
        data: {
           level: level,
           idxArr : idxArr
        },
        success : function(res) {
          if (res != "0") {
            alert("회원등급 수정 완료!");
            location.reload(true);
          } 
          else {
            alert("회원등급 수정 실패");
          }
        },
        error : function() {
          alert("전송오류!");
        }
     });
	}
	
	// 회원관리용 모달 띄우기
	function managementModal(idx, mid, nickName) {
		$("#modalMid").text(mid);
		$("#modalNickName").text(nickName);
		$("#idx").val(idx);
		$("#mid").val(mid);
	}
	
	// 회원 상세정보 조회
	function adminMemberInfoWatch() {
		let idx = $("#idx").val();
		location.href="${ctp}/admin/adminMemberInfoWatch?idx="+idx+"&flag=1";
	}
	
	// 회원 아이디 / 닉네임 강제변경
	function adminMemberMidNickNameChange() {
		let answer = confirm("정말로 해당 회원의 아이디/닉네임을 변경하시겠습니까?\n합당한 사유 없이는 변경할 수 없습니다");
		if(!answer) return false;
		let idx = $("#idx").val();
		location.href="${ctp}/admin/adminMemberInfoWatch?idx="+idx+"&flag=0";
	}
	
	// 회원 제재기간 부여,수정,제거
	function adminMemberBlockManagement() {		
		let idx = $("#idx").val();
		location.href="${ctp}/admin/adminMemberBlockManagement?idx="+idx;
	}
	
	// 회원검색 
	function searchSelectorChange(value) {
		
		if(value == 'none') {
			$(document).ready(function(){
				$("input").attr('placeholder', '');
				$("#memberSearch").attr('readonly', true);
				$("#memberSearch").val('');
			});
		}
		else if(value == 'midAll') {
			$(document).ready(function(){
				$("input").attr('placeholder', '입력하신 아이디와 일치하는 회원을 검색합니다');
				$("#memberSearch").attr('readonly', false);
				$("#memberSearch").val('');
			});
		}
		else if(value == 'nickNameAll') {
			$(document).ready(function(){
				$("input").attr('placeholder', '입력하신 닉네임과 일치하는 회원을 검색합니다');
				$("#memberSearch").attr('readonly', false);
				$("#memberSearch").val('');
			});
		}
		else if(value == 'midPart') {
			$(document).ready(function(){
				$("input").attr('placeholder', '입력하신 아이디를 포함한 모든 회원을 검색합니다');
				$("#memberSearch").attr('readonly', false);
				$("#memberSearch").val('');
			});
		}
		else if(value == 'nickNamePart') {
			$(document).ready(function(){
				$("input").attr('placeholder', '입력하신 닉네임을 포함한 모든 회원을 검색합니다');
				$("#memberSearch").attr('readonly', false);
				$("#memberSearch").val('');
			});
		}
		
		$("#flag").val(value);		
	}
	
	// 회원 검색
	function memberSearch() {
		let memberSearch = $("#memberSearch").val();
		let flag = $("#flag").val();
		
		if(memberSearch.trim() == "") {
			alert("검색하실 회원의 아이디,닉네임을 입력하세요");
			$("#memberSearch").focus();
			return false;
		}
		
		location.href="${ctp}/admin/adminMemberList?memberSearch="+memberSearch+"&flag="+flag;
	}
	
	// 제재기간 부여,조정,제거창 보이기
	function adminMemberBlockManagementShowHide(i) {
		if(i != 0) $("#adminMemberBlockManagement").show();		
		else $("#adminMemberBlockManagement").hide();		
	}
	
	// 게제재기간 부여,조정 제거 실행하기
	function adminMemberBlockManagement(str) {
		let blockEndDate = $("#blockEndDate").val();
		let idx = $("#idx").val();
		location.href="${ctp}/admin/adminMemberBlockManagement?str="+str+"&blockEndDate="+blockEndDate+"&idx="+idx;	
	}
	
</script>
</head>
<body>
<jsp:include page="/WEB-INF/views/include/header.jsp" /> 
<jsp:include page="/WEB-INF/views/include/adminLeftSide.jsp" />  
<div class="rightSide">
  <h1><font size="16"><strong>전체회원 명단</strong></font></h1><br/><br/>
  <div class="controls text-right">
  	<button onclick="selectChange(1)" class="btn btn-success mr-2">전체선택</button>
  	<button onclick="selectChange(2)" class="btn btn-warning mr-3">선택해제</button>
  	<select name="levelChoose" onchange="onlyThisLevelShow(this.value)">
  		<option value="100" <c:if test="${level == 100}">selected</c:if>>전체회원</option>
  		<option value="5" <c:if test="${level == 5}">selected</c:if>>아이브</option>
  		<option value="4" <c:if test="${level == 4}">selected</c:if>>우수회원</option>
  		<option value="3" <c:if test="${level == 3}">selected</c:if>>정회원</option>
  		<option value="2" <c:if test="${level == 2}">selected</c:if>>준회원</option>
  		<option value="1" <c:if test="${level == 1}">selected</c:if>>휴면회원</option>
  		<option value="99" <c:if test="${level == 99}">selected</c:if>>제재회원</option>
  	</select>만 보기 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;||&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
  	<select name="levelChange" id="levelChange">
  		<option value="2">준회원으로</option>
  		<option value="3">정회원으로</option>
  		<option value="4">우수회원으로</option>
  	</select>
  	<button onclick="memLevelChange()" class="btn btn-light ml-2">등급변경</button>
  </div><br/><br/><br/>
	<div class="input-group">
		<div class="input-group-append">
			<select name="searchSelector" id="searchSelector" onchange="searchSelectorChange(this.value)" class="form-control">
				<option value="none">검색키워드 선택</option>
				<option value="midAll">아이디(전체)</option>
				<option value="nickNameAll">닉네임(전체)</option>
				<option value="midPart">아이디(부분)</option>
				<option value="nickNamePart">닉네임(부분)</option>
			</select>	
		</div>
		<input type="text" name="memberSearch" id="memberSearch" class="form-control" />
		<input type="hidden" name="flag" id="flag" value="" style="display: none;" />
		<div class="input-group-append">
			<button onclick="memberSearch()" class="btn btn-light">검색</button>  	
		</div>
	</div><br/><br/>
  <div class="adminMemberList">
	  <table class="table table-bordered">
	  	<tr class="text-center">
	  		<th style="width: 3%">선택</th>
	  		<th style="width: 16%">아이디</th>
	  		<th style="width: 17%">닉네임</th>
	  		<th style="width: 18%">회원가입일</th>
	  		<th style="width: 20%">연락처</th>
	  		<th style="width: 13%">회원등급</th>
	  		<th style="width: 13%">비고</th>
	  	</tr>
	  	<c:if test="${flag == 'midAll' || flag == 'nickNameAll'}">
	  	  <tr class="text-center">
		  		<td style="width: 3%">
			  		<c:if test="${vo.memLevel == 5}">
		  				<input type="hidden" name="members" id="members${i}" value="${vo.idx}" disabled />
	  				</c:if>
	  				<c:if test="${vo.memLevel != 5}">
		  				<input type="checkbox" name="members" id="members${i}" value="${vo.idx}" />
	  				</c:if>
		  		</td>
		  		<td style="width: 16%">${vo.mid}</td>
		  		<td style="width: 17%">${vo.nickName}</td>
		  		<td style="width: 18%">${fn:substring(vo.joinDate,0,16)}</td>
		  		<td style="width: 20%">${vo.tel}</td>
		  		<td style="width: 13%" class="text-center">
		  			<c:if test="${vo.memLevel == 1}">휴면회원</c:if> 
	  				<c:if test="${vo.memLevel == 2}">준회원</c:if> 
	  				<c:if test="${vo.memLevel == 3}">정회원</c:if> 
	  				<c:if test="${vo.memLevel == 4}">우수회원</c:if> 
	  				<c:if test="${vo.memLevel == 5}">아이브</c:if> 
	  				<c:if test="${vo.memLevel == 99}">제재회원<br/>( ${vo.blockDate_diff} 일)</c:if>
		  		</td>
		  		<td style="width: 13%">
		  			<button onclick="managementModal(${vo.idx},'${vo.mid}','${vo.nickName}')" data-toggle="modal" data-target="#managementModal" class="btn btn-info">관리</button>
		  		</td>
		  	</tr>
	  	</c:if>
	  	<c:if test="${flag == 'midPart' || flag == 'nickNamePart'}">
		  	<c:forEach var="vo" items="${vos}" varStatus="st">
		  		<c:set var="i" value="${st.index}" />
		  		<tr class="text-center">
		  			<td style="width: 3%">
		  				<c:if test="${vo.memLevel == 5}">
			  				<input type="hidden" name="members" id="members${i}" value="${vo.idx}" disabled />
		  				</c:if>
		  				<c:if test="${vo.memLevel != 5}">
			  				<input type="checkbox" name="members" id="members${i}" value="${vo.idx}" />
		  				</c:if>
		  			</td>
		  			<td style="width: 16%">${vo.mid}</td>
		  			<td style="width: 17%">${vo.nickName}</td>
		  			<td style="width: 18%">${fn:substring(vo.joinDate,0,16)}</td>
		  			<td style="width: 20%">
		  				${vo.tel}
		  			</td>
		  			<td style="width: 13%" class="text-center">
			  			<c:if test="${vo.memLevel == 1}">휴면회원</c:if> 
		  				<c:if test="${vo.memLevel == 2}">준회원</c:if> 
		  				<c:if test="${vo.memLevel == 3}">정회원</c:if> 
		  				<c:if test="${vo.memLevel == 4}">우수회원</c:if> 
		  				<c:if test="${vo.memLevel == 5}">아이브</c:if> 
		  				<c:if test="${vo.memLevel == 99}">제재회원<br/>(${vo.blockDate_diff}일)</c:if>
		  			</td>
		  			<td style="width: 13%">
		  				<button onclick="managementModal(${vo.idx},'${vo.mid}','${vo.nickName}')" data-toggle="modal" data-target="#managementModal" class="btn btn-info">관리</button>
		  			</td>
		  		</tr>
		  	</c:forEach>	  	
	  	</c:if>
	  	<c:if test="${empty flag}">
		  	<c:forEach var="vo" items="${vos}" varStatus="st">
		  		<c:set var="i" value="${st.index}" />
		  		<tr class="text-center">
		  			<td style="width: 3%">
		  				<c:if test="${vo.memLevel == 5}">
			  				<input type="hidden" name="members" id="members${i}" value="${vo.idx}" disabled />
		  				</c:if>
		  				<c:if test="${vo.memLevel != 5}">
			  				<input type="checkbox" name="members" id="members${i}" value="${vo.idx}" />
		  				</c:if>
		  			</td>
		  			<td style="width: 16%">${vo.mid}</td>
		  			<td style="width: 17%">${vo.nickName}</td>
		  			<td style="width: 18%">${fn:substring(vo.joinDate,0,16)}</td>
		  			<td style="width: 20%">
		  				${vo.tel}
		  			</td>
		  			<td style="width: 13%" class="text-center">
			  			<c:if test="${vo.memLevel == 1}">휴면회원</c:if> 
		  				<c:if test="${vo.memLevel == 2}">준회원</c:if> 
		  				<c:if test="${vo.memLevel == 3}">정회원</c:if> 
		  				<c:if test="${vo.memLevel == 4}">우수회원</c:if> 
		  				<c:if test="${vo.memLevel == 5}">아이브</c:if> 
		  				<c:if test="${vo.memLevel == 99}">제재회원<br/>(${vo.blockDate_diff}일)</c:if>
		  			</td>
		  			<td style="width: 13%">
		  				<button onclick="managementModal(${vo.idx},'${vo.mid}','${vo.nickName}')" data-toggle="modal" data-target="#managementModal" class="btn btn-info">관리</button>
		  			</td>
		  		</tr>
		  	</c:forEach>	  	
	  	</c:if>
	  	<tr><td colspan="5" class="p-0 m-0"></td></tr>
	  </table>
  </div>  
</div>

<!-- 회원관리 Modal Start -->
<div class="modal fade" id="managementModal">
  <div class="modal-dialog modal-lg">
    <div class="modal-content">
    
      <!-- Modal Header -->
      <div class="modal-header">
        <h4 class="modal-title text-center"><b>회원관리시스템</b></h4>
        <button type="button" class="close" data-dismiss="modal">&times;</button>
      </div>
      
      <!-- Modal body -->
      <div class="modal-body">
        <p>회원아이디 : <span id="modalMid"></span> &nbsp;&nbsp;||&nbsp;&nbsp; 회원닉네임 : <span id="modalNickName"></span></p><br/>
        <div id="modalControlBtns">
        	<div>
        		<input type="text" id="idx" style="display: none;" />
        		<input type="text" id="mid" style="display: none;" />
	        	<button onclick="adminMemberInfoWatch()" class="btn btn-link mr-4"><font color="black"><b>회원 상세정보 조회</b></font></button>
	        	<button onclick="adminMemberMidNickNameChange()" class="btn btn-link mr-4"><font color="navy"><b>회원아이디/닉네임 변경</b></font></button>
	        	<button onclick="adminMemberBlockManagementShowHide(1)" class="btn btn-link"><font color="red"><b>제재기간 부여,조정,제거</b></font></button>
        	</div>
        </div><br/><br/>
        <div id="adminMemberBlockManagement" style="display: none;">
        	<h4 class="text-danger text-center"><b>회원 제재 관리</b></h4><br/>
        	<p>
        		<input type="date" name="blockEndDate" id="blockEndDate" class="form-control mb-3" autofocus />
        	</p>
        	<div class="text-center">
        		<input type="text" id="idx" style="display: none;" />
        		<input type="text" id="mid" style="display: none;" />
        		<button onclick="adminMemberBlockManagement('cru')" class="btn btn-warning btn-sm mr-5">부여/수정</button>
        		<button onclick="adminMemberBlockManagement('d')" class="btn btn-danger btn-sm mr-5">제거</button>
        		<button onclick="adminMemberBlockManagementShowHide(0)" class="btn btn-secondary btn-sm mr-3">재제창닫기</button>
        	</div>
        </div>
      </div>
      
      <!-- Modal footer -->
      <div class="modal-footer">
        <button type="button" class="btn btn-danger" data-dismiss="modal">닫기</button>
      </div>
      
    </div>
  </div>
</div>
<!-- 회원관리 Modal End -->
  
<jsp:include page="/WEB-INF/views/include/footer.jsp" />  
</body>
</html>