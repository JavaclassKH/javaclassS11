create table blockReasonData (
idx int not null auto_increment,   /* 제재내역 고유번호 */
mid varchar(50) not null,          /* 제재회원 아이디 */
nickName varchar(60) not null,     /* 제재회원 닉네임 */
blockReason text not null,         /* 제재사유 */
blockStartDate text not null,      /* 제재시작일자 [0000-00-00/0000-00-00/0000-00-00] */ 
blockEndDate text not null,        /* 제재종료일자 [0000-00-00/0000-00-00/0000-00-00] */
blockGiver varchar(50) not null,   /* 제재부여자 닉네임(운영자,관리자) */
primary key(idx),
foreign key(mid) references memberss(mid) on update cascade
);





















