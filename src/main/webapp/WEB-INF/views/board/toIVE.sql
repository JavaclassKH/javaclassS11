create table toIVE (
idx int not null auto_increment,                          /* 아이브에게 게시판 고유번호 */
toWho char(20) not null default '아이브',                    /* 받는 멤버 */
mid varchar(50) not null,                                 /* 작성자 아이디 */
nickName varchar(60) not null,            			      		/* 작성자 닉네임 */
title varchar(50) not null,                               /* 글 제목 */
content text not null,                                    /* 글 내용 */
writeDate datetime default now(),                         /* 작성일자 */
primary key(idx),
foreign key(mid) references memberSS(mid) ON UPDATE CASCADE
);

insert into toIVE values (default,default,'admin','[AD]Master','아이브에게 게시판 오픈 테스트','아이브에게 보냅니다~',default);
insert into toIVE values (default,default,'subAdmin','[AD]subMaster','아이브에게 게시판 오픈 테스트2','아이브에게 보냅니다2~',default);
insert into toIVE values (default,default,'admin','[AD]Master','아이브에게 게시판 오픈 테스트','아이브에게 보냅니다~',default);
insert into toIVE values (default,default,'admin','[AD]Master','아이브에게 게시판 오픈 테스트','아이브에게 보냅니다~',default);
insert into toIVE values (default,default,'admin','[AD]Master','아이브에게 게시판 오픈 테스트','아이브에게 보냅니다~',default);
insert into toIVE values (default,default,'admin','[AD]Master','아이브에게 게시판 오픈 테스트','아이브에게 보냅니다~',default);















