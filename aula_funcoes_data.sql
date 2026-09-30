-- =====================================================================
--  IFAL Campus Maceió · Banco de Dados · Técnico Integrado
--  Aula: Funções de Data no MySQL
--  Professores: Wladia Bessa e Elvys Soares
--
--  Script para criar e popular o banco usado nos exemplos e exercícios.
--  Como usar: abra no MySQL Workbench e execute tudo (Ctrl + Shift + Enter).
--  ATENÇÃO: o script apaga e recria o banco "aula_datas".
-- =====================================================================

DROP DATABASE IF EXISTS aula_datas;
CREATE DATABASE aula_datas;

USE aula_datas;

-- Nomes de dias e meses em português (DAYNAME, MONTHNAME, DATE_FORMAT).
-- Vale só para a conexão atual: execute de novo sempre que reconectar.
SET lc_time_names = 'pt_BR';


-- ---------------------------------------------------------------------
-- Tabela ALUNOS
-- ---------------------------------------------------------------------
CREATE TABLE alunos (
  id        INT PRIMARY KEY,
  nome      VARCHAR(50) NOT NULL,
  data_nasc DATE        NOT NULL
);

INSERT INTO alunos (id, nome, data_nasc) VALUES
  (1, 'Ana Souza',    '2009-03-12'),
  (2, 'Bruno Lima',   '2008-09-30'),
  (3, 'Carla Mendes', '2009-10-15'),
  (4, 'Diego Santos', '2008-09-05'),
  (5, 'Elisa Rocha',  '2010-01-22');


-- ---------------------------------------------------------------------
-- Tabela EMPRESTIMOS (biblioteca)
-- Prazo de devolução: 7 dias após o empréstimo.
-- data_devolucao fica NULL enquanto o livro não for devolvido.
-- ---------------------------------------------------------------------
CREATE TABLE emprestimos (
  id              INT PRIMARY KEY,
  aluno           VARCHAR(50) NOT NULL,
  livro           VARCHAR(80) NOT NULL,
  data_emprestimo DATE        NOT NULL,
  data_devolucao  DATE        NULL
);

INSERT INTO emprestimos (id, aluno, livro, data_emprestimo, data_devolucao) VALUES
  (1, 'Ana',   'Dom Casmurro', '2026-09-10', '2026-09-15'),
  (2, 'Bruno', 'O Cortiço',    '2026-09-14', NULL),
  (3, 'Carla', 'Vidas Secas',  '2026-09-18', NULL),
  (4, 'Diego', 'Iracema',      '2026-09-24', NULL);


-- ---------------------------------------------------------------------
-- Conferência: as duas consultas abaixo devem mostrar 5 e 4 linhas.
-- ---------------------------------------------------------------------
SELECT * FROM alunos;
SELECT * FROM emprestimos;


-- =====================================================================
--  EXERCÍCIOS (escreva sua consulta abaixo de cada enunciado)
--
--  Observação: CURDATE() usa a data de HOJE. Nos slides consideramos
--  hoje = 28/09/2026; em outro dia, alguns resultados vão mudar.
-- =====================================================================

-- 1) Mostre a data de hoje no formato dd/mm/aaaa.
SELECT CURDATE();

-- 2) Liste o nome e o ano de nascimento de cada aluno.
SELECT nome, data_nasc
FROM alunos;

-- 3) Quantos dias faltam para o Natal deste ano?
SELECT DATEDIFF('2026-12-25', CURDATE());

-- 4) Liste os alunos que nasceram em 2009.
SELECT nome, data_nasc
FROM alunos
WHERE YEAR(data_nasc) = 2009;

-- 5) Mostre a idade de cada aluno, em anos completos.
SELECT nome, TRUNCATE(DATEDIFF(CURDATE(), data_nasc)/365, 0)
FROM alunos;

-- 6) Qual será a data de devolução de um livro emprestado hoje, com prazo de 10 dias?
SELECT DATE_ADD(CURDATE(), INTERVAL 10 DAY)
