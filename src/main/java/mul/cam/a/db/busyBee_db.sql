-- chatRoom
create table chatRoom(
	roomId varchar(45) not null,
    title varchar(45) not null,
    descriptions varchar(100),
    members varchar(100) not null,
    createdBy varchar(20) not null,
    createdAt datetime not null
);
ALTER TABLE chatRoom
ADD primary key(roomId);
-- chatMessage
create table chatMessage(
	roomId varchar(45) not null,
    writer varchar(45) not null,
    recipient varchar(45) not null,
    message varchar(500) not null,
    sendTime datetime not null
);
ALTER TABLE chatMessage
ADD FOREIGN KEY(roomId) 
REFERENCES chatRoom(roomId);

-- customer
 create table customer(

	seq int auto_increment primary key,
	id varchar(50) not null,
	
	ref decimal(8) not null,
	step decimal(8) not null,
	depth decimal(8) not null,
	
	title varchar(200) not null,
	content varchar(4000) not null,
	filename varchar(50) not null,
	newfilename varchar(50) not null,
	wdate timestamp not null,
	secret tinyint(1) not null
	

);

-- event(calendar)
CREATE TABLE Schedule (
    `scheduleId`   INT              NOT NULL    AUTO_INCREMENT COMMENT '일정 고유 번호', 
    `id`           VARCHAR(45)      NULL        COMMENT '사용자 id', 
    `title`        VARCHAR(200)     NULL        COMMENT '일정 제목', 
    `description`  VARCHAR(3000)    NOT NULL    COMMENT '일정 상세',
    `startDate`   DATETIME         NULL        COMMENT '일정 시작 날짜', 
    `endDate`     DATETIME         NULL        COMMENT '일정 종료 날짜', 
    `isPublic`    INT              NOT NULL    COMMENT '일정 공개 여부(0 or 1)', 
    `isAllDay`   INT              NOT NULL    COMMENT '종일 일정 여부(0 or 1)', 
    `groupCode`   VARCHAR(8)       NOT NULL    COMMENT '그룹 코드', 
     PRIMARY KEY (sheduleId)
);
-- group
create table busybGroup(
    group_code varchar(8) not null primary key,
    group_name varchar(20) not null,
    group_info varchar(30) not null,
    leader_name varchar(20),
    leader_id varchar(20),
    regidate timestamp
);

create table busybGroupMem(
    seq int auto_increment primary key,
    id varchar(20) not null,
    group_code varchar(8) not null,
    regidate timestamp
);

alter table busybGroupMem
ADD FOREIGN KEY (group_code) references busybGroup (group_code);

create table noti(
    seq int auto_increment primary key,
    to_id varchar(20) not null,
    from_id varchar(20) not null,
    group_code varchar(15) not null,
    regimsg varchar(30),
    regidate timestamp
);

alter table noti
ADD FOREIGN KEY (group_code) references busybGroup (group_code);
ALTER TABLE schedule
ADD FOREIGN KEY (id) references user (id);

-- report

 	 	create table report(
	report_id int auto_increment primary key,
	reporter_id varchar(45) not null,
	reported_id varchar(45) not null,
	report_content varchar(200) not null,
	report_seq int not null,
	report_type varchar(45) not null,
	report_date timestamp not null
	);

--  user
create table user(
    id varchar(20) not null primary key,
    password varchar(70) not null,
    name varchar(20) not null,
    email varchar(30) not null,
    phone varchar(20) not null,
    phone_public varchar(5),
    auth int,
    profMsg varchar(30),
    profPic_Origin varchar(20),
    profPic_Server varchar(20),
    regidate timestamp
    
);
create table emailCerti(
    seq int auto_increment primary key,
    cert_email varchar(40) not null,
    authkey varchar(8) not null,
    senddate timestamp
);

-- bbs
CREATE TABLE busybee_bbs
(
    `seq`         INT              NOT NULL    AUTO_INCREMENT COMMENT '글번호. 글번호', 
    `ref`         DECIMAL(8)       NOT NULL    COMMENT '그룹번호. 그룹번호', 
    `step`        DECIMAL(8)       NOT NULL    COMMENT '행번호. 행번호', 
    `depth`       DECIMAL(8)       NOT NULL    COMMENT '깊이번호. 깊이번호', 
    `id`          VARCHAR(50)      NOT NULL    COMMENT '작성자. 회원 아이디', 
    `title`       VARCHAR(200)     NOT NULL    COMMENT '제목. 제목', 
    `content`     VARCHAR(4000)    NOT NULL    COMMENT '내용. 내용', 
    `wdate`       TIMESTAMP        NOT NULL    COMMENT '작성일. 작성일', 
    `readcount`   DECIMAL(8)       NOT NULL    COMMENT '조회수. 조회수', 
    `org`         VARCHAR(50)      NOT NULL    COMMENT '조직명. 조직명', 
    `filename`    VARCHAR(50)          COMMENT '파일명. 파일명', 
    `newfilename` VARCHAR(50)          COMMENT '시스템파일명. 시스템파일명', 
    `category`    VARCHAR(50)      NOT NULL    COMMENT '카테고리', 
    `del`         INT              NOT NULL    COMMENT '삭제', 
    `group_code`  varchar(15)      NOT NULL    COMMENT '그룹코드', 
     PRIMARY KEY (seq, id)
);
CREATE TABLE busybee_bbscomment
(
    `seq`      INT              NOT NULL    COMMENT '글번호. 부모글번호', 
    `anseq`    INT              NOT NULL    AUTO_INCREMENT COMMENT '댓글번호. 댓글번호', 
    `id`       VARCHAR(50)      NOT NULL    COMMENT '작성자. 회원 아이디', 
    `content`  VARCHAR(4000)    NOT NULL    COMMENT '내용. 내용', 
    `wdate`    TIMESTAMP        NOT NULL    COMMENT '작성일. 작성일', 
     PRIMARY KEY (anseq)
);

ALTER TABLE busybee_bbscomment
ADD CONSTRAINT FK_busybee_bbscomment_seq_busybee_bbs_seq FOREIGN KEY (seq)
REFERENCES busybee_bbs (seq) ON DELETE RESTRICT ON UPDATE RESTRICT;

ALTER TABLE busybee_bbscomment
DROP FOREIGN KEY FK_busybee_bbscomment_seq_busybee_bbs_seq;
 
 CREATE TABLE busybee_star
(
    `id`   VARCHAR(50)    NOT NULL    COMMENT '작성자', 
    `seq`  INT            NOT NULL    COMMENT '글번호'
);
ALTER TABLE busybee_star
    ADD CONSTRAINT FK_busybee_star_id_busybee_bbs_id FOREIGN KEY (id, seq)
        REFERENCES busybee_bbs (id, seq) ON DELETE RESTRICT ON UPDATE RESTRICT;
ALTER TABLE busybee_star
 DROP FOREIGN KEY FK_busybee_star_id_busybee_bbs_id;