-- =====================================================================
--  IFAL Campus Maceió · Banco de Dados · Técnico Integrado
--  Lista de Exercícios: Views no MySQL
--  Professores: Wladia Bessa e Elvys Soares
--
--  Script para criar e popular o banco "biblioteca_escolar".
--  Como usar: abra no MySQL Workbench e execute tudo (Ctrl + Shift + Enter).
--  ATENÇÃO: o script apaga e recria o banco "biblioteca_escolar"
--  (e, com ele, todas as views que você criou nele).
--  Os dados dos alunos são fictícios.
-- =====================================================================

DROP DATABASE IF EXISTS biblioteca_escolar;
CREATE DATABASE biblioteca_escolar;

USE biblioteca_escolar;


-- ---------------------------------------------------------------------
-- Tabela CATEGORIAS
-- ---------------------------------------------------------------------
CREATE TABLE categorias (
  id   INT PRIMARY KEY,
  nome VARCHAR(30) NOT NULL
);

INSERT INTO categorias (id, nome) VALUES
  (1, 'Romance'),
  (2, 'Fantasia'),
  (3, 'Aventura'),
  (4, 'Ciência'),
  (5, 'Poesia');


-- ---------------------------------------------------------------------
-- Tabela AUTORES
-- ---------------------------------------------------------------------
CREATE TABLE autores (
  id            INT PRIMARY KEY,
  nome          VARCHAR(50) NOT NULL,
  nacionalidade VARCHAR(30) NOT NULL
);

INSERT INTO autores (id, nome, nacionalidade) VALUES
  (1, 'Machado de Assis',   'Brasil'),
  (2, 'Aluísio Azevedo',    'Brasil'),
  (3, 'J. K. Rowling',      'Reino Unido'),
  (4, 'J. R. R. Tolkien',   'Reino Unido'),
  (5, 'Júlio Verne',        'França'),
  (6, 'Monteiro Lobato',    'Brasil'),
  (7, 'Carl Sagan',         'Estados Unidos'),
  (8, 'Cecília Meireles',   'Brasil'),
  (9, 'Graciliano Ramos',   'Brasil');


-- ---------------------------------------------------------------------
-- Tabela LIVROS
-- exemplares = quantos exemplares do livro a biblioteca tem.
-- ---------------------------------------------------------------------
CREATE TABLE livros (
  id             INT PRIMARY KEY,
  titulo         VARCHAR(80) NOT NULL,
  autor_id       INT NOT NULL,
  categoria_id   INT NOT NULL,
  ano_publicacao INT NOT NULL,
  exemplares     INT NOT NULL,
  FOREIGN KEY (autor_id)     REFERENCES autores (id),
  FOREIGN KEY (categoria_id) REFERENCES categorias (id)
);

INSERT INTO livros (id, titulo, autor_id, categoria_id, ano_publicacao, exemplares) VALUES
  ( 1, 'Dom Casmurro',                       1, 1, 1899, 3),
  ( 2, 'Memórias Póstumas de Brás Cubas',    1, 1, 1881, 2),
  ( 3, 'O Cortiço',                          2, 1, 1890, 2),
  ( 4, 'Harry Potter e a Pedra Filosofal',   3, 2, 1997, 4),
  ( 5, 'O Hobbit',                           4, 2, 1937, 1),
  ( 6, 'Vinte Mil Léguas Submarinas',        5, 3, 1870, 1),
  ( 7, 'A Volta ao Mundo em 80 Dias',        5, 3, 1873, 2),
  ( 8, 'Reinações de Narizinho',             6, 2, 1931, 2),
  ( 9, 'Cosmos',                             7, 4, 1980, 1),
  (10, 'O Mundo Assombrado pelos Demônios',  7, 4, 1995, 1),
  (11, 'Ou Isto ou Aquilo',                  8, 5, 1964, 2),
  (12, 'Vidas Secas',                        9, 1, 1938, 3);


