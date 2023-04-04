-- MAP FUNCTION getNome():
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


-- OVERRIDING MEMBER PROCEDURE mostraPessoa():
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


-- FINAL MEMBER PROCEDURE set_Salario()
DECLARE
	func tp_Funcionario;
BEGIN
	SELECT VALUE(f) INTO func
    FROM tb_Funcionario f
    WHERE f.cpf = '99124502227';

    func.mostraPessoa();
    func.set_Salario(3000);
    dbms_output.put_line('==================');
    func.mostraPessoa();
END;


-- MEMBER FUNCTION get_Assistentes()
SELECT nome FROM TABLE(SELECT v.get_Assistentes()
                        FROM tb_Vendedor v
                        WHERE v.cpf = '02702912532');


-- ORDER MEMBER FUNCTION comparaComissao()
SELECT DEREF(vendedor).cpf, DEREF(espaco).cod_espaco, DEREF(espaco).comissao
FROM tb_Disponibiliza d
ORDER BY DEREF(d.espaco);

-- MEMBER PROCEDURE get_Vendedor_Manha()
DECLARE
    esp tp_Espaco;
BEGIN
    SELECT VALUE(e) INTO esp
    FROM tb_Espaco e
    WHERE e.cod_espaco = 3;

    esp.get_Vendedor_Manha();
END;
