use lab4;
# 课程表
CREATE TABLE course(
c_id VARCHAR(20),
c_name VARCHAR(20) ,
PRIMARY KEY(c_id)
);
# 学生表
CREATE TABLE student(
s_id VARCHAR(20),
s_name VARCHAR(20),
s_birth VARCHAR(20),
s_sex VARCHAR(10) ,
PRIMARY KEY(s_id),
check (s_sex in ('男','女'))
);


# 插入学生表测试数据
insert into student values('01' , '赵雷' , '1990-01-01' , '男');
insert into student values('02' , '钱电' , '1990-12-21' , '男');
insert into student values('03' , '孙风' , '1990-05-20' , '男');
insert into student values('04' , '李云' , '1990-08-06' , '男');
insert into student values('05' , '周梅' , '1991-12-01' , '女');
insert into student values('06' , '吴兰' , '1992-03-01' , '女');
insert into student values('07' , '郑竹' , '1989-07-01' , '女');
insert into student values('08' , '王菊' , '1990-01-20' , '女');
## insert into student values('08' , 'Ironman' , '1990-01-20' , '男');
# 课程表测试数据
insert into course values('01' , '语文' );
insert into course values('02' , '数学' );
insert into course values('03' , '英语' );



CREATE USER 'testuser1'@'localhost' IDENTIFIED BY '123456'; 

show grants for 'testuser1'@'localhost';

GRANT select ON lab4.score TO 'testuser1'@'localhost';
GRANT insert ON lab4.score TO 'testuser1'@'localhost';
select * from mysql.tables_priv where table_name='score';

use lab4;
# 成绩表
CREATE TABLE score(
s_id VARCHAR(20),
c_id VARCHAR(20),
s_score INT(3),
PRIMARY KEY(s_id,c_id),
check (s_score >0)
);
# 成绩表测试数据
insert into score values('01' , '01' , 80);
insert into score values('01' , '02' , 90);
insert into score values('01' , '03' , 99);
insert into score values('02' , '01' , 70);
insert into score values('02' , '02' , 60);
insert into score values('02' , '03' , 80);
insert into score values('03' , '01' , 80);
insert into score values('03' , '02' , 80);
insert into score values('03' , '03' , 80);
insert into score values('04' , '01' , 50);
insert into score values('04' , '02' , 30);
insert into score values('04' , '03' , 20);
insert into score values('05' , '01' , 76);
insert into score values('05' , '02' , 87);
insert into score values('06' , '01' , 31);
insert into score values('06' , '03' , 34);
insert into score values('07' , '02' , 89);
insert into score values('07' , '03' , 98);

REVOKE select ON lab4.score FROM 'testuser1'@'localhost';




create view view_stu as(
	select *
    from student
);

GRANT select ON lab4.view_stu TO 'testuser1'@'localhost';
select * from view_stu;

REVOKE select ON lab4.view_stu FROM 'testuser1'@'localhost';
select * from view_stu;