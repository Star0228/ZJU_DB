use hw3;
create table branch(
    branch_name varchar(20),
    branch_city varchar(20),
    assets int,
    primary key(branch_name)
);

create table customer(
    ID int,
    customer_name varchar(20),
    customer_street varchar(20),
    customer_city varchar(20),
    primary key(ID)
);

create table loan(
    loan_number int,
    branch_name varchar(20),
    amount int,
    primary key(loan_number)
);

create table borrower(
    ID int,
    loan_number int,
    primary key(ID, loan_number)
);

create table account(
    account_number int,
    branch_name varchar(20),
    balance int,
    primary key(account_number)
);

create table depositor(
    ID int,
    account_number int,
    primary key(ID, account_number)
);

insert into branch values('Harrison', 'Harrison', 100000);
insert into branch values('Perryridge', 'Brooklyn', 50000);
insert into branch values('Brighton', 'Brooklyn', 60000);
insert into branch values('Redwood', 'Palo Alto', 70000);   
insert into branch values('Round Hill', 'Harrison', 80000);
insert into customer values(111, 'Ivan', 'Main', 'Harrison');
insert into customer values(222, 'Petr', 'Elm', 'Harrison');
insert into customer values(333, 'Vladimir', 'Park', 'Brooklyn');
insert into customer values(444, 'Sergey', 'Pine', 'Brooklyn');
insert into customer values(555, 'Dmitry', 'Washington', 'Palo Alto');
insert into customer values(666, 'Andrey', 'North', 'Palo Alto');
insert into customer values(12345, 'And', 'North', 'Palo Alto');
insert into loan values(1111, 'Harrison', 5000);
insert into loan values(2222, 'Perryridge', 9000);
insert into loan values(3333, 'Brighton', 12000);
insert into loan values(4444, 'Redwood', 15000);
insert into loan values(5555, 'Round Hill', 18000);
insert into borrower values(111, 1111);
insert into borrower values(222, 2222);
insert into borrower values(333, 3333);
insert into borrower values(444, 4444);
insert into borrower values(555, 5555);
insert into account values(11111, 'Harrison', 1000);
insert into account values(22222, 'Perryridge', 2000);
insert into account values(33333, 'Brighton', 3000);
insert into account values(44444, 'Redwood', 4000);
insert into account values(55555, 'Round Hill', 5000);
insert into depositor values(111, 11111);
insert into depositor values(222, 22222);
insert into depositor values(333, 33333);
insert into depositor values(444, 44444);
insert into depositor values(555, 55555);

drop table branch;
drop table customer;
drop table loan;
drop table borrower;
drop table account;
drop table depositor;

(select ID 
from depositor)
except
(select ID
from borrower);
