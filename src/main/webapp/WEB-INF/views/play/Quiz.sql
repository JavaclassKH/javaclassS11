-- IVEQuiz Table 설계도 
/*
-- 객관식 ex) 오답/정답/오답/오답 = Shine with me/Stay with me/Simple with me/me with shine 
-- 주관식 ex) 공백
*/
-- 퀴즈자료 테이블 
create table IVEQuiz (
idx int not null auto_increment,            /* 아이브 퀴즈 고유번호 */
quizPart varchar(15) not null,              /* 퀴즈 파트(아이브상식/아이브가사/상식/넌센스) */ 
quizQuestion text not null,                 /* 퀴즈 문제 */
quizAnswer varchar(40) not null,            /* 퀴즈 정답 */
quizbogi text not null,                     /* 퀴즈 보기 ('/' 를 사용하여 객관식 보기를 만들어줌)*/
quizScore int default 10,                   /* 퀴즈 점수 */
primary key(idx)
);

drop table IVEQuiz;

desc IVEQuiz;

select * from IVEQuiz;

insert into IVEQuiz values (default,'IVEInfoQuiz','아이브 첫 정규앨범에 수록된 팬송의 제목은?',
'Shine With Me','Shine to me/Shine us together/Shine With Me/Show with me',default);

insert into IVEQuiz values (default,'IVEInfoQuiz','아이브 공식 캐릭터의 정식 명칭은?',
'미니브','미니브/브브걸/라지브/아담과 이브',default);

insert into IVEQuiz values (default,'IVEInfoQuiz','아이브의 데뷔일은?',
'2021-12-01','2022-02-02/2021-11-11/2021-12-21/2021-12-01',default);

insert into IVEQuiz values (default,'IVEInfoQuiz','아이브 멤버를 나이순으로 올바르게 배치하면?',
'가을-유진-레이-원영-리즈-이서','유진-가을-레이-원영-리즈-이서/유진-가을-원영-레이-리즈-이서/이서-가을-유진-레이-원영-리즈/이서-리즈-원영-레이-유진-가을',default);

insert into IVEQuiz values (default,'IVEInfoQuiz','아이브의 04년생 멤버 레이,원영,리즈를 부르는 케미의 이름은?',
'공포즈','공사즈/공포즈/공사공주들/아가즈',default);

insert into IVEQuiz values (default,'IVEInfoQuiz','아이브라는 그룹이 데뷔때부터 지금까지 가지고 있는 가장 대표적인 컨셉은?',
'나르시시즘','즘시시르나/나르시시즘/육룡이 나르샤/메가 나르',default);

insert into IVEQuiz values (default,'IVEInfoQuiz','아이브 멤버들의 본명은?',
'김가을-안유진-나오이 레이-장원영-김지원-이현서','Shine to me/김가을-안유진-나오이 레이-장원영-김지원-이현서/Shine With Me/김가을-안유진-나오미 레이-장원영-이유진-윤이서',default);

insert into IVEQuiz values (default,'IVEInfoQuiz','아이브라는 그룹명의 의미는?',
'Show What I Have','I Have many Attract/I have a dream/Show What I Have/What I Have to show',default);

insert into IVEQuiz values (default,'IVEInfoQuiz','I Will Survive라는 노래의 간주부분을 샘플링한 곡의 제목은?',
'After Like','Accendio/Blue Heart/ELEVEN/After Like',default);

insert into IVEQuiz values (default,'IVEInfoQuiz','IVE 공식 유튜브에서 공개하는 아이브의 대표 자체컨텐츠의 제목은?',
'1,2,3 IVE','1,2,3 IVE/IVE LOG/DIVE IN TO IVE/DIVENING',default);

--  ======================================================================================















