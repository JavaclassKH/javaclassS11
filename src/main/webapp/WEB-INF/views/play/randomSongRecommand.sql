-- randomSongRecommand Table 설계도 
/*

*/
create table randomSongRecommand (
idx int not null auto_increment primary key,
songName varchar(40) not null,                                 /* 노래제목 */
singer varchar(20) not null default '아이브(IVE)',               /* 가수 */ 
genre varchar(40) not null,                                    /* 노래 장르 */
recAlbumImg varchar(200) default 'noAlbumImg.jpg',             /* 추천곡 앨범 표지(없을땐 default) */
recVibe text not null                                          /* 추천 분위기 (새벽, 신날때, 즐거울 때, 슬플 때 등) */	
);

desc randomSongRecommand;
drop table randomSongRecommand;

select * from randomSongRecommand;



select * from randomSongRecommand where recVibe like concat('%','자신감','%') order by rand() limit 1;

insert into randomSongRecommand values (default,'I AM',default,'댄스',default,'자신감이 필요할 때, 당당해져야 할 때, 내 자신을 아껴주고 싶을 때');
insert into randomSongRecommand values (default,'ELEVEN',default,'댄스',default,'몽환적, 은은한 감성, 나 스스로가 멋지게 보일 때, 자신감을 북돋을 때');
insert into randomSongRecommand values (default,'Kitsch',default,'댄스',default,'자신감 뿜뿜할 때, 자유롭고 싶을 때, 명랑마인드 폭발');
insert into randomSongRecommand values (default,'LOVE DIVE',default,'댄스',default,'숨 참고 러브 다이브, 자신감 만땅 충전, 스스로에 대한 사랑이 넘칠 때');