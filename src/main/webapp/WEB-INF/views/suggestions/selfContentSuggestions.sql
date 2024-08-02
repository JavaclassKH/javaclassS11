
create table selfContentSuggestions (
idx int not null auto_increment,                          /* 자체컨텐츠 제안 게시판 고유번호 */
mid varchar(50) not null,                                 /* 작성자 아이디 */
nickName varchar(60) not null,            				        /* 작성자 닉네임 */
selfContentSuggestionsTitle  varchar(50) not null,               /* 글 제목 */
selfContentSuggestionsContent text not null,                     /* 글 내용 */
selfContentFileOriginName VARCHAR(300) NULL DEFAULT NULL,        /* 파일 원본이름(미첨부 가능) */
selfContentFileName varchar(300),                                /* 파일(미첨부 가능) */
writeDate datetime default now(),                         /* 작성일자 */
primary key(idx),
foreign key(mid) references memberSS(mid) ON UPDATE CASCADE
);