-- ---------------------------------------------------------------------
-- Tabela ALUNOS
-- email, cpf, telefone e data_nascimento são dados pessoais (LGPD).
-- ---------------------------------------------------------------------
CREATE TABLE alunos (
  id              INT PRIMARY KEY,
  nome            VARCHAR(50) NOT NULL,
  turma           CHAR(2)     NOT NULL,
  email           VARCHAR(60) NOT NULL,
  cpf             CHAR(14)    NOT NULL,
  telefone        VARCHAR(15) NOT NULL,
  data_nascimento DATE        NOT NULL
);

INSERT INTO alunos (id, nome, turma, email, cpf, telefone, data_nascimento) VALUES
  ( 1, 'Ana Souza',       '2A', 'ana.souza@email.com',      '111.111.111-11', '(82) 99111-0001', '2009-03-12'),
  ( 2, 'Bruno Lima',      '2A', 'bruno.lima@email.com',     '222.222.222-22', '(82) 99222-0002', '2008-09-30'),
  ( 3, 'Carla Mendes',    '2B', 'carla.mendes@email.com',   '333.333.333-33', '(82) 99333-0003', '2009-10-15'),
  ( 4, 'Diego Santos',    '2B', 'diego.santos@email.com',   '444.444.444-44', '(82) 99444-0004', '2009-07-05'),
  ( 5, 'Elisa Rocha',     '3A', 'elisa.rocha@email.com',    '555.555.555-55', '(82) 99555-0005', '2008-12-01'),
  ( 6, 'Fábio Alves',     '3A', 'fabio.alves@email.com',    '666.666.666-66', '(82) 99666-0006', '2008-01-25'),
  ( 7, 'Gabriela Costa',  '2A', 'gabi.costa@email.com',     '777.777.777-77', '(82) 99777-0007', '2009-05-18'),
  ( 8, 'Hugo Ferreira',   '3A', 'hugo.ferreira@email.com',  '888.888.888-88', '(82) 99888-0008', '2008-08-08'),
  ( 9, 'Isabela Nunes',   '2B', 'isabela.nunes@email.com',  '999.999.999-99', '(82) 99999-0009', '2009-02-14'),
  (10, 'João Pedro Melo', '3A', 'joao.melo@email.com',      '101.010.101-01', '(82) 99101-0010', '2008-06-21');


-- ---------------------------------------------------------------------
-- Tabela EMPRESTIMOS
-- O prazo de devolução (data_prevista) é de 14 dias.
-- data_devolucao fica NULL enquanto o livro não foi devolvido.
-- ---------------------------------------------------------------------
CREATE TABLE emprestimos (
  id              INT PRIMARY KEY,
  livro_id        INT  NOT NULL,
  aluno_id        INT  NOT NULL,
  data_emprestimo DATE NOT NULL,
  data_prevista   DATE NOT NULL,
  data_devolucao  DATE NULL,
  FOREIGN KEY (livro_id) REFERENCES livros (id),
  FOREIGN KEY (aluno_id) REFERENCES alunos (id)
);

INSERT INTO emprestimos (id, livro_id, aluno_id, data_emprestimo, data_prevista, data_devolucao) VALUES
  ( 1,  4,  1, '2026-08-03', '2026-08-17', '2026-08-15'),
  ( 2,  1,  2, '2026-08-05', '2026-08-19', '2026-08-22'),
  ( 3,  5,  3, '2026-08-10', '2026-08-24', '2026-08-20'),
  ( 4,  4,  4, '2026-08-20', '2026-09-03', '2026-09-10'),
  ( 5,  9,  1, '2026-09-01', '2026-09-15', '2026-09-14'),
  ( 6,  1,  7, '2026-09-02', '2026-09-16', '2026-09-16'),
  ( 7, 12,  5, '2026-09-08', '2026-09-22', '2026-09-30'),
  ( 8,  4,  2, '2026-09-15', '2026-09-29', '2026-09-28'),
  ( 9,  3,  1, '2026-09-21', '2026-10-05', '2026-10-05'),
  (10,  7,  6, '2026-10-01', '2026-10-15', '2026-10-20'),
  (11,  1,  3, '2026-10-06', '2026-10-20', '2026-10-19'),
  (12,  5,  2, '2026-10-13', '2026-10-27', '2026-11-03'),
  (13,  4,  7, '2026-10-20', '2026-11-03', NULL),
  (14, 11, 10, '2026-11-03', '2026-11-17', NULL),
  (15,  8,  1, '2026-11-05', '2026-11-19', NULL),
  (16,  2,  4, '2026-11-10', '2026-11-24', '2026-11-20');


