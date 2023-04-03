ALTER SESSION SET NLS_DATE_FORMAT = 'DD-MM-YYYY';
ALTER SESSION SET NLS_TIMESTAMP_FORMAT = 'DD-MM-YYYY HH24-MI-SS';

DROP TABLE tb_Venda;
DROP TABLE tb_Disponibiliza;
DROP TABLE tb_Vendedor;
DROP TABLE tb_Cliente;
DROP TABLE tb_Espaco;
DROP TABLE tb_Produto;
DROP TABLE tb_Funcionario;
DROP TABLE tb_Endereco;

--------------------- criação de tipos

CREATE OR REPLACE TYPE tp_Telefone AS OBJECT(
    num_tel varchar2(12)
)FINAL;
/
CREATE OR REPLACE TYPE tp_Telefones AS VARRAY(10) of tp_Telefone;
/
CREATE OR REPLACE TYPE tp_Endereco AS OBJECT(
    cep char(8),
    rua varchar2(60),
    numero number,
    complemento varchar2(15),
    CONSTRUCTOR FUNCTION tp_Endereco(cep varchar2, rua varchar2) RETURN SELF AS RESULT,
    CONSTRUCTOR FUNCTION tp_Endereco(cep varchar2, rua varchar2, numero number) RETURN SELF AS RESULT,
    CONSTRUCTOR FUNCTION tp_Endereco(cep varchar2, rua varchar2, comp varchar2) RETURN SELF AS RESULT
)FINAL;
/
CREATE OR REPLACE TYPE BODY tp_Endereco IS
    CONSTRUCTOR FUNCTION tp_Endereco(cep varchar2, rua varchar2) RETURN SELF AS RESULT IS
        BEGIN
            SELF.cep := cep;
            SELF.rua := rua;
            RETURN;
        END;
    CONSTRUCTOR FUNCTION tp_Endereco(cep varchar2, rua varchar2, numero number) RETURN SELF AS RESULT IS
        BEGIN
            SELF.cep := cep;
            SELF.rua := rua;
            SELF.numero := numero;
            RETURN;
        END;
    CONSTRUCTOR FUNCTION tp_Endereco(cep varchar2, rua varchar2, comp varchar2) RETURN SELF AS RESULT IS
        BEGIN
            SELF.cep := cep;
            SELF.rua := rua;
            SELF.complemento := comp;
            RETURN;
        END;
END;
/
CREATE OR REPLACE TYPE tp_Cadastro AS OBJECT(
    cpf char(11),
    nome varchar2(60),
    email varchar2(60),
    endereco REF tp_Endereco,
    telefones tp_Telefones,
    MAP MEMBER FUNCTION get_Cep RETURN char
) NOT FINAL NOT INSTANTIABLE;
/
CREATE OR REPLACE TYPE BODY tp_Cadastro AS
    MAP MEMBER FUNCTION get_Cep RETURN varchar2 IS
        BEGIN
            RETURN endereco.cep;
        END;
END;
/
CREATE OR REPLACE TYPE tp_Pessoa UNDER tp_Cadastro(
    MEMBER PROCEDURE mostraPessoa
)NOT FINAL;
/
CREATE OR REPLACE TYPE tp_Funcionario UNDER tp_Pessoa(
    data_adm date,
    funcao varchar2(20),
    salario number,
    supervisor REF tp_Funcionario, --*minimundo
    FINAL MEMBER PROCEDURE set_Salario (new_salario number),
    OVERRIDING MEMBER PROCEDURE mostraPessoa
)FINAL;
/
CREATE OR REPLACE TYPE BODY tp_Funcionario IS
    FINAL MEMBER PROCEDURE set_salario (new_salario number) IS
        BEGIN
            salario := new_salario;
        END;
    OVERRIDING MEMBER PROCEDURE mostraPessoa IS
        BEGIN
            dbms_output.put_line('Descrição do Funcionário:');
            dbms_output.put_line('cpf: ' || cpf);
            dbms_output.put_line('nome: ' || nvl(nome, nome, 'não informado'));
            dbms_output.put_line('email: ' || nvl(email, email, 'não informado'));
            dbms_output.put_line('endereço: ' || 
                nvl(endereco, endereco.rua, 'não informado') || ', ' ||
                nvl(endereco, endereco.numero, ''));
            dbms_output.put_line('data de admissão: ' ||
                nvl(data_adm, to_char(data_adm), 'não informado'));
            dbms_output.put_line('função: ' || nvl(funcao, funcao, 'não informado'));
            dbms_output.put_line('salário: ' || nvl(salario, salario, 'não informado'));
            dbms_output.put_line('cpf supervisor: ' ||
                nvl(supervisor, supervisor.cpf, 'não informado'));
        END;
