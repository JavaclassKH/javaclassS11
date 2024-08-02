
create table choreographySuggestions (
idx int not null auto_increment,                          /* 안무 제안 게시판 고유번호 */
mid varchar(50) not null,                                 /* 작성자 아이디 */
nickName varchar(60) not null,            				        /* 작성자 닉네임 */
choreographySuggestionsTitle  varchar(50) not null,               /* 글 제목 */
choreographySuggestionsContent text not null,                     /* 글 내용 */
choreographyFileOriginName VARCHAR(300) NULL DEFAULT NULL,        /* 영상파일 원본이름(미첨부 가능) */
choreographyFileName varchar(300),                                /* 영상파일(미첨부 가능) */
writeDate datetime default now(),                         /* 작성일자 */
primary key(idx),
foreign key(mid) references memberSS(mid) ON UPDATE CASCADE
);


insert into choreographySuggestions values (default,'admin','[AD]Master','안무제안 게시판 테스트 시작합니다','안무제안 게시판 글 내용 테스트합니다','','',default);






