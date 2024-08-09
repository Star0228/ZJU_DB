use lab2;#表明你使用的数据库
# 学生表
CREATE TABLE student(
s_id VARCHAR(20),
s_name VARCHAR(20),
s_birth VARCHAR(20),
s_sex VARCHAR(10) NOT NULL DEFAULT '',
PRIMARY KEY(s_id)
);
# 课程表
CREATE TABLE course(
c_id VARCHAR(20),
c_name VARCHAR(20) NOT NULL DEFAULT '',
t_id VARCHAR(20),
PRIMARY KEY(c_id)
);
# 成绩表
CREATE TABLE score(
s_id VARCHAR(20),
c_id VARCHAR(20),
s_score INT(3),
PRIMARY KEY(s_id,c_id)
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
# 课程表测试数据
insert into course values('01' , '语文' , '02');
insert into course values('02' , '数学' , '01');
insert into course values('03' , '英语' , '03');
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

create table test (
adr varchar(20)
);
alter table test add bdr varchar(20);
drop table test;

create index score1 on score(s_score);
drop index score1 on score;

create view view_stu as(
	select *
    from student
);
drop view view_stu;

	select *
    from student;

update student
set s_sex = '女'
where s_id = '04';

delete 
from student
where s_id = '04';


select s_birth
from student
where s_sex = '男';

select * from score;

#将学生表和分数表连接，查询所有在课程2得分超过80分的同学的名字
select distinct s_name
from student natural join score
where c_id = '02' and s_score > 80;

select distinct s_name
from (select s_name,s_sex
	from student natural join score
	where c_id = '02' and s_score > 80) as new
where s_sex = '男';

create view student1 as(
select s_id,s_name,s_sex
from student
);

select s_id
from student1
where s_sex = '男';

#修改id为01的同学的性别为女
update student1
set s_sex = '女'
where s_id = '01';
#查询视图、原数据表全部内容，发现数据同步更新
select * from student;
select * from student1;

create table person(
 id char(3),
 pid char(3),
 primary key(id),
 foreign key (pid) references person(id)
 on delete cascade 
 on update cascade);

delete 
from person
where id = '001';


select count(*);
drop table person;

 create table person(
 id varchar(3),
 gender varchar(3),
 age integer
 );
 insert into person values('p1','M',30);
 insert into person values('p2','F',30);
  insert into person values('p3','M',30);
   insert into person values('p4','F',30);
    insert into person values('p5','M',30);
    select p1.id
    from person as p1,person as p2
    where p1.gender = p2.gender 
    group by p1.id
    having count(*)>2;



