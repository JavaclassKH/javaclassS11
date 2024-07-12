create table freeboard (
idx int not null auto_increment,                         /* 자유게시판 고유번호 */
mid varchar(50) not null,                                /* 작성자 아이디 */
nickName varchar(60) not null,                           /* 작성자 닉네임 */
writerIp varchar(40) not null,                           /* 작성자 IP */
title varchar(50) not null,                              /* 글 제목 */
content text not null,                                   /* 작성내용 */
writeDate datetime default now(),                        /* 작성일자 */
readNum int default 0,                                   /* 조회수 */
complainCnt int default 0,                               /* 신고당한 횟수 */
good int default 0,                                      /* 좋아요 */
bad int default 0,                                       /* 싫어요 */
primary key(idx),
foreign key(mid) references member(mid) ON UPDATE CASCADE 
);

select * from freeboard;

desc freeboard;
drop table freeboard;

insert into freeboard values(default,'admin','[AD]Master','192.168.50.64','FB T1','FB T1 dummy',default,default,default,default,default);
insert into freeboard values(default,'test2','테스트2','192.168.50.64','FB T2','FB T1 dummy2',default,default,default,default,default);
insert into freeboard values(default,'admin','[AD]Master','192.168.50.64','FB T1','FB T1 dummy3',default,default,default,default,default);