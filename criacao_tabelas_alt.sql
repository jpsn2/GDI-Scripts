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

CREATE TABLE Pessoa (
    cpf_pessoa char(11),
    nome varchar2(60) not null,
    email varchar2(60),
    cep char(8) not null,
    rua varchar2(60),
    numero number,
    complemento varchar2(15),
    constraint pessoa_pk primary key(cpf_pessoa),
    constraint cpf_pessoa_ck check (REGEXP_LIKE(cpf_pessoa, '\d{11}')),
    constraint email_ck check (REGEXP_LIKE(email, '(.+)@(.+)\.(.+)')),
    constraint cep_ck check (REGEXP_LIKE(cep, '\d{8}'))
);

CREATE TABLE Telefones(
    num_tel varchar2(12),
    cpf_pessoa char(11),
    constraint telefones_pk primary key (num_tel, cpf_pessoa),
    constraint num_tel_ck check (REGEXP_LIKE(num_tel, '(\d{2})?(9?\d{8})')),
    constraint cpf_pessoa_tel_ck check (REGEXP_LIKE(cpf_pessoa, '\d{11}')),
    constraint cpf_pessoa_tel_fk foreign key (cpf_pessoa)
        references pessoa(cpf_pessoa)
);

CREATE TABLE Funcionario (
    cpf_funcionario char(11),
    data_adm date not null,
    funcao varchar2(20) not null,
    salario number not null,
    cpf_supervisor char(11),
    constraint salario_ck check (salario >= 0),
    constraint cpf_funcionario_ck check (REGEXP_LIKE(cpf_funcionario, '\d{11}')),
    constraint cpf_supervisor_ck check (REGEXP_LIKE(cpf_supervisor, '\d{11}')),
    constraint funcionario_pk primary key(cpf_funcionario),
    constraint supervisor_fk foreign key(cpf_supervisor)
        references funcionario(cpf_funcionario),
    constraint cpf_pessoa_func_fk foreign key(cpf_funcionario)
        references pessoa(cpf_pessoa)
);

CREATE TABLE Vendedor (
    cpf_vendedor char(11),
    data_registro date not null,
    cnpj char(14),
    constraint vendedor_pk primary key(cpf_vendedor),
    constraint cpf_vendedor_ck check (REGEXP_LIKE(cpf_vendedor, '\d{11}')),
    constraint cnpj_vend_ck check (REGEXP_LIKE(cnpj, '\d{14}')),
    constraint cpf_pessoa_vend_fk foreign key(cpf_vendedor)
        references pessoa(cpf_pessoa)
);

CREATE TABLE Cliente (
    cpf_cliente char(11),
    cnpj char(14),
    constraint cliente_pk primary key(cpf_cliente),
    constraint cpf_cliente_ck check (REGEXP_LIKE(cpf_cliente, '\d{11}')),
    constraint cnpj_cliente_ck check (REGEXP_LIKE(cnpj, '\d{14}')),
    constraint cpf_pessoa_cli_fk foreign key(cpf_cliente)
        references pessoa(cpf_pessoa)
);

CREATE TABLE Espaco (
    cod_espaco number,
    tamanho char(1) not null,
    tipo char(1) not null,
    comissao number not null,
    cpf_funcionario char(11) not null,
    constraint espaco_pk primary key(cod_espaco),
    constraint tamanho_ck check (tamanho in ('P', 'M', 'G')),
    constraint tipo_ck check (tipo in ('B', 'P')),
    constraint comissao_ck check (comissao >= 0),
    constraint cpf_funcionario_esp_ck check (REGEXP_LIKE(cpf_funcionario, '\d{11}')),
    constraint funcionario_esp_fk foreign key(cpf_funcionario)
        references Funcionario(cpf_funcionario)
);

CREATE TABLE Produto (
    cod_produto number,
    valor number not null,
    tipo varchar2(25),
    nome varchar2(50) not null,
    constraint cod_produto_pk primary key(cod_produto),
    constraint valor_ck check (valor >= 0)
);

CREATE TABLE Assistente (
    cpf_vendedor char(11),
    nome varchar2(60),
    constraint assistente_pk primary key (cpf_vendedor, nome),
    constraint cpf_vendedor_ass_ck check (REGEXP_LIKE(cpf_vendedor, '\d{11}')),
    constraint cpf_vendedor_assist_fk foreign key (cpf_vendedor)
        references vendedor(cpf_vendedor)
);

CREATE TABLE Cartao_fidelidade (
    cpf_cliente char(11),
    cod_cartao number,
    constraint cartao_fid_pk primary key (cpf_cliente, cod_cartao),
    constraint cpf_cliente_cart_ck check (REGEXP_LIKE(cpf_cliente, '\d{11}')),
    constraint cpf_cliente_cart_fk foreign key (cpf_cliente)
        references cliente(cpf_cliente)
);

CREATE TABLE Venda (
    data_hora timestamp,
    cod_produto number,
    cpf_cliente char(11),
    cpf_vendedor char(11),
    cpf_funcionario char(11),
    desconto number,
    quantidade number not null,
    valor_unit number not null,
    valor_total number,
    constraint venda_pk primary key (data_hora, cod_produto, cpf_cliente, cpf_vendedor),
    constraint desconto_ck check (desconto BETWEEN 0 and 1),
    constraint quantidade_ck check (quantidade > 0),
    constraint valor_unit_ck check (valor_unit >= 0),
    constraint valor_total_ck check (valor_total = (quantidade * valor_unit) * (1 - desconto) ),
    constraint cpf_cliente_venda_ck check (REGEXP_LIKE(cpf_cliente, '\d{11}')),
    constraint cpf_func_venda_ck check (REGEXP_LIKE(cpf_funcionario, '\d{11}')),
    constraint cpf_vendedor_venda_ck check (REGEXP_LIKE(cpf_vendedor, '\d{11}')),
    constraint cod_produto_venda_fk foreign key (cod_produto)
        references produto(cod_produto),
    constraint cpf_cliente_venda_fk foreign key (cpf_cliente)
        references cliente(cpf_cliente),
    constraint cpf_vendedor_venda_fk foreign key (cpf_vendedor)
        references vendedor(cpf_vendedor),
    constraint cpf_funcionario_venda_fk foreign key (cpf_funcionario)
        references funcionario(cpf_funcionario)
);

CREATE TABLE Disponibiliza (
    cpf_vendedor char(11),
    cpf_funcionario char(11),
    cod_espaco number,
    hora_inicio number not null,
    hora_fim number not null,
    data_inicio date not null,
    data_fim date not null,
    constraint disponibiliza_pk primary key (cpf_vendedor, cpf_funcionario, cod_espaco),
    constraint hora_inicio_ck check (hora_inicio BETWEEN 0 and 23),
    constraint hora_fim_ck check (hora_fim BETWEEN 0 and 23),
    constraint data_fim_ck check (data_fim >= data_inicio),
    constraint cpf_vendedor_disp_ck check (REGEXP_LIKE(cpf_vendedor, '\d{11}')),
    constraint cpf_func_disp_ck check (REGEXP_LIKE(cpf_funcionario, '\d{11}')),
    constraint cpf_vendedor_disp_fk foreign key (cpf_vendedor)
        references vendedor(cpf_vendedor),
    constraint cpf_funcionario_disp_fk foreign key (cpf_funcionario)
        references funcionario(cpf_funcionario),
    constraint cod_espaco_disp_fk foreign key (cod_espaco)
        references espaco(cod_espaco)
);