drop database exercicio3;
create database exercicio3;
use exercicio3;

CREATE TABLE curso (
	codigoCurso int, 
    nomeCurso char(50) NOT NULL,
    PRIMARY KEY(codigoCurso)
);

CREATE TABLE departamento (
	codigoDepartamento int,
    nomeDepartamento char(50) NOT NULL,
    PRIMARY KEY(codigoDepartamento)
);

CREATE TABLE aluno (
	codigoAluno int,
    nomeAluno char(100) NOT NULL,
    codigoDepartamento int NOT NULL,
    PRIMARY KEY(codigoAluno),
    FOREIGN KEY(codigoDepartamento) references departamento
);

CREATE TABLE disciplina (
	codigoDisciplina int,
    nomeDisciplina char(50) NOT NULL,
    codigoDepartamento int NOT NULL,
    PRIMARY KEY(codigoDisciplina),
    FOREIGN KEY(codigoDepartamento) references departamento
);

CREATE TABLE curriculo (
	codigoCurso int, 
    codigoDisciplina int,
    obrigatorioOpcional enum('Obrigatória', 'Opcional') NOT NULL,
    PRIMARY KEY(codigoCurso, codigoDisciplina),
    FOREIGN KEY(codigoCurso) references curso,
    FOREIGN KEY(codigoDisciplina) references disciplina
);

CREATE TABLE conceito (
	codigoAluno int,
    codigoDisciplina int,
    anoSemestre char(6),
    conceito enum('Aprovado', 'Reprovado') NOT NULL,
    PRIMARY KEY(codigoAluno, codigoDisciplina, anoSemestre),
    FOREIGN KEY(codigoAluno) references aluno,
    FOREIGN KEY(codigoDisciplina) references disciplina
);


