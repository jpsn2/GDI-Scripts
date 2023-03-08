-- ======================= SQL
-- ALTER TABLE
ALTER TABLE pessoa
MODIFY nome varchar2(80);

-- CREATE INDEX
CREATE INDEX i
ON funcionario(cpf_funcionario, cpf_supervisor);

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
FROM produto
ORDER BY valor;

-- GROUP BY
SELECT tipo, COUNT(tipo)
FROM espaco
GROUP BY tipo;

-- HAVING
SELECT tipo, COUNT(*)
FROM produto
GROUP BY tipo
HAVING COUNT(*) > 2;

-- UNION ou INTERSECT ou MINUS
SELECT f.cpf_funcionario
FROM funcionario f
UNION
SELECT v.cpf_vendedor
FROM vendedor v;

-- CREATE VIEW
CREATE VIEW v AS
SELECT *
FROM pessoa
WHERE nome LIKE '%Caldeira%';

-- GRANT/ REVOKE
GRANT READ on v
TO PUBLIC;


-- ========================== PL
-- RECORD
DECLARE
    TYPE func_cpf_nome IS RECORD(
    	cpf funcionario.cpf_funcionario%TYPE,
    	nome pessoa.nome%TYPE
    );

    f_cn func_cpf_nome;
BEGIN
    SELECT f.cpf_funcionario, p.nome
    INTO f_cn
    FROM funcionario f, pessoa p
    WHERE f.cpf_funcionario = p.cpf_pessoa
    	and cpf_funcionario = '06651573325';

	dbms_output.put_line(f_cn.cpf || ' -> ' || f_cn.nome);
END;

-- TABLE
DECLARE
    TYPE func_cpf_table IS TABLE OF funcionario.cpf_funcionario%TYPE
    INDEX BY BINARY_INTEGER;

    func_t func_cpf_table;
BEGIN
    func_t(0) := '06651573325';
    dbms_output.put_line(func_t(0));
END;

-- BLOCO ANÔNIMO
DECLARE
    p_out VARCAHR2(20) := 'Hello World!';
BEGIN
    DBMS_OUTPUT.PUT_LINE(p_out);
END;

-- PROCEDURE
CREATE OR REPLACE PROCEDURE insereVendedor (
    v_cpf IN Vendedor.cpf_vendedor%TYPE,
    v_data IN Vendedor.data_registro%TYPE,
    v_cnpj IN Vendedor.cnpj%TYPE
)
IS
BEGIN
    INSERT INTO Vendedor(cpf_vendedor,data_registro,cnpj)
        VALUES(v_cpf,v_data,v_cnpj);
    COMMIT;
END;

-- FUNCTION
CREATE OR REPLACE FUNCTION maxSal
RETURN funcionario.salario%TYPE
IS
    max_sal funcionario.salario%TYPE;
BEGIN
    SELECT MAX(salario)
    INTO max_sal
    FROM funcionario;

    RETURN max_sal;
END;

-- %TYPE
DECLARE
    func_cpf funcionario.cpf_funcionario%TYPE;
BEGIN
    SELECT cpf_funcionario
    INTO func_cpf
    FROM funcionario
    WHERE cpf_funcionario = '56991573326';

    dbms_output.put_line(func_cpf);
END;

-- %ROWTYPE
DECLARE
    vend_reg vendedor%ROWTYPE;
BEGIN
    SELECT *
    INTO vend_reg
    FROM vendedor
    WHERE cpf_vendedor = '72610547200';

    dbms_output.put_line(vend_reg.cpf_vendedor || ' ' ||
        vend_reg.data_registro || ' ' || nvl(vend_reg.cnpj, 'nulo'));
END;

-- IF ELSIF
CREATE OR REPLACE FUNCTION preco_comissao(codigo Espaco.cod_espaco%TYPE)
RETURN VARCHAR2
IS
	comis Espaco.comissao%TYPE;
BEGIN
	SELECT comissao INTO comis
    FROM Espaco WHERE
	cod_espaco = codigo;

	IF comis < 13 THEN
		RETURN 'Comissao Barata';
	ELSIF comis between 13 and 14 THEN
		RETURN 'Comissao Media';
	ELSE
		RETURN 'Comissao Cara';
	END IF;
END;

-- CASE WHEN
CREATE OR REPLACE FUNCTION tamanho_espaço(codigo Espaco.cod_espaco%type)
RETURN VARCHAR2
IS
	tam Espaco.tamanho%type;
BEGIN
	SELECT E.tamanho
    INTO tam
    FROM Espaco E
    WHERE E.cod_espaco = codigo;

	CASE tam
		WHEN 'P' THEN
			RETURN 'Espaço pequeno';
		WHEN 'M' THEN
			RETURN 'Espaço Medio';
		WHEN 'G' THEN
			RETURN 'Espaço Grande';
	END CASE;
END;

-- LOOP EXIT WHEN
DECLARE
    contador espaco.cod_espaco%type := 0;
    n_esp number;
    comis espaco.comissao%type;
BEGIN
    SELECT MAX(cod_espaco)
    INTO n_esp
    FROM espaco;

    LOOP
        SELECT comissao
        INTO comis
        FROM espaco
        WHERE cod_espaco = contador;

        dbms_output.put_line(comis);

        EXIT WHEN contador = n_esp;

        contador := contador + 1;
    END LOOP;
END;

-- WHILE LOOP
CREATE OR REPLACE PROCEDURE preco_fruta
IS
	nom Produto.nome%TYPE;
	val Produto.valor%TYPE;
	tip Produto.tipo%TYPE;
	i INTEGER;
	x INTEGER;
BEGIN
	i := 0;
	SELECT Count(*)-1 INTO x FROM Produto;
	WHILE i < x LOOP
		SELECT P.nome, P.valor, P.tipo INTO nom, val, tip 
		FROM Produto P WHERE P.cod_produto = i;
		IF tip = 'Fruta' THEN
			dbms_output.put_line('FRUTA : ' || nom || ' PRECO: ' || val);
		END IF;
		i := i + 1;
	END LOOP;
END;

-- FOR IN LOOP
CREATE OR REPLACE PROCEDURE responsavel_esp_P
IS
	comi Espaco.comissao%TYPE;
	cpf Espaco.cpf_funcionario%TYPE;
	tip Espaco.tipo%TYPE;
	i Espaco.cod_espaco%TYPE;
	x INTEGER;
BEGIN
	SELECT Count(*)-1 INTO x FROM Espaco;
	FOR i IN 0..x LOOP
		SELECT E.comissao, E.cpf_funcionario, E.tipo
        INTO comi, cpf, tip
		FROM Espaco E
        WHERE E.cod_espaco = i;

		IF tip = 'P' THEN
			dbms_output.put_line('Responsavel : ' || cpf || ' COMISSAO: ' || comi);
		END IF;
	END LOOP;
END;

-- SELECT INTO
DECLARE
    max_preco produto.valor%TYPE;
BEGIN
    SELECT MAX(valor) INTO max_preco 
    FROM produto;

    dbms_output.put_line(max_preco);
END;

-- CURSOR -> OPEN, FETCH e CLOSE
DECLARE
    CURSOR <> IS <>;
BEGIN
    OPEN <>;
    FETCH <> INTO <>;
    CLOSE <>;
END;

-- EXCEPTION WHEN
DECLARE
    var pessoa.cpf_pessoa%type;
BEGIN
    SELECT nome
    INTO var
    FROM pessoa
    WHERE cpf_pessoa = '11111111111';
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        dbms_output.put_line('Não foi encontrado nenhum dado');
END;

-- PARÂMETROS
CREATE OR REPLACE PROCEDURE impostos (
        imposto IN number,
        val IN OUT number
)
IS
BEGIN
    dbms_output.put_line('Valor antes de impostos = ' || val);
    val := val + imposto;
    dbms_output.put_line('Valor depois de impostos = ' || val);
END;

-- CREATE OR REPLACE PACKAGE
-- CREATE OR REPLACE PACKAGE BODY
-- CREATE OR REPLACE TRIGGER (COMANDO)
-- CREATE OR REPLACE TRIGGER (LINHA)
