

create table songSuggestions (
idx int not null auto_increment,                          /* 노래 제안 게시판 고유번호 */
mid varchar(50) not null,                                 /* 작성자 아이디 */
nickName varchar(60) not null,            				        /* 작성자 닉네임 */
songSuggestionsTitle  varchar(50) not null,               /* 글 제목 */
SongSuggestionsContent text not null,                     /* 글 내용 */
songFileOriginName VARCHAR(300) NULL DEFAULT NULL,        /* 음악파일 원본이름(미첨부 가능) */
songFileName varchar(300),                                /* 음악파일(미첨부 가능) */
writeDate datetime default now(),                         /* 작성일자 */
primary key(idx),
foreign key(mid) references memberSS(mid) ON UPDATE CASCADE
);

insert into songSuggestions values (default,'admin','[AD]Master','노래제안 게시판 테스트 시작합니다','노래제안 게시판 글 내용 테스트합니다','','',default);







































