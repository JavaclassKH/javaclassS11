<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <jsp:include page="/WEB-INF/views/include/bs4.jsp" />
  <script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
  <script src = "${ctp}/js/woo.js"></script>
  <link rel="stylesheet" href="${ctp}/resources/css/bodyLeftRight.css">
<title>Second DIVE - MemberJoin</title>
<script>

	let idCheckSw = 0; 
	let nickNameCheckSw = 0; 
	const check = /[ㄱ-ㅎ|ㅏ-ㅣ|가-힣]/;
	
	/* <<< 정규식 >>> */ 
	// 이름: 한글 2~6자
	const regName= /^[가-힣]{2,6}$/;   
	// 아이디: 영문 대/소문자와 숫자만을 사용한 5~12자
	const regMid= /^[A-Za-z0-9]{5,12}$/;  
	// 비밀번호:  대문자 1개이상, 소문자 1개이상, 숫자 1개이상, 특수문자 1개이상을 포함한 10~24자
	const regPwd = /^(?=.*[a-z])(?=.*[A-Z])(?=.*[!@#$%^&*])[A-Za-z\d!@#$%^&*]{10,24}$/; 
	//const regPwd = /^[0-9]{3,10}$/;   // 프로젝트용 임시 정규식!
	// 닉네임: 영문/대 소문자, 한글, 숫자만을 사용한 4~12자
	const regNickName = /^[A-Za-z가-힣0-9]{4,12}$/;  
	// 휴대폰번호: 앞번호 3 글자, 중간번호 3또는 4글자, 마지막번호는 4글자. 하이픈 포함 X
	const regTel = /^\d{3}\d{3,4}\d{4}$/;
	// 이메일: 맨 앞은 영문 대/소문자,숫자,밑줄과 하이픈만을 사용한 4~12 글자, 골뱅이 뒤는 영문 대/소문자,숫자,밑줄과 하이픈만을 사용한 4~8 글자
	const regEmail = /^[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*\.[a-zA-Z]{2,3}$/i;
	
	  // 아이디 중복체크
    function idCheck() {
    	let mid = memberJoinForm.mid.value;
    	
    	if(mid.trim() == ""){
    		alert("아이디를 입력하세요");
    		memberJoinForm.mid.focus();
    		return false;
    	}
			else if(mid.match(check)) {
				alert("아이디에 한글을 포함할 수 없습니다. 올바르게 입력해주세요");
				memberJoinForm.nickName.focus();
				return false;			
			}
    	else{
	   		$.ajax({
					url : "${ctp}/member/memberIdCheck",
					type : "post",
					data : { mid : mid },
					success : function(res) {
						if(res != "0") {
							alert("이미 사용중인 아이디입니다.");
							memberJoinForm.mid.focus();
							$("#mid").val("");
							return false;
						}
						else {
							alert("사용 가능한 아이디입니다.");
							$("#mid").attr("readonly", true);
							idCheckSw = 1;
						}
				  },
					error : function() {
						alert("전송 오류");
					}
	   		});    		
    	}
    }
	
	// 아이디 중복체크 후 다시 설정할 때
	function midReset() {
		$("#mid").removeAttr("readonly");
		$("#mid").val("");
	}
	
	// 닉네임 중복체크
	function nickCheck() {
		let nickName = memberJoinForm.nickName.value;
		
		if(nickName.trim() == ""){
			alert("닉네임을 입력하세요");
			memberJoinForm.nickName.focus();
			return false;
		}
		else{
	    	$.ajax({
					url : "${ctp}/member/memberNickCheck",
					type : "post",
					data : { nickName : nickName },
					success : function(res) {
						if(res != "0") {
							alert("이미 사용중인 닉네임입니다.");
							memberJoinForm.nickName.focus();
							$("#nickName").val("");
							return false;
						}
						else {
							alert("사용 가능한 닉네임입니다.");
							$("#nickName").attr("readonly", true);
							nickNameCheckSw = 1;
						}
					},
					error : function() {
						alert("전송 오류");
					}
	    	});    		
		}
	}
	
	// 아이디 중복체크 후 다시 설정할 때
	function nickReset() {
		$("#nickName").removeAttr("readonly");
		$("#nickName").val("");
	}

	// 회원가입 버튼 입력시
	function joinCheck() {
		let mid = memberJoinForm.mid.value;
		let pwd = memberJoinForm.pwd.value;
		let name = memberJoinForm.name.value;
		let nickName = memberJoinForm.nickName.value;
		
		let tel = '';
		let tel1 = memberJoinForm.tel1.value.trim();
		let tel2 = memberJoinForm.tel2.value.trim();
		let tel3 = memberJoinForm.tel3.value.trim();
		tel += tel1 + tel2 + tel3;
		let email = memberJoinForm.email.value;
		
		let address = '';
		let postcode = memberJoinForm.postcode.value + " ";   
		let roadAddress = memberJoinForm.roadAddress.value + " ";   
		let detailAddress = memberJoinForm.detailAddress.value + " ";   
		let extraAddress = memberJoinForm.extraAddress.value + "  ";   
		address = postcode + "/ " + roadAddress + "/ " + detailAddress + "/" + extraAddress;
		let fangirlReason = memberJoinForm.fangirlReason.value;		
		
		  
	  // 전송전에 파일에 관련된 사항들을 체크해준다.
		let fName = document.getElementById("file").value;
		if(fName.trim() != "") {
			let ext = fName.substring(fName.lastIndexOf(".") + 1).toLowerCase();
			let maxSize = 1024 * 1024 * 5;
			let fileSize = document.getElementById("file").files[0].size;
			
			if(ext != 'jpg' && ext != 'gif' && ext != 'png') {
				alert("그림파일만 업로드 가능합니다.");
				return false;
			}
			else if(fileSize > maxSize) {
				alert("업로드할 파일의 최대용량은 5MByte입니다.");
				return false;
			}
		}
		
		
		if(!mid.match(regMid)) {
			alert("아이디 형식에 맞게 작성해주세요!");
			alert("영문 대/소문자와 숫자만을 사용한 5~12자");
			$("#mid").focus();				
		}
		else if(!pwd.match(regPwd)) {
			alert("비밀번호 형식에 맞게 작성해주세요!");
		  alert("대문자 1개이상, 소문자 1개이상, 숫자 1개이상, 특수문자 1개이상을 포함한 10~24자");
			$("#pwd").focus();					
		} 
		else if(!name.match(regName)) {
			alert("이름 형식에 맞게 작성해주세요!");
			alert("한글 2~6자");
			$("#name").focus();
		}
		else if(!nickName.match(regNickName)) {
			alert("닉네임 형식에 맞게 작성해주세요!");
			alert("영문/대 소문자, 한글, 숫자만을 사용한 4~12자");
			$("#nickName").focus();		
		}
		else if(!tel.match(regTel)) {
			alert("전화번호 형식에 맞게 작성해주세요!");
			alert("앞번호 3자, 중간번호 3~4자, 마지막번호 4자");
			$("#tel").focus();				
		}
		else if(!email.match(regEmail)) {
			alert("이메일 형식에 맞게 작성해주세요!"); 
			$("#email").focus();					
		} 
		else {
			if(idCheckSw != 1) {
				alert("아이디 중복체크를 진행해주세요");				
	    	document.getElementById("midBtn").focus();
			}
			else if(nickNameCheckSw != 1){
				alert("닉네임 중복체크를 진행해주세요");		
	    	document.getElementById("nickNameBtn").focus();
			}
			else {					
				tel + tel1 + "-" + tel2 + "-" + tel3;
				memberJoinForm.tel.value = tel;
				memberJoinForm.fangirlReason.value = fangirlReason;
				memberJoinForm.address.value = address;
			
				memberJoinForm.submit();
			}	
	  }
	}
	
</script>
</head>
<body>
<jsp:include page="/WEB-INF/views/include/header.jsp" />
<jsp:include page="/WEB-INF/views/include/leftSide.jsp" /> 
<div class="rightSide">
  <form name="memberJoinForm" method="post" class="was-validated" enctype="multipart/form-data">
    <h2 class="text-center"><b>Second DIVE 회원가입 진행</b></h2>
    <br/>
    <div class="form-group"> 아이디
    	<div class="input-group"> 
	      <input type="text" class="form-control" name="mid" id="mid" title="아이디를 입력하세요" placeholder="아이디" required autofocus/>
	    	<div class="input-group-append">
			    <input type="button" value="중복확인" id="midBtn" title="아이디 중복확인" onclick="idCheck()" class="btn btn-warning" />
	    	</div>
	    	<div class="input-group-append">
      		<input type="button" id="midResetBtn" title="아이디 재설정" value="재설정" onclick="midReset()" class="btn btn-info"  />
    		</div>
    	</div>
    </div><br/>
    <div class="form-group"> 비밀번호
      <div class="input-group">
      	<input type="password" class="form-control" name="pwd" id="pwd" title="비밀번호를 입력하세요" placeholder="비밀번호" required autofocus/>
      </div>
    </div><br/>
    <div class="form-group"> 닉네임
    	<div class="input-group"> 
	      <input type="text" class="form-control" name="nickName" id="nickName" title="닉네임을 입력하세요" placeholder="닉네임" required />
    		<div class="input-group-append">
      		<input type="button" id="nickNameBtn" title="닉네임 중복확인" value="중복확인" class="btn btn-warning" onclick="nickCheck()" />
    		</div>
    		<div class="input-group-append">
      		<input type="button" id="nickNameResetBtn" title="닉네임 재설정" value="재설정" class="btn btn-info" onclick="nickReset()" />
    		</div>
    	</div>
    </div>
    <div class="form-group"> 이름
      <label for="name"></label> 
      <input type="text" class="form-control" name="name" id="name" title="이름을 입력하세요" placeholder="이름" required />
    </div>
    <div class="form-group"> 이메일
      <label for="email"></label>
      <div class="input-group mb-3">
        <input type="email" class="form-control" title="이메일을 정확히 입력하세요" placeholder="이메일" id="email" name="email" required />
      </div>
    </div>
    <div class="form-group">생일
      <label for="birthday"></label>
      <input type="date" name="birthday" id="birthday" value="<%=java.time.LocalDate.now() %>" class="form-control"/>
    </div>
    <div class="form-group">
      <div class="input-group mb-3">
        <div class="input-group-prepend">
          <span class="input-group-text">전화번호</span> &nbsp;&nbsp;
            <select name="tel1" class="custom-select">
              <option value="010" selected>010</option>
            </select>&nbsp;&nbsp;
        </div>
        <input type="text" name="tel2" size=4 maxlength=4 class="form-control"/>&nbsp;&nbsp;
        <input type="text" name="tel3" size=4 maxlength=4 class="form-control"/>
      </div>
    </div>
    <div class="form-group">주소
      <label for="address"></label>
      <div class="input-group mb-2">
        <input type="text" name="postcode" id="sample6_postcode" placeholder="우편번호" class="form-control">
        <div class="input-group-append">
          <input type="button" onclick="sample6_execDaumPostcode()" value="우편번호찾기" class="btn btn-secondary">
        </div>
      </div>
      <input type="text" name="roadAddress" id="sample6_address" size="50" placeholder="주소" class="form-control mb-1">
      <div class="input-group mb-2">
        <input type="text" name="detailAddress" id="sample6_detailAddress" placeholder="상세주소" class="form-control"> &nbsp;&nbsp;
        <div class="input-group-append">
          <input type="text" name="extraAddress" id="sample6_extraAddress" placeholder="기타" class="form-control">
        </div>
      </div>
    </div>
    <div class="form-group">
      <label for="content">입덕계기</label>
      <textarea rows="5" class="form-control" id="fangirlReason" name="fangirlReason" placeholder="입덕계기"></textarea>
    </div><br/>
    <div class="form-group">
      대표이미지(2MB 이하까지 가능합니다) 
      <input type="file" name="fName" id="file" class="form-control-file borderless" />
    </div><br/>
    <div class="text-right">
	    <button type="button" class="btn btn-light mr-3" onclick="joinCheck()">회원가입</button> 
	    <button type="reset" class="btn btn-light mr-3">다시작성</button> 
	    <button type="button" class="btn btn-light" onclick="location.href='${ctp}/member/memberLogin';">로그인</button> 
    </div>
    <input type="hidden" name="tel" />
    <input type="hidden" name="address" />
    <input type="hidden" name="fName" />
    <input type="hidden" name="fangirlReason" />
  </form>
</div>
<jsp:include page="/WEB-INF/views/include/footer.jsp" />  
</body>
</html>