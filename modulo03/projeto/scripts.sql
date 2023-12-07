-- Parte B: Consultas SQL simples e complexas em um banco de dados postgres

-- Criamos as tabelas: produtos, categorias e produtos_categorias

CREATE TABLE produtos (
    id SERIAL PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    preco DECIMAL(10, 2) NOT NULL,
);

CREATE TABLE categorias (
    id SERIAL PRIMARY KEY,
    nome VARCHAR(100) NOT NULL
);

CREATE TABLE produtos_categorias (
    produto_id INTEGER REFERENCES produtos(id),
    categoria_id INTEGER REFERENCES categorias(id),
    PRIMARY KEY (produto_id, categoria_id)
);

-- Inserção de dados

INSERT INTO produtos (nome, preco) VALUES 
    ('Produto A', 120.50),
    ('Produto B', 89.99),
    ('Produto C', 150.00);

INSERT INTO categorias (nome) VALUES 
    ('Eletrônicos'),
    ('Roupas'),
    ('Acessórios');


INSERT INTO produtos_categorias (produto_id, categoria_id) VALUES
    (1, 1), 
    (1, 3), 
    (2, 2), 
    (3, 1); 

/* Questão 3
Liste os nomes de todos os produtos que custam mais de 100 reais, ordenando-os primeiramente pelo preço e em segundo lugar pelo nome. 
Use alias para mostrar o nome da coluna nome como "Produto" e da coluna preco como "Valor". 
A resposta da consulta não deve mostrar outras colunas de dados.*/

SELECT 
    nome AS "Produto",
    preco AS "Valor"
FROM 
    produtos
WHERE 
    preco > 100
ORDER BY 
    preco, nome;


/* Questão 4
Liste todos os ids e preços de produtos cujo preço seja maior do que a média de todos os preços encontrados na tabela "produtos".*/

SELECT id, preco
FROM produtos
WHERE preco > (SELECT AVG(preco) FROM produtos);



/* Questão 5
Para cada categoria, mostre o preço médio do conjunto de produtos a ela associados. 
Caso uma categoria não tenha nenhum produto a ela associada, esta categoria não deve aparecer no resultado final. 
A consulta deve estar ordenada pelos nomes das categorias.*/

SELECT 
    c.nome       AS categoria, 
    AVG(p.preco) AS preco_medio
FROM categorias c
LEFT JOIN produtos_categorias pc 
    ON c.id = pc.categoria_id
LEFT JOIN produtos p 
    ON pc.produto_id = p.id
GROUP BY c.id
ORDER BY c.nome;


-- Parte C: Inserções, alterações e remoções de objetos e dados em um banco de dados postgres

/* Questão 6
Com o objetivo de demonstrar o seu conhecimento através de um exemplo contextualizado com o dia-a-dia da escola, 
utilize os comandos do subgrupo de funções DDL para construir o banco de dados simples abaixo, 
que representa um relacionamento do tipo 1,n entre as entidades "aluno" e "turma".*/


CREATE TABLE aluno (
    id_aluno SERIAL PRIMARY KEY,
    nome_aluno VARCHAR(255) NOT NULL,
    aluno_alocado BOOLEAN,
    id_turma INT REFERENCES turma(id_turma)
);

CREATE TABLE turma (
    id_turma SERIAL PRIMARY KEY,
    codigo_turma VARCHAR(255) NOT NULL,
    nome_turma VARCHAR(255) NOT NULL
);

/*7) Agora que você demonstrou que consegue ser mais do que um simples usuário do banco de dados, 
mostre separadamente cada um dos códigos DML necessários para cumprir cada uma das etapas a seguir:
a) Inserir pelo menos duas turmas diferentes na tabela de turma;*/

INSERT INTO turma (codigo_turma, nome_turma) VALUES
    ('TURMA_A', 'Trilha Dados'),
    ('TURMA_B', 'Trilha Devops');


-- b) Inserir pelo menos 1 aluno alocado em cada uma destas turmas na tabela aluno (todos com NULL na coluna aluno_alocado);

INSERT INTO aluno (nome_aluno, aluno_alocado, id_turma) VALUES
    ('Carlos Franco', NULL, 1),  
    ('Maria Silva', NULL, 2);


-- c) Inserir pelo menos 2 alunos não alocados em nenhuma turma na tabela aluno (todos com NULL na coluna aluno_alocado)

INSERT INTO aluno (nome_aluno, aluno_alocado, id_turma) VALUES
    ('Carlos Santos', NULL, NULL),
    ('Ana Pereira', NULL, NULL);


/*d) Atualizar a coluna aluno_alocado da tabela aluno, de modo que os alunos associados a uma disciplina recebam o valor True 
e alunos não associados a nenhuma disciplina recebam o valor False para esta coluna.*/

UPDATE aluno
SET aluno_alocado = CASE
    WHEN id_turma IS NOT NULL THEN TRUE
    ELSE FALSE
END;