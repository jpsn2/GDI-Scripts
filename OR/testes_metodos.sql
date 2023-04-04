-- getNome():
    -- funcionario
SELECT cpf, nome
FROM tb_Funcionario f
ORDER BY f.getNome();

    -- vendedor
SELECT cpf, nome
FROM tb_Vendedor v
ORDER BY v.getNome();

    -- cliente
SELECT cpf, nome
FROM tb_Cliente c
ORDER BY c.getNome();


-- mostraPessoa():
    -- funcionario
DECLARE
	func tp_Funcionario;
BEGIN
	SELECT VALUE(f) INTO func
    FROM tb_Funcionario f
    WHERE f.cpf = '99124502227';

    func.mostraPessoa();
END;


    -- vendedor
DECLARE
	vend tp_Vendedor;
BEGIN
	SELECT VALUE(v) INTO vend
    FROM tb_Vendedor v
    WHERE v.cpf = '72610547200';

    vend.mostraPessoa();
END;

    -- cliente
DECLARE
	cli tp_Cliente;
BEGIN
	SELECT VALUE(c) INTO cli
    FROM tb_Cliente c
    WHERE c.cpf = '26348686850';

    cli.mostraPessoa();
END;


-- set_Salario()
DECLARE
	func tp_Funcionario;
BEGIN
	SELECT VALUE(f) INTO func
    FROM tb_Funcionario f
    WHERE f.cpf = '99124502227';

    func.mostraPessoa();
    func.set_Salario(3000);
    func.mostraPessoa();
END;


-- get_Assistentes()
SELECT nome FROM TABLE(SELECT v.get_Assistentes()
                        FROM tb_Vendedor v
                        WHERE v.cpf = '02702912532');


-- comparaComissao()
DECLARE
    esp1 tp_Espaco;
    esp2 tp_Espaco;
    comp_esp number;
BEGIN
    SELECT VALUE(e) INTO esp1
    FROM tb_Espaco e
    WHERE cod_espaco = 1; -- comissao = 11

    SELECT VALUE(e) INTO esp2
    FROM tb_Espaco e
    WHERE cod_espaco = 5; -- comissao = 14

    comp_esp := esp1.comparaComissao(esp2);

    IF comp_esp < 0 THEN
        dbms_output.put_line('O espaco ' || to_char(esp1.cod_espaco) ||
            'e mais barato que o espaco ' || to_char(esp2.cod_espaco));
    ELSIF comp_esp > 0 THEN
        dbms_output.put_line('O espaco ' || to_char(esp1.cod_espaco) ||
            'e mais caro o espaco ' || to_char(esp2.cod_espaco));
    ELSE
        dbms_output.put_line('O espaco ' || to_char(esp1.cod_espaco) ||
            'tem o mesmo valor que o espaco ' || to_char(esp2.cod_espaco));
    END IF;
END;


-- get_Vendedor_Manha()
DECLARE

BEGIN

END;