END;
/
CREATE OR REPLACE TYPE tp_Assistente AS OBJECT(
    nome varchar2(60)
)FINAL;
/
CREATE OR REPLACE TYPE tp_nt_Assistente AS TABLE OF tp_Assistente;
/
CREATE OR REPLACE TYPE tp_Vendedor UNDER tp_Pessoa(
    data_registro date,
    cnpj char(14),
    assistentes tp_nt_Assistente,
    MEMBER FUNCTION get_Assistentes RETURN tp_nt_Assistente,
    OVERRIDING MEMBER PROCEDURE mostraPessoa
)FINAL;
/
ALTER TYPE tp_Assistente ADD ATTRIBUTE
    (vendedor REF tp_vendedor) CASCADE; --*minimundo
/
CREATE OR REPLACE TYPE BODY tp_Vendedor IS 
    MEMBER FUNCTION get_Assistentes RETURN tp_nt_Assistente IS
        BEGIN
            RETURN assistentes;
        END;
    OVERRIDING MEMBER PROCEDURE mostraPessoa IS
        BEGIN
            dbms_output.put_line('Descrição do Vendedor:');
            dbms_output.put_line('cpf: ' || cpf);
            dbms_output.put_line('nome: ' || nvl(nome, nome, 'não informado'));
            dbms_output.put_line('email: ' || nvl(email, email, 'não informado'));
            dbms_output.put_line('endereço: ' ||
                nvl(endereco, endereco.rua, 'não informado') || ', ' ||
                nvl(endereco, endereco.numero, 'não informado'));
            dbms_output.put_line('data de registro: ' ||
                nvl(data_registro, to_char(data_registro), 'não informado'));
            dbms_output.put_line('cnpj: ' || nvl(cnpj, cnpj, 'não informado'));
        END;
END;
/
CREATE OR REPLACE TYPE tp_Cartao_fidelidade AS OBJECT(
    cod_cartao number
)FINAL;
/
CREATE OR REPLACE TYPE tp_Cliente UNDER tp_Pessoa(
    cnpj char(14),
    OVERRIDING MEMBER PROCEDURE mostraPessoa
)FINAL;
/
ALTER TYPE tp_Cliente ADD ATTRIBUTE
    (cartao_fidelidade tp_Cartao_fidelidade) CASCADE; --*minimundo
/
CREATE OR REPLACE TYPE BODY tp_Cliente IS 
    OVERRIDING MEMBER PROCEDURE mostraPessoa IS
        BEGIN
            dbms_output.put_line('Descrição do Cliente:');
            dbms_output.put_line('cpf: ' || cpf);
            dbms_output.put_line('nome: ' || nvl(nome, nome, 'não informado'));
            dbms_output.put_line('email: ' || nvl(email, email, 'não informado'));
            dbms_output.put_line('endereço: ' ||
                nvl(endereco, endereco.rua, 'não informado') || ', ' ||
                nvl(endereco, endereco.numero, 'não informado'));
            dbms_output.put_line('cartao fidelidade: ' ||
                nvl(cartao_fidelidade, cartao_fidelidade.cod_cartao, 'não informado'));
            dbms_output.put_line('cnpj: ' || nvl(cnpj, cnpj, 'não informado'));
        END;
END;
/
CREATE OR REPLACE TYPE tp_Espaco AS OBJECT(
    cod_espaco number,
    tamanho char(1),
    tipo char(1),
    comissao number,
    funcionario REF tp_Funcionario,
    CONSTRUCTOR FUNCTION tp_Espaco (cod number, tam char, tipo char, com number, func tp_Funcionario) RETURN SELF AS RESULT,
    ORDER MEMBER FUNCTION comparaTamanho(esp tp_Espaco) RETURN NUMBER,
    MEMBER FUNCTION get_Vendedor_Manha RETURN tp_Vendedor
)FINAL;
/
CREATE OR REPLACE TYPE BODY tp_Espaco IS 
    CONSTRUCTOR FUNCTION tp_Espaco (cod number, tam char(1), tipo char(1), com number, func tp_Funcionario) RETURN SELF AS RESULT IS
        BEGIN
            cod_espaco := cod
            tamanho := tam;
            tipo := tipo;
            comissao := com;
            funcionario := func;
            RETURN;
        END;
    ORDER MEMBER FUNCTION comparaTamanho(esp tp_Espaco) RETURN NUMBER IS
        BEGIN
            IF tamanho < esp.tamanho THEN
                RETURN -1;
            ELSE IF tamanho = esp.tamanho THEN
                RETURN 0;
            ELSE THEN
                RETURN 1;
            END IF; 
        END;
    MEMBER FUNCTION get_Vendedor_Manha RETURN tp_Vendedor IS
            vend tp_Vendedor;
        BEGIN
            SELECT VALUE(d.vendedor) INTO vend
            FROM tb_Disponibiliza d
            WHERE DEREF(d.espaco).cod_espaco = self.cod_espaco
                and d.periodo_venda = 'M';

            RETURN vend;
        END;
END;
/
CREATE OR REPLACE TYPE tp_Produto AS OBJECT(
    cod_produto number,
    valor number,
    tipo varchar2(25),
    nome varchar2(50)
)FINAL;
/
CREATE OR REPLACE TYPE tp_Venda AS OBJECT(
    data_hora timestamp,
    produto REF tp_Produto, --*minimundo
    cliente REF tp_Cliente, --*minimundo
    vendedor REF tp_Vendedor, --*minimundo
    funcionario REF tp_Funcionario, --*minimundo
    desconto number,
    quantidade number,
    valor_unit number,
    valor_total number
)FINAL;
/
CREATE OR REPLACE TYPE tp_Disponibiliza AS OBJECT(
    vendedor REF tp_Vendedor,
    funcionario REF tp_Funcionario,
    espaco REF tp_Espaco,
    periodo_venda char(1), --*minimundo
    data_inicio date,
    data_fim date
)FINAL;
/

--------------------- criação de tabelas

CREATE TABLE tb_Endereco OF tp_Endereco(
    cep primary key,
    constraint cep_cliente_ck check (REGEXP_LIKE(cep, '\d{8}'))
);

CREATE TABLE tb_Funcionario OF tp_Funcionario (
    cpf primary key,
    supervisor SCOPE IS tb_Funcionario,
    endereco WITH ROWID REFERENCES tb_Endereco,
    constraint salario_ck check (salario >= 0),
    constraint cpf_func_ck check (REGEXP_LIKE(cpf, '\d{11}')),
    constraint email_func_ck check (REGEXP_LIKE(email, '(.+)@(.+)\.(.+)'))
);

CREATE TABLE tb_Vendedor OF tp_Vendedor (
    cpf primary key,
    constraint cpf_vend_ck check (REGEXP_LIKE(cpf, '\d{11}')),
    constraint cnpj_vend_ck check (REGEXP_LIKE(cnpj, '\d{14}')),
    constraint email_vend_ck check (REGEXP_LIKE(email, '(.+)@(.+)\.(.+)'))
) NESTED TABLE assistentes STORE AS tb_Assistentes;

CREATE TABLE tb_Cliente OF tp_Cliente (
    cpf primary key,
    constraint cpf_cliente_ck check (REGEXP_LIKE(cpf, '\d{11}')),
    constraint cnpj_cliente_ck check (REGEXP_LIKE(cnpj, '\d{14}')),
    constraint email_cliente_ck check (REGEXP_LIKE(email, '(.+)@(.+)\.(.+)'))
);

CREATE TABLE tb_Espaco OF tp_Espaco (
    cod_espaco primary key,
    funcionario WITH ROWID REFERENCES tb_Funcionario,
    constraint tamanho_ck check (tamanho in ('P', 'M', 'G')),
    constraint tipo_ck check (tipo in ('B', 'P')),
    constraint comissao_ck check (comissao >= 0)
);

CREATE TABLE tb_Produto OF tp_Produto (
    cod_produto primary key,
    constraint valor_produto_ck check (valor >= 0)
);

CREATE TABLE tb_Venda OF tp_Venda (
    data_hora primary key,
    produto WITH ROWID REFERENCES tb_Produto,
    cliente WITH ROWID REFERENCES tb_Cliente,
    vendedor WITH ROWID REFERENCES tb_Vendedor,
    funcionario WITH ROWID REFERENCES tb_Funcionario,
    constraint desconto_ck check (desconto BETWEEN 0 and 1),
    constraint quantidade_ck check (quantidade > 0),
    constraint valor_unit_ck check (valor_unit >= 0),
    constraint valor_total_ck check (valor_total = (quantidade * valor_unit) * (1 - desconto) )
);

CREATE TABLE tb_Disponibiliza OF tp_Disponibiliza (
    vendedor WITH ROWID REFERENCES tb_Vendedor,
    funcionario WITH ROWID REFERENCES tb_Funcionario,
    espaco WITH ROWID REFERENCES tb_Espaco,
    constraint periodo_ck check (periodo_venda in ('M','T','N')),
    constraint data_fim_ck check (data_fim >= data_inicio)
);

