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
    MAP MEMBER FUNCTION getNome RETURN varchar2
) NOT FINAL NOT INSTANTIABLE;
/
CREATE OR REPLACE TYPE BODY tp_Cadastro AS
    MAP MEMBER FUNCTION getNome RETURN varchar2 IS
            n varchar2(60) := nome;
        BEGIN
            RETURN n;
        END;
END;
/
CREATE OR REPLACE TYPE tp_Pessoa UNDER tp_Cadastro(
    MEMBER PROCEDURE mostraPessoa(SELF tp_Pessoa)
)NOT FINAL;
/
CREATE OR REPLACE TYPE tp_Funcionario UNDER tp_Pessoa(
    data_adm date,
    funcao varchar2(20),
    salario number,
    supervisor REF tp_Funcionario, 
    FINAL MEMBER PROCEDURE set_Salario (new_salario number),
    OVERRIDING MEMBER PROCEDURE mostraPessoa (SELF tp_Funcionario)
)FINAL;
/
CREATE OR REPLACE TYPE BODY tp_Funcionario IS
    FINAL MEMBER PROCEDURE set_salario (new_salario number) IS
        BEGIN
            salario := new_salario;
        END;
    OVERRIDING MEMBER PROCEDURE mostraPessoa(SELF tp_Funcionario) IS
        BEGIN
            dbms_output.put_line('Descrição do Funcionário:');
            dbms_output.put_line('cpf: ' || cpf);
            dbms_output.put_line('nome: ' || nome);
            dbms_output.put_line('função: ' || funcao);
            dbms_output.put_line('salário: ' || to_char(salario));
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
    OVERRIDING MEMBER PROCEDURE mostraPessoa(SELF tp_Vendedor)
)FINAL;
/
ALTER TYPE tp_Assistente ADD ATTRIBUTE
    (vendedor REF tp_vendedor) CASCADE; 
/
CREATE OR REPLACE TYPE BODY tp_Vendedor IS 
    MEMBER FUNCTION get_Assistentes RETURN tp_nt_Assistente IS
        BEGIN
            RETURN assistentes;
        END;
    OVERRIDING MEMBER PROCEDURE mostraPessoa(SELF tp_Vendedor) IS
        BEGIN
            dbms_output.put_line('Descrição do Vendedor:');
            dbms_output.put_line('cpf: ' || cpf);
            dbms_output.put_line('nome: ' || nome);
            dbms_output.put_line('cnpj: ' || nvl(cnpj, 'não informado'));
        END;
END;
/
CREATE OR REPLACE TYPE tp_Cartao_fidelidade AS OBJECT(
    cod_cartao number
)FINAL;
/
CREATE OR REPLACE TYPE tp_Cliente UNDER tp_Pessoa(
    cnpj char(14),
    OVERRIDING MEMBER PROCEDURE mostraPessoa(SELF tp_Cliente)
)FINAL;
/
ALTER TYPE tp_Cliente ADD ATTRIBUTE
    (cartao_fidelidade tp_Cartao_fidelidade) CASCADE; 
/
CREATE OR REPLACE TYPE BODY tp_Cliente IS 
    OVERRIDING MEMBER PROCEDURE mostraPessoa(SELF tp_Cliente) IS
        BEGIN
            dbms_output.put_line('Descrição do Cliente:');
            dbms_output.put_line('cpf: ' || cpf);
            dbms_output.put_line('nome: ' || nome);
            dbms_output.put_line('cnpj: ' || nvl(cnpj, 'não informado'));
        END;
END;
/
CREATE OR REPLACE TYPE tp_Espaco AS OBJECT(
    cod_espaco number,
    tamanho char(1),
    tipo char(1),
    comissao number,
    funcionario REF tp_Funcionario,
    ORDER MEMBER FUNCTION comparaComissao(esp tp_Espaco) RETURN NUMBER,
    MEMBER PROCEDURE get_Vendedor_Manha
)FINAL;
/
CREATE OR REPLACE TYPE BODY tp_Espaco IS 
    ORDER MEMBER FUNCTION comparaComissao(esp tp_Espaco) RETURN NUMBER IS
            c number;
        BEGIN
            c := SELF.comissao - esp.comissao;
            RETURN c;
        END;
    MEMBER PROCEDURE get_Vendedor_Manha IS
            vend_cpf char(11);
        BEGIN
            SELECT DEREF(d.vendedor).cpf INTO vend_cpf
            FROM tb_Disponibiliza d
            WHERE DEREF(d.espaco).cod_espaco = self.cod_espaco
                and d.periodo_venda = 'M';

            dbms_output.put_line(vend_cpf);
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
    produto REF tp_Produto, 
    cliente REF tp_Cliente, 
    vendedor REF tp_Vendedor, 
    funcionario REF tp_Funcionario, 
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
    periodo_venda char(1), 
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

