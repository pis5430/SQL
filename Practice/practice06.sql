
-- author 테이블 생성
-- book테이블과 연결해줘야 하기 때문에
create table author (
    author_id number(10),
    author_name varchar2(100) not null,
    author_desc varchar2(100),
    primary key(author_id)    
);

--author 테이블 생성 확인
select *
from author;

--book 테이블 생성 / book.book_id = author.author_id 와 같이 연결
create table book (
    book_id number(10),
    title varchar2(100) not null,
    pubs varchar2(100),
    pubs_date date,
    author_id number(10),
    primary key(book_id),
    constraint book_fk foreign key (author_id)
    references author(author_id)
);

--book 테이블 생성 확인
select *
from book;

--book 시퀀스 생성
create sequence seq_book_id
increment by 1
start with 1;

--book 시퀀스 삭제(잘못 건드렸을경우 삭제하고 다시만드는 용도)
drop sequence seq_book_id;

--author 시퀀스 생성
create sequence seq_author_id
increment by 1
start with 1;

--author 시퀀스 삭제(잘못 건드렸을경우 삭제하고 다시만드는 용도)
drop sequence seq_author_id;

--시퀀스 생성 확인
select *
from user_sequences;

-- author테이블 데이터 삽입
insert into author
values (seq_author_id.nextval, '이문열', '경북 양양');

insert into author
values (seq_author_id.nextval, '박경리', '경상남도 통영');

insert into author
values (seq_author_id.nextval, '유시민', '17대 국회의원');

insert into author
values (seq_author_id.nextval, '기안84', '기안동에서 산 84년생');

insert into author
values (seq_author_id.nextval, '강풀', '온라인 만화가 1세대'); 

insert into author
values (seq_author_id.nextval, '김영하', '알쓸신잡');

--author 입력 데이터 확인
select *
from author;


--book 데이터 입력
insert into book
values (seq_book_id.nextval, '우리들의 일그러진 영웅' , '다림' , '1998-02-22',1);

insert into book
values (seq_book_id.nextval, '삼국지' , '민음사' , '2002-03-01',1);

insert into book
values (seq_book_id.nextval, '토지' , '마로니에북스' , '2012-08-15',2);

insert into book
values (seq_book_id.nextval, '유시민의 글쓰기 특강' , '생각의길' , '2015-04-01',3);

insert into book
values (seq_book_id.nextval, '패션왕' , '중앙북스(books)' , '2012-02-22',4);

insert into book
values (seq_book_id.nextval, '순정만화' , '재미주의' , '2011-08-03',5);

insert into book
values (seq_book_id.nextval, '오직두사람' , '문학동네' , '2017-05-04',6);

insert into book
values (seq_book_id.nextval, '26년' , '재미주의' , '2012-02-04',5);

--book 입력 데이터 확인
select *
from book;

--author 입력 데이터 확인
select *
from author;

--강풀의 author_desc 정보를 '서울특별시'로 변경해보세요
update author
set author_desc = '서울특별시'
where author_id = 5;

--author 데이터 수정 확인
select *
from author;

--과제1. ppt와 같이 출력하기
select  b.book_id,
        b.title,
        b.pubs,
        to_char(b.pubs_date,'YYYY-MM'),
        a.author_id,
        a.author_name,
        a.author_desc
from book b , author a
where b.author_id = a.author_id ;



