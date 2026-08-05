drop database exercicio4;
create database exercicio4;
use exercicio4;

create table treinador (
	cpfTreinador char(11),
    endereco varchar(255) NOT NULL,
    salario int,
    nome varchar(255) NOT NULL,
    PRIMARY KEY(cpfTreinador)
);

create table atleta (
	cpfAtleta char(11),
    dataNascimento char(10) NOT NULL,
    nome varchar(255) NOT NULL,
    altura decimal(3, 2) NOT NULL,
    peso decimal(3, 1) NOT NULL,
    cpfTreinador char(11) NOT NULL,
    primary key(cpfAtleta),
    foreign key(cpfTreinador) references treinador
);

create table exame (
	codigoExame int,
    nome varchar(255) not null,
    resultado varchar(255) not null,
    dataHora char(19) not null,
    cpfAtleta char(11) not null,
    primary key(codigoExame),
    foreign key(cpfAtleta) references atleta
);

create table modalidade (
	codigoModalidade int,
    tipo varchar(255) not null,
    nome varchar(255) not null,
    primary key(codigoModalidade)
);

create table prova (
	codigoProva int,
    nomeProva varchar(255) not null,
    recordePorva int not null,
    descricao varchar(255) not null,
    tipo varchar(255) not null,
    codigoModalidade int not null,
    primary key(codigoProva),
    foreign key(codigoModalidade) references modalidade
);

create table atleta_realiza_prova (
	cpfAtleta char(11),
    codigoProva int not null,
    dat4 char(10) not null,
    resultado varchar(255) not null,
    primary key(cpfAtleta, codigoProva),
    foreign key(cpfAtleta) references atleta,
    foreign key(codigoProva) references prova
);