-- ---------------------------------------------------------------------
-- Conferência: 5 categorias, 9 autores, 12 livros, 10 alunos
-- e 16 empréstimos. Ainda não existe nenhuma view: você vai criá-las!
-- ---------------------------------------------------------------------
SELECT 'categorias' AS tabela, COUNT(*) AS linhas FROM categorias
UNION ALL SELECT 'autores',     COUNT(*) FROM autores
UNION ALL SELECT 'livros',      COUNT(*) FROM livros
UNION ALL SELECT 'alunos',      COUNT(*) FROM alunos
UNION ALL SELECT 'emprestimos', COUNT(*) FROM emprestimos;

/*1. Crie a view vw_alunos_2a com o id, o nome e o e-mail dos alunos da turma 2A. */

CREATE VIEW vw_alunos_2a AS
SELECT id, nome, email 
FROM alunos
WHERE turma = "2A";

/*2. Consulte a view vw_alunos_2a mostrando os alunos em ordem alfabética. 
Depois, use a view para contar quantos alunos a turma 2A tem.*/

SELECT * FROM vw_alunos_2a;
SELECT COUNT(*) FROM vw_alunos_2a;

/*3. Crie a view vw_livros_antigos com o título e o ano de publicação dos livros publicados
antes de 1950. Em seguida, usando a view, mostre só os livros publicados antes de 1900.*/

CREATE VIEW vw_livros_antigos AS
SELECT titulo, ano_publicacao
FROM livros
WHERE ano_publicacao < 1950;
SELECT nome FROM vw_livros_antigos WHERE ano_publicacao < 1900;

/*4. Crie a view vw_livros_acima_media com o título e a quantidade de exemplares 
dos livros que têm mais*/

CREATE VIEW vw_livros_acima_media AS
SELECT titulo, exemplares
FROM livros
WHERE exemplares > (SELECT AVG(exemplares) FROM livros);

/*5. Liste todas as views que existem no banco. Depois,
mostre o SELECT que está guardado dentro da view vw_livros_acima_media*/

SHOW FULL TABLES WHERE Table_type = 'VIEW';
SHOW CREATE VIEW vw_livros_acima_media;

/*6. A secretaria quer que os monitores da biblioteca vejam a lista de alunos 
sem ter acesso aos dados pessoais. Crie a view vw_alunos_publico só com o 
id, o nome e a turma dos alunos. Responda: quais colunas ficaram de fora e 
por que isso é importante?*/

CREATE VIEW vw_alunos_publico AS
SELECT id, nome, turma
FROM alunos 

/*As colunas que ficaram de fora foram o email, cpf, telefone e data_nascimento, 
destacando a importância da proteção de dados pessoais do usuário, fornecendo somente
as informações necessárias dos clientes para as devidas operações*/

/*7. Liste o nome dos clientes que já compraram algum produto da categoria "Informática". Busque o id da categoria pelo nome, sem escrever o número.

select nome from clientes where id in (
    select p.cliente_id from pedidos p 
    join itens_pedido ip on p.id = ip.pedido_id 
    join produtos pr on ip.produto_id = pr.id 
    where pr.categoria_id = (select id from categorias where nome = 'Informática')
);

Dica: a subconsulta pode ter JOIN entre pedidos, itens_pedido e produtos.*/


