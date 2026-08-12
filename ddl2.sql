create database ddl2;
use ddl2;

create table student (
	SID varchar(4),
    Sname varchar(50) not null,
    primary key(Sregistration)
);

create table discipline (
	DID varchar(5),
    Dsyllabus varchar(30) not null,
    primary key(DID)
);

create table teacher(
	TID varchar(6),
    Tname varchar(50) not null,
    primary key(TID)
);

create table offer (
	OID varchar(6),
    Odate char(10) not null,
    Oturn char(1) not null,
    primary key(OID)
);

create table choice ();
