use lab3;
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
# 成绩表
CREATE TABLE score(
s_id VARCHAR(20),
c_id VARCHAR(20),
s_score INT(3),
PRIMARY KEY(s_id,c_id),
check (s_score >0),
foreign key(s_id) references student(s_id),
foreign key(c_id) references course(c_id)
);


drop table score,student,course;


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


delete from  student
where s_id = '01';

update   student
set s_id = '09'
where s_name = '赵雷';

insert into student values('09' , 'Ironman' , '1990-01-20' , '武装直升机');
select *
from student;

Create assertion score_range 
check
(not exists (select * from score
Where s_score>100));

select *
from score;


##定义一个触发器，使得插入学生成绩时，如果学生的成绩低于60分，则触发“help”捞捞，将学生的成绩自动更新为60
delimiter //
create trigger help 
after update on student for each row 
begin
	update score
	set s_score = 60
	where s_score<60;
end;//
delimiter ;

drop trigger help;

update student 
set s_sex = '女'
where s_name = '赵雷';






