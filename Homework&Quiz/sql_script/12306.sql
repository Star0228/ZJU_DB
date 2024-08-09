 create table Station (
    station_id int primary key,
    station_name varchar(255) not null,
    city varchar(255) not null
 );
 create table Trip(
    trip_id int primary key,
    station_id int not null,
    sch_id int not null,
    ticket_id int not null,
    trip_name varchar(255) not null,
    start_station int not null,
    arrive_station int not null,
    foreign key(station_id) references Station(station_id),
    foreign key(sch_id) references Schedule(sch_id),
 );


 create table Schedule(
    sch_id int primary key,
    station_id int not null,
    arrive_time datetime not null,
    start_time datetime not null,
    foreign key(station_id) references Station(station_id),
 );

 create table Ticket(
    trip_id int primary key,
    ticket_id int primary key,
    station_id int not null,
    sch_id int not null,
    rank char(1) not null primary key,
    wagon_number int not null primary key,
    position varchar(3) not null primary key,
    priceToArrive numeric(10,2) not null primary key,
    fava_priceToArrive numeric(10,2) not null primary key,
    passenger_id int primary key,
    user_id int primary key,
    isbought boolean not null primary key,
    foreign key(trip_id) references Trip(trip_id),
    foreign key(sch_id) references Schedule(sch_id), 
    foreign key(station_id) references Station(station_id), 
    foreign key(user_id) references User(user_id),
 );

 create table User(
    user_id int primary key,
    name varchar(255) not null,
    identity cahr(1) not null,
    email varchar(255) not null,
 );
 create table user_phone(
    user_id int primary key,
    phone_number varchar(255) not null primary key, 
    foreign key(user_id) references User(user_id),
 );


-- 查询某日从城市A（不是车站）到城市B的所有动车信息
--（包括各类座位的剩票情况），按发车时间排列.
select trip_name,start_time,rank,count(passenger_id)
from Ticket natural join (
    select distinct trip_id,trip_name,start_time,sch_id
    from Trip natural join Station natural join Schedule as A,
    Trip natural join Station natural join Schedule as B
    where A.city = 'A' and B.city = 'B' and A.start_time = '%x月x日%' and B.start_time = '%x月x日%'
)
where passenger_id = null and isbought = false
group by trip_name,rank
order by start_time asc

-- 订票时，系统要知道每个座位的卖出或空余情况，以便订票。
select trip_name,wagon_number,position,isbought
from Ticket natural join Schedule natural join Trip
where start_time = '%x月x日%' and trip_name = 'Dxxxx' and wagon_number = "xx"


--查询某日某车站的所有车次
select trip_name,start_time
from Trip natural join Station natural join Schedule
where start_time = '%x月x日%' and station_name = 'xxx'


-- 查询某日某次列车的行程表（从起点到终点所有车站的到达，发车时间，停留时间）
select station_name,start_time,(arrive_time-start_time)as stay_time
from Trip natural join Station natural join Schedule
where trip_name = 'Dxxxx' and start_time = '%x月x日%'
order by start_time asc


--查询某躺列车和某位乘客同乘一个车厢的所有乘客。
select name
from Ticket natural join (
   select trip_id,wagon_number,sch_id,
   from Ticket natural join User natural join Trip
   where passenger_id = user_id and name = 'xxx' and trip_name = 'xxxx'
)as A,User
where A.passenger_id = User.name

--写出订票transaction: 
--某用户为某乘客购买了某躺列车从A站到B站的车票（包含等级，车厢和座号，价格）.

start transaction
-- assume  trip_name = 'D22' rank is 'S', wagon_number is 5, position is '20A', priceToArrive is 99, fava_priceToArrive is 11 
-- user_id is 0228, passenger_id is 0401 Astation time =t1 ,Bstation time = t2
_id = 520 and station_id = 1314 and sch_id = 66 and rank = 'S' and wagon_number = 5 and position = '20A' and priceToArrive = 99 and fava_priceToArrive = 11 and user_id = 0228 and passenger_id = 0401

update Ticket
set isbought = true,user_id = 0228,passenger_id= 0401
where ticket_id = any (
      select ticket_id
      from Ticket natural join Trip natural join Station natural join 
      (
      select trip_id
      from Trip natural join Station natural join Schedule
      where trip_name = 'D22' and start_time <= t2 and start_time >= t1
      )
)
commit;