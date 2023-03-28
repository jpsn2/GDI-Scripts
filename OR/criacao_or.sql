ALTER SESSION SET NLS_DATE_FORMAT = 'DD-MM-YYYY';
ALTER SESSION SET NLS_TIMESTAMP_FORMAT = 'DD-MM-YYYY HH24-MI-SS';

DROP TABLE Telefones;
DROP TABLE Assistente;
DROP TABLE Cartao_Fidelidade;
DROP TABLE Venda;
DROP TABLE Disponibiliza;
DROP TABLE Vendedor;
DROP TABLE Cliente;
DROP TABLE Espaco;
DROP TABLE Produto;
DROP TABLE Funcionario;
DROP TABLE Pessoa;

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
    complemento varchar2(15)
)FINAL;
/
CREATE OR REPLACE TYPE tp_Pessoa AS OBJECT(
    cpf char(11),
    nome varchar2(60),
    email varchar2(60),
    endereco tp_Endereco,
    telefones tp_Telefones,
    MEMBER PROCEDURE mostraPessoa,
    MAP MEMBER FUNCTION get_Cep RETURN char
)NOT FINAL NOT INSTANTIABLE;
/
CREATE OR REPLACE TYPE BODY tp_Pessoa AS
    MAP MEMBER FUNCTION get_Cep RETURN char(8) IS
        BEGIN
            RETURN endereco.cep;
        END;
END;
/
CREATE OR REPLACE TYPE tp_Funcionario UNDER tp_Pessoa(
    data_adm date,
    funcao varchar2(20),
    salario number,
    supervisor REF tp_Funcionario, --*minimundo
    FINAL MEMBER PROCEDURE set_Salario (new_salario number),
    CONSTRUCTOR FUNCTION tp_Funcionario (p tp_Pessoa, dat Date, fun varchar2, sal number, super REF tp_Funcionario) RETURN SELF AS RESULT,
    OVERRIDING MEMBER PROCEDURE mostraPessoa
)FINAL;
/
CREATE OR REPLACE TYPE BODY tp_Funcionario AS
    CONSTRUCTOR FUNCTION tp_Funcionario (p tp_Pessoa, dat Date, fun varchar2(20), sal number, super REF tp_Funcionario) RETURN SELF AS RESULT IS
        BEGIN
            cpf: = p.cpf; nome := p.nome; email := p.email; endereco := p.endereco; telefones := p.telefones;
            data_adm := dat;
            funcao := fun;
            salario := sal;
            supervisor := super;
            RETURN;
        END;
    FINAL MEMBER PROCEDURE set_salario (new_salario number) IS
        BEGIN
            salario := new_salario;
        END;
    OVERRIDING MEMBER PROCEDURE mostraPessoa IS
        BEGIN
            dbms_output.put_line('Descrição do Funcionário:');
            dbms_output.put_line('cpf: ' || cpf);
            dbms_output.put_line('nome: ' || nome);
            dbms_output.put_line('email: ' || email);
            dbms_output.put_line('endereço: ' || endereco.rua || ', ' || endereco.numero);
            dbms_output.put_line('data de admissão: ' || to_char(data_adm));
            dbms_output.put_line('função: ' || funcao);
            dbms_output.put_line('salário: ' || salario);
            dbms_output.put_line('cpf supervisor: ' || supervisor.cpf);
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
    CONSTRUCTOR FUNCTION tp_Vendedor (p tp_Pessoa, dat date, cnpj_v varchar2, assist tp_nt_Assistente) RETURN SELF AS RESULT,
    MEMBER FUNCTION get_Assistentes RETURN tp_nt_Assistente,
    OVERRIDING MEMBER PROCEDURE mostraPessoa
)FINAL;
/
ALTER TYPE tp_Assistente ADD ATTRIBUTE
    (vendedor REF tp_vendedor) CASCADE; --*minimundo
/
CREATE OR REPLACE TYPE BODY tp_Vendedor AS 
    CONSTRUCTOR FUNCTION tp_Vendedor (p tp_Pessoa, dat date, cnpj_v varchar2(14), assist tp_nt_Assistente) RETURN SELF AS RESULT IS
        BEGIN
            cpf: = p.cpf; nome := p.nome; email := p.email; endereco := p.endereco; telefones := p.telefones;
            data_registro := dat;
            cnpj := cnpj_v;
            assistentes := assist;
            RETURN;
        END;
    MEMBER FUNCTION get_Assistentes RETURN tp_nt_Assistente IS
        BEGIN
            RETURN assistentes;
        END;
    OVERRIDING MEMBER PROCEDURE mostraPessoa IS
        BEGIN
            dbms_output.put_line('Descrição do Funcionário:');
            dbms_output.put_line('cpf: ' || cpf);
            dbms_output.put_line('nome: ' || nome);
            dbms_output.put_line('email: ' || email);
            dbms_output.put_line('endereço: ' || endereco.rua || ', ' || endereco.numero);
            dbms_output.put_line('data de registro: ' || to_char(data_registro));
            dbms_output.put_line('cnpj: ' || cnpj);
        END;
END;
/
CREATE OR REPLACE TYPE tp_Cartao_fidelidade AS OBJECT(
    cod_cartao number
)FINAL;
/
CREATE OR REPLACE TYPE tp_Cliente UNDER tp_Pessoa(
    cnpj char(14),
    cartao_fidelidade tp_Cartao_fidelidade,
    CONSTRUCTOR FUNCTION tp_Cliente (p tp_Pessoa, cnpj_c varchar2, cart tp_Cartao_fidelidade) RETURN SELF AS RESULT,
    OVERRIDING MEMBER PROCEDURE mostraPessoa
)FINAL;
/
ALTER TYPE tp_Cartao_fidelidade ADD ATTRIBUTE
    (cliente REF tp_Cliente) CASCADE; --*minimundo
/
CREATE OR REPLACE TYPE BODY tp_Cliente AS 
    CONSTRUCTOR FUNCTION tp_Cliente (p tp_Pessoa, cnpj_c varchar2(14), cart tp_Cartao_fidelidade) RETURN SELF AS RESULT IS
        BEGIN
            cpf: = p.cpf; nome := p.nome; email := p.email; endereco := p.endereco; telefones := p.telefones;
            cnpj := cnpj_c;
            cartao_fidelidade := cart;
            RETURN;
        END;
    OVERRIDING MEMBER PROCEDURE mostraPessoa IS
        BEGIN
            dbms_output.put_line('Descrição do Funcionário:');
            dbms_output.put_line('cpf: ' || cpf);
            dbms_output.put_line('nome: ' || nome);
            dbms_output.put_line('email: ' || email);
            dbms_output.put_line('endereço: ' || endereco.rua || ', ' || endereco.numero);
            dbms_output.put_line('cartao fidelidade: ' || cartao_fidelidade.cod_cartao);
            dbms_output.put_line('cnpj: ' || cnpj);
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
    ORDER MEMBER FUNCTION comparaTamanho(esp tp_Espaco) RETURN NUMBER
)FINAL;
/
CREATE OR REPLACE TYPE BODY tp_Espaco AS 
    CONSTRUCTOR FUNCTION tp_Espaco (cod number, tam char(1), tipo char(1), com number, func tp_Funcionario) RETURN SELF AS RESULT IS
        BEGIN
            cod_espaco := cod
            tamanho := tam;
            tipo := tipo;
            cnpj := cnpj;
            cnpj := cnpj;
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
    periodo char(1), --*minimundo
    data_inicio date,
    data_fim date
)FINAL;
/

--------------------- criação de tabelas

CREATE TABLE tb_Funcionario OF tp_Funcionario (
    cpf primary key,
    supervisor SCOPE IS tb_Funcionario,
    constraint salario_ck check (salario >= 0),
    constraint cpf_func_ck check (REGEXP_LIKE(cpf, '\d{11}')),
    constraint email_func_ck check (REGEXP_LIKE(email, '(.+)@(.+)\.(.+)')),
    constraint cep_func_ck check (REGEXP_LIKE(endereco.cep, '\d{8}'))
);

CREATE TABLE tb_Vendedor OF tp_Vendedor (
    cpf primary key,
    constraint cpf_vend_ck check (REGEXP_LIKE(cpf, '\d{11}')),
    constraint cnpj_vend_ck check (REGEXP_LIKE(cnpj, '\d{14}')),
    constraint email_vend_ck check (REGEXP_LIKE(email, '(.+)@(.+)\.(.+)')),
    constraint cep_vend_ck check (REGEXP_LIKE(endereco.cep, '\d{8}'))
) NESTED TABLE assistentes STORE AS tb_Assistentes;

CREATE TABLE tb_Cliente OF tp_Cliente (
    cpf primary key,
    constraint cpf_cliente_ck check (REGEXP_LIKE(cpf, '\d{11}')),
    constraint cnpj_cliente_ck check (REGEXP_LIKE(cnpj, '\d{14}')),
    constraint email_cliente_ck check (REGEXP_LIKE(email, '(.+)@(.+)\.(.+)')),
    constraint cep_cliente_ck check (REGEXP_LIKE(endereco.cep, '\d{8}'))
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
    constraint periodo_ck check (periodo in ('M','T','N')),
    constraint data_fim_ck check (data_fim >= data_inicio)
);

