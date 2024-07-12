-- Member Table 설계도 
/*
회원등급 : 1(휴면회원), 2(준회원) , 3(정회원) , 4(우수회원), 5(아이브 멤버) , 99(제제회원), 111(운영자) , 112(관리자)
113(전체관리자), 114(대표운영자(총괄관리자))
※ 상위 회원은 하위 회원의 기능 모두 사용 가능하므로 하위 회원에 작성된 기능은 생략처리
준회원 사용가능기능 : 공지사항, 공식자료, 공식스케줄, 자유게시판(방문횟수 3회 이상, 작성글 3개 이상, 작성댓글 5개 이상일 시 정회원 등업신청 가능)
정회원 사용가능기능 : 토론게시판, 이벤트, 랜덤노래추천, 아이브 퀴즈, From.IVE, To.IVE(방문횟수 100회 이상, 작성글 5개 이상, 작성댓글 10개 이상,
To.IVE 작성글 3개 이상, 현재 정회원일시 우수회원 등업신청 가능)
우수회원 사용가능기능 : 노래 제안, 안무 제안, 자체컨텐츠 제안 
아이브 멤버 사용가능기능 : 우수회원과 동일 (예외: fromIVE 게시판 사용가능, toIVE 게시판 사용불가)
운영자 사용가능기능 : 각 페이지에서 조회,삭제 등이 가능함 [ex)자유게시판 운영자는 자유게시판 내 모든 글의 삭제 권한을 가짐 ] 
관리자 사용가능기능 : 각 페이지와 관리자모드에서 본인 담당부분 관리가 가능함 [ex)자유게시판 운영자는 자유게시판 내 모든 글의 삭제 권한을 가지며,
관리자모드에서도 자유게시판 관리 권한을 가짐 ] 
※ 관리자와 운영자의 차이: 관리자만 관리자모드 접속 가능! 운영자는 유저이용부분에서 운영할 수 있는 버튼과 기능 사용 가능 
전체관리자 사용가능기능 : All (운영자, 관리자 권한수정 가능)
총괄관리자(대표운영자) 사용가능기능 : All (운영자, 관리자 권한수정,부여,박탈 가능)
*/

create table memberSS (
idx int not null auto_increment,          							/* 회원 고유번호 */
mid varchar(50) not null,                 							/* 회원 아이디 */
pwd varchar(50) not null,                 							/* 회원 비밀번호 */
name varchar(50) not null,                							/* 회원 이름 */
nickName varchar(60) not null,            							/* 회원 닉네임 */
contact char(15) not null,                							/* 회원 연락처 */
email varchar(60) not null,                             /* 회원 이메일 */
birthday varchar(15) not null,            							/* 회원 생년월일 */
address varchar(160) not null,            							/* 회원 주소 */
memberImage varchar(160) not null default 'eImg.jpg',   /* 회원 프로필사진 */
fangirlReason varchar(50) not null,       							/* 입덕계기 */
joinDate datetime default now(),          							/* 회원가입일 */ 
lastLoginDate datetime default now(),     							/* 마지막 접속일(접속한지 90일이 지나면 휴면회원전환) */
visitCnt int default 0,                   						  /* 방문횟수(1일 1회만 입력됨) */
totWriteCnt int default 0,                						  /* 총 작성글 수 */
totReplyWriteCnt int default 0,           						  /* 총 작성댓글 수 */
IVEQuizScore int default 0,                             /* 아이브 퀴즈 점수 */
memLevel char(4) default 1,               							/* 회원등급(위에 자세히) */
blockStartDate varchar(12) default '0',                 /* 제제시작날짜 */
blockEndDate varchar(12) default '0',                   /* 제제종료날짜 */
blockCnt int default 0,                   							/* 제제횟수(3회 이상시 강제 탈퇴) */
part char(40) default 'emp',              							/* 담당파트(운영자전용, 회원은 'emp' / 'board','pds'등으로 담당파트 지정) */
primary key(idx),
unique(mid) 
);

