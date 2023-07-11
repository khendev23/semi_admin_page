--============================
-- 계정생성
--============================
alter session set "_oracle_script" = true;
create user threego  -- 계정명
identified by threego -- 비밀번호 (대소문자 구분)
default tablespace users; -- tablespace는 실제 데이터가 저장된 db내의 공간이름. system / users / ...

-- 상태: 실패 -테스트 실패: ORA-01045: 사용자 SH는 CREATE SESSION 권한을 가지고있지 않음; 로그온이 거절되었습니다
-- 계정이 존재해도 접속권한(create session)이 없다면 db에 접속할 수 없다.
grant create session, create table to threego;
grant connect, resource to threego;

alter user threego quota unlimited on users; -- users tablespace 데이터저장할 용량 무한으로 설정

--=============================
-- 테이블 생성
--=============================
CREATE TABLE member (
	id	varchar2(30)		NOT NULL,
	pwd	varchar2(300)		NOT NULL,
	email	 varchar2(200)		NOT NULL,
	phone	varchar2(11)		NOT NULL,
	user_role	 char(1)	DEFAULT 'U' 	NOT NULL,
	address	varchar2(400)		NOT NULL,
	reg_date	date	DEFAULT sysdate	NOT NULL
);

CREATE TABLE ticket (
	tic_id	varchar2(30)		NOT NULL,
	tic_name	varchar2(30)		NOT NULL,
	tic_cnt	number		NOT NULL,
	tic_price	number		NOT NULL
);

CREATE TABLE payment (
	p_no	number		NOT NULL,
	p_mem_id	varchar2(30)		NOT NULL,
	p_tic_id	varchar2(30)		NOT NULL,
	p_date	date	DEFAULT sysdate	NOT NULL
);

CREATE TABLE request (
	req_no	number		NOT NULL,
	req_writer	varchar2(30)		NOT NULL,
	req_loca	varchar2(10)		NOT NULL,
	req_photo	varchar2(200)		NOT NULL,
	req_status	char(1)	DEFAULT 0	NOT NULL,
	req_date	 date		NULL,
	req_rider	 varchar2(30)		NOT NULL,
	req_cp_date 	date		NOT NULL
);

CREATE TABLE rider (
	r_id	varchar2(30)		NOT NULL,
	r_l_id	varchar2(30)		NOT NULL,
	r_status	char(1)	DEFAULT 0	NOT NULL,
	r_reg_date	date	DEFAULT sysdate	NOT NULL,
	up_date	date		NULL
);

CREATE TABLE location (
	l_id	varchar2(30)		NOT NULL,
	l_name	varchar2(20)		NULL
);

CREATE TABLE board (
	b_no	number		NOT NULL,
	b_write	varchar2(30)		NOT NULL,
	b_type	varchar2(30)		NOT NULL,
	b_tittle	varchar2(500)		NOT NULL,
	b_content	varchar2(4000)		NOT NULL,
	b_reg_date	date	DEFAULT sysdate	NOT NULL,
	b_count	number	DEFAULT 0	NOT NULL
);

CREATE TABLE board_comment (
	c_no	number		NOT NULL,
	c_board_no	number		NOT NULL,
	c_writer	varchar2(30)		NOT NULL,
	c_level	number	DEFAULT 1	NOT NULL,
	c_content	varchar2(4000)		NOT NULL,
	c_reg_date	date	DEFAULT sysdate	NOT NULL
);

CREATE TABLE use_ticket (
	id	varchar2(30)		NOT NULL,
	p_no	number		NOT NULL,
	ut_tic_id	varchar(30)		NOT NULL,
	ut_tic_cnt	number		NOT NULL
);

CREATE TABLE del_member (
	del_id 	varchar2(30)		NOT NULL,
	del_pwd	varchar2(300)		NOT NULL,
	del_email	varchar2(200)		NOT NULL,
	del_phone	varchar2(11)		NOT NULL,
	del_role	char(1)		NOT NULL,
	del_addr 	varchar2(400)		NOT NULL,
	del_reg_date	date		NOT NULL,
	del_date	date	DEFAULT sysdate	NOT NULL
);

CREATE TABLE warning (
	w_no	number		NOT NULL,
	w_req_no	number		NOT NULL,
	w_writer	varchar2(30)		NOT NULL,
	w_content	varchar2(4000)		NOT NULL,
	w_reg_date	date	DEFAULT sysdate	NOT NULL
);

ALTER TABLE member ADD CONSTRAINT PK_MEMBER PRIMARY KEY (
	id
);

ALTER TABLE ticket ADD CONSTRAINT PK_TICKET PRIMARY KEY (
	tic_id
);

ALTER TABLE payment ADD CONSTRAINT PK_PAYMENT PRIMARY KEY (
	p_no
);

ALTER TABLE request ADD CONSTRAINT PK_REQUEST PRIMARY KEY (
	req_no
);

ALTER TABLE rider ADD CONSTRAINT PK_RIDER PRIMARY KEY (
	r_id
);

ALTER TABLE location ADD CONSTRAINT PK_LOCATION PRIMARY KEY (
	l_id
);

ALTER TABLE board ADD CONSTRAINT PK_BOARD PRIMARY KEY (
	b_no
);

ALTER TABLE board_comment ADD CONSTRAINT PK_BOARD_COMMENT PRIMARY KEY (
	c_no,
	c_board_no
);

ALTER TABLE use_ticket ADD CONSTRAINT PK_USE_TICKET PRIMARY KEY (
	id
);

ALTER TABLE del_member ADD CONSTRAINT PK_DEL_MEMBER PRIMARY KEY (
	del_id
);

ALTER TABLE warning ADD CONSTRAINT PK_WARNING PRIMARY KEY (
	w_no,
	w_req_no
);

ALTER TABLE rider ADD CONSTRAINT FK_member_TO_rider_1 FOREIGN KEY (
	r_id
)
REFERENCES member (
	id
);

ALTER TABLE board_comment ADD CONSTRAINT FK_board_TO_board_comment_1 FOREIGN KEY (
	c_board_no
)
REFERENCES board (
	b_no
);

ALTER TABLE use_ticket ADD CONSTRAINT FK_member_TO_use_ticket_1 FOREIGN KEY (
	id
)
REFERENCES member (
	id
);

ALTER TABLE del_member ADD CONSTRAINT FK_member_TO_del_member_1 FOREIGN KEY (
	del_id
)
REFERENCES member (
	id
);

ALTER TABLE warning ADD CONSTRAINT FK_request_TO_warning_1 FOREIGN KEY (
	w_req_no
)
REFERENCES request (
	req_no
);

drop table member;

select * from member;
select * from ticket;
select * from payment;
select * from board;
select * from board_comment;
select * from use_ticket;
select  * from del_member;
select * from request;
select * from rider;
select * from warning;
select * from location;