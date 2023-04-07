-- consultar todos os funcionários em ordem alfabética que moram em casa ou que o endereço não tem complemento
SELECT f.cpf, f.nome, nvl(DEREF(f.endereco).complemento, 'complemento não informado') "complemento"
FROM tb_Funcionario f
WHERE DEREF(f.endereco).complemento LIKE 'Casa'
    or DEREF(f.endereco).complemento IS NULL
ORDER BY f.getNome();

-- consultar todos os produtos que foram vendidos com mais de 5% de desconto
SELECT DISTINCT DEREF(v.produto).nome "nome produto"
FROM tb_Venda v
WHERE v.desconto > 0.05;

-- consultar produtos que são frutas que foram vendidos mais de 1 vez
SELECT DISTINCT DEREF(v.produto).nome "nome produto"
FROM tb_Venda v
WHERE DEREF(v.produto).tipo = 'Fruta'
    and (SELECT count(*)
        FROM tb_Venda v2
        WHERE DEREF(v2.produto).cod_produto = DEREF(v.produto).cod_produto
        GROUP BY DEREF(v2.produto).cod_produto) > 1;

-- consultar os espacos médios que foram disponibilizados em mais de um turno
SELECT DISTINCT DEREF(d.espaco).cod_espaco "cod_espaco"
FROM tb_Disponibiliza d
WHERE DEREF(d.espaco).tamanho = 'M'
    and (SELECT count(*)
        FROM (SELECT DISTINCT d2.periodo_venda
                FROM tb_Disponibiliza d2
                WHERE DEREF(d2.espaco).cod_espaco = DEREF(d.espaco).cod_espaco)
        	) > 1;

-- consultar todas as vendas de hortaliça  feitas no periodo da tarde
SELECT DISTINCT v.data_hora, DEREF(v.produto).nome,
    DEREF(v.cliente).cpf, DEREF(v.vendedor).cpf, DEREF(v.funcionario).cpf,
    v.desconto, v.quantidade, v.valor_unit, v.valor_total
FROM tb_Venda v
WHERE DEREF(v.produto).tipo = 'Hortaliça'
    and EXTRACT(HOUR FROM v.data_hora) >= 12;

-- consultar todos os clientes que compraram mais que 1 produto
SELECT DISTINCT DEREF(v.cliente).cpf "cpf", DEREF(v.cliente).nome "nome"
FROM tb_Venda v
WHERE (SELECT count(*)
        FROM (SELECT DISTINCT DEREF(v2.produto).cod_produto
                FROM tb_Venda v2
                WHERE DEREF(v2.cliente).cpf = DEREF(v.cliente).cpf)
        ) > 1;

-- consultar quantidade de produtos comprados por cada empresa
SELECT *
FROM (SELECT DEREF(v.cliente).cnpj "cnpj", sum(v.quantidade) "quantidade"
        FROM tb_Venda v
        WHERE DEREF(v.cliente).cnpj IS NOT NULL
        GROUP BY DEREF(v.cliente).cnpj) s;


-- consultar todos os funcionários gerentes que supervisionam um espaço
SELECT DISTINCT DEREF(e.funcionario).nome "nome"
FROM tb_Espaco e
WHERE DEREF(e.funcionario).funcao = 'Gerente';

-- consultar média dos preços dos produtos vendidos em janeiro
SELECT DEREF(v.produto).cod_produto "produto" , AVG(DEREF(v.produto).valor) "valor médio"
FROM tb_Venda v
WHERE EXTRACT(MONTH FROM v.data_hora) = 1
GROUP BY DEREF(v.produto).cod_produto;

-- consultar soma do valor das vendas em 2023 para clientes que não representam uma empresa
SELECT sum(v.valor_total) "receita 2023"
FROM tb_Venda v
WHERE DEREF(v.cliente).cnpj IS NULL
    and EXTRACT(YEAR FROM v.data_hora) = 2023
GROUP BY DEREF(v.cliente).cnpj;

-- consultar todos os assistentes que assistem um vendedor específico
SELECT DISTINCT nome
FROM TABLE(SELECT v.get_Assistentes()
            FROM tb_Vendedor v
            WHERE cpf = '02702912532');

-- consultar um telefone de cada funcionario que ajudou em uma venda
DECLARE
    tel tp_Telefones;
	num varchar2(12);

	CURSOR tels IS 
    SELECT DEREF(f.funcionario).telefones INTO tel
    FROM (SELECT DISTINCT funcionario
        FROM tb_Venda) f
    WHERE DEREF(f.funcionario).telefones IS NOT NULL;
BEGIN
    OPEN tels;
	LOOP
        FETCH tels INTO tel;
        EXIT WHEN tels%NOTFOUND;
		num := tel(1).num_tel;
		dbms_output.put_line(num);
	END LOOP;
END;

-- consultar espaços que foram disponibilizados para uma empresa ordenados por comissão
SELECT DEREF(d.espaco).cod_espaco "cod_espaco", DEREF(d.vendedor).cnpj "empresa"
FROM tb_Disponibiliza d
WHERE DEREF(d.vendedor).cnpj IS NOT NULL
ORDER BY DEREF(d.espaco);

-- consultar cpf e função de todas as pessoas que são funcionários e clientes
SELECT f.cpf, f.funcao
FROM tb_Funcionario f
JOIN tb_Cliente c
ON f.cpf = c.cpf;

-- consultar cpf, cnpj e nome de todos os vendedores que possuem pelo menos dois assistentes
SELECT v.cpf, v.cnpj, v.nome
FROM tb_vendedor v
WHERE (SELECT COUNT(*)
        FROM TABLE(v.telefones)
    ) >= 2; 


-- consultar um telefone dos clientes que compraram pescados
DECLARE
    tel tp_Telefones;
	num varchar2(12);

	CURSOR tels IS 
    SELECT DEREF(v.cliente).telefones INTO tel
    FROM tb_Venda v
    WHERE DEREF(v.produto).tipo = 'Pescado'
    	and DEREF(v.cliente).telefones IS NOT NULL;
BEGIN
    OPEN tels;
	LOOP
        FETCH tels INTO tel;
        EXIT WHEN tels%NOTFOUND;
		num := tel(1).num_tel;
		dbms_output.put_line(num);
	END LOOP;
END;

-- consultar código e tamanho dos espaços disponibilizados para vendedores representantes de empresas
SELECT DISTINCT DEREF(espaco).cod_espaco "código", DEREF(espaco).tamanho "tamanho"
FROM tb_disponibiliza d
WHERE DEREF(d.vendedor).cnpj IS NOT NULL;

-- consultar código do primeiro espaço grande disponibilizado
SELECT DEREF(d.espaco).cod_espaco "código"
FROM tb_disponibiliza d
WHERE DEREF(d.espaco).tamanho = 'G'
ORDER BY d.data_inicio
FETCH FIRST 1 ROW ONLY;

-- consultar nome e quantidade de assistentes de cada vendedor que se registrou antes de 2023
SELECT v.nome, v.cpf, COUNT(*) as quantidade_assistentes
FROM tb_vendedor v, TABLE(v.assistentes) a
WHERE EXTRACT(YEAR FROM v.data_registro) < 2023
GROUP BY v.nome, v.cpf;

-- consultar código do cartão fidelidade dos clientes que não têm telefone
SELECT c.cartao_fidelidade.cod_cartao "código"
FROM tb_cliente c
WHERE (SELECT COUNT(*)
        FROM TABLE(c.telefones)
    ) = 0;

-- consultar o nome de todos os vendedores que utilizam um espaço específico
SELECT DEREF(d.vendedor).nome "vendedor"
FROM tb_Disponibiliza d
WHERE (SELECT REF(e)
        FROM tb_Espaco e
        WHERE e.cod_espaco = 9) = d.espaco;