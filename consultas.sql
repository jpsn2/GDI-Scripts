-- INSERT INTO
INSERT INTO telefones(num_tel, cpf_pessoa)
    VALUES('974563927', '62704882819');

-- UPDATE
UPDATE funcionario
SET salario = 3000
WHERE cpf_funcionario = '99124502227';

-- DELETE
DELETE FROM telefones
WHERE cpf_pessoa = '58235053454'
    AND num_tel = '36386225';

-- SELECT-FROM-WHERE
SELECT *
FROM funcionario
WHERE funcao = 'Gerente';

-- BETWEEN
SELECT *
FROM funcionario
WHERE salario BETWEEN 1500 AND 5000;

-- IN
SELECT *
FROM espaco
WHERE tamanho IN ('P', 'M');

-- LIKE
SELECT *
FROM telefones
WHERE num_tel LIKE '9%';

-- IS NULL
SELECT *
FROM pessoa
WHERE complemento IS NULL;

-- INNER JOIN
SELECT p.nome
FROM pessoa p
INNER JOIN funcionario f
    ON f.cpf_funcionario = p.cpf_pessoa;

-- MAX
SELECT MAX(valor)
FROM produto;

-- MIN
SELECT MIN(valor)
FROM produto;

-- AVG
SELECT AVG(valor)
FROM produto;

-- COUNT
SELECT tipo, COUNT(*)
FROM produto
GROUP BY tipo;

-- LEFT ou RIGHT ou FULL JOIN
SELECT p.nome, t.num_tel
FROM pessoa p
LEFT JOIN telefones t
    ON p.cpf_pessoa = t.cpf_pessoa;

-- SUBCONSULTA COM OPERADOR RELACIONAL
SELECT *
FROM funcionario f
WHERE salario = (SELECT MAX(salario)
                FROM funcionario);

-- SUBCONSULTA COM IN
SELECT *
FROM vendedor v
WHERE cpf_vendedor IN (SELECT cpf_cliente
                        FROM cliente);

-- SUBCONSULTA COM ANY
SELECT *
FROM vendedor
WHERE cpf_vendedor = ANY (SELECT cpf_vendedor
                            FROM assistente);

-- SUBCONSULTA COM ALL
SELECT DISTINCT funcao
FROM funcionario
WHERE salario > ALL(SELECT salario
                    FROM funcionario
                    WHERE funcao LIKE '%Monitor%');

-- ORDER BY
SELECT *
FROM produtos
ORDER BY valor;

-- GROUP BY
SELECT tipo, COUNT(tipo)
FROM espaco
GROUP BY tipo;

-- HAVING
SELECT tipo, COUNT(tipo)
FROM produto
GROUP BY tipo
HAVING COUNT(tipo) > 5;

-- UNION ou INTERSECT ou MINUS
SELECT f.cpf_funcionario
FROM funcionario
UNION
SELECT v.cpf_vendedor
FROM vendedor;

-- CREATE VIEW
CREATE VIEW v AS
SELECT *
FROM 