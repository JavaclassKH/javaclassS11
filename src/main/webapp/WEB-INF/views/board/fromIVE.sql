create table fromIVE (
idx int not null auto_increment,                          /* 아이브로부터 게시판 고유번호 */
fromWho char(20) not null,                                /* 글 작성멤버 */
fromIVETitle varchar(50) not null,                               /* 글 제목 */
fromIVEContent text not null,                                    /* 글 내용 */
writeDate datetime default now(),                         /* 작성일자 */
primary key(idx)
);

insert into fromIVE values (default,'[IVE]안유진','DIVE들 만나서 반가워요~','우리 함께 Second DIVE에서 즐거운 추억을 만들어가요~ 사랑해요 다이브들~~♥',default);
insert into fromIVE values (default,'[IVE]가을','DIVE들 만나서 반가워요~','우리 함께 Second DIVE에서 즐거운 추억을 만들어가요~ 사랑해요 다이브들~~♥',default);
insert into fromIVE values (default,'[IVE]레이','DIVE들 만나서 반가워요~','우리 함께 Second DIVE에서 즐거운 추억을 만들어가요~ 사랑해요 다이브들~~♥',default);
insert into fromIVE values (default,'[IVE]장원영','DIVE들 만나서 반가워요~','우리 함께 Second DIVE에서 즐거운 추억을 만들어가요~ 사랑해요 다이브들~~♥',default);
insert into fromIVE values (default,'[IVE]리즈','DIVE들 만나서 반가워요~','우리 함께 Second DIVE에서 즐거운 추억을 만들어가요~ 사랑해요 다이브들~~♥',default);
insert into fromIVE values (default,'[IVE]이서','DIVE들 만나서 반가워요~','우리 함께 Second DIVE에서 즐거운 추억을 만들어가요~ 사랑해요 다이브들~~♥',default);






















