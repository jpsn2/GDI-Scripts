DROP SEQUENCE cod_prod;
DROP SEQUENCE cod_esp;
DROP SEQUENCE cod_fid;

-- criação de sequências
CREATE SEQUENCE cod_prod
    MINVALUE 0
    START WITH 0
    INCREMENT BY 1;
    
CREATE SEQUENCE cod_esp
    MINVALUE 0
    START WITH 0
    INCREMENT BY 1;
    
CREATE SEQUENCE cod_fid
    MINVALUE 0
    START WITH 0
    INCREMENT BY 1;
    
-- inserção na tabela pessoa

INSERT INTO pessoa(cpf_pessoa, nome, email, cep, rua, numero, complemento)
    VALUES ('58235053454', 'Amanda Caldeira', 'ac123@gmail.com', '49038420', 'Rua Orlando Sobral dos Santos', 45, 'Casa');
INSERT INTO pessoa(cpf_pessoa, nome, email, cep, rua, numero, complemento)
    VALUES ('44882211491', 'Miguel Alves', 'ma356@outlook.com', '29090820', 'Rua Victorino Cardoso', 2, 'Casa');
INSERT INTO pessoa(cpf_pessoa, nome, email, cep, rua, numero)
    VALUES ('17267832946', 'Ana Vitória Vieira', 'avc259@gmail.com', '78120786', 'Travessa do Nenê', 156);
INSERT INTO pessoa(cpf_pessoa, nome, email, cep, rua, numero, complemento)
    VALUES ('72610547200', 'Pedro Lucas Barbosa', 'plb2526@yahoo.com.br', '49087423', 'Rua B', 43, 'Casa');
INSERT INTO pessoa(cpf_pessoa, nome, email, cep, rua, complemento)
    VALUES ('64784744290', 'João Nascimento', 'jn2@gmail.com', '21511110', 'Rua Gentil de Almeida', 'apt. 21');
INSERT INTO pessoa(cpf_pessoa, nome, email, cep, rua, numero)
    VALUES ('02702912532', 'Calebe Ferreira', 'cf9485@hotmail.com', '88702446', 'Rua Caminho da Luz', 167);
INSERT INTO pessoa(cpf_pessoa, nome, email, cep, rua, numero, complemento)
    VALUES ('21542193818', 'Eduardo Cardoso', 'ec3333@gmail.com', '94828106', 'Rua C', 5, 'Casa');
INSERT INTO pessoa(cpf_pessoa, nome, email, cep, rua, numero, complemento)
    VALUES ('85449302711', 'Marcelo Rocha', 'mrq45@gmail.com', '26062420', 'Rua Américo Vespúcio', 48, 'apt. 05');
INSERT INTO pessoa(cpf_pessoa, nome, email, cep, rua, numero, complemento)
    VALUES ('26348686850', 'Kamilly Aragão', 'kafd56367@outlook.com', '26060370', 'Rua Dona Eulália', 145, 'Casa');
INSERT INTO pessoa(cpf_pessoa, nome, email, cep, rua, numero)
    VALUES ('37521229517', 'Luana Melo', 'lm@cin.ufpe.br', '84036145', 'Rua Joaquim Jurandir Collares', 202);
INSERT INTO pessoa(cpf_pessoa, nome, email, cep, rua, numero, complemento)
    VALUES ('23238276344', 'Ana Júlia das Neves', 'ajdn0935@gmail.com', '58058340', 'Rua Irene Alves P. Celani', 32, 'apt. 103');
INSERT INTO pessoa(cpf_pessoa, nome, email, cep, rua, numero, complemento)
    VALUES ('48174058303', 'Antônio Cardoso', 'ac53h@gmail.com', '49009073', 'Rua José Domingos Maia III', 21, 'apt. 304');
INSERT INTO pessoa(cpf_pessoa, nome, email, cep, rua, numero)
    VALUES ('11467512060', 'Larissa Moura', 'lm@yahoo.com.br', '64088510', 'Rua Pindaíba', 78);
INSERT INTO pessoa(cpf_pessoa, nome, email, cep, rua, numero, complemento)
    VALUES ('31109286635', 'Renan Silveira', 'rsj32j@gmail.com', '64001010', 'Avenida Maranhão', 65, 'apt. 708');
INSERT INTO pessoa(cpf_pessoa, nome, email, cep, rua, numero, complemento)
    VALUES ('24366201640', 'Kevin Almeida', 'ka4325@gmail.com', '78132808', 'Avenida Leoncio Lopes de Miranda', 978, 'apt. 501');
INSERT INTO pessoa(cpf_pessoa, nome, email, cep, rua, numero, complemento)
    VALUES ('25666674978', 'Carolina Duarte', 'cd87875672678@gmail.com', '78725030', 'Rua General de Marcos', 5, 'Casa');
INSERT INTO pessoa(cpf_pessoa, nome, email, cep, rua, numero, complemento)
    VALUES ('75708608706', 'Pedro Lucas Martins', 'plm24243f@gmail.com', '79100290', 'Rua da Promissão', 465, 'Casa');
INSERT INTO pessoa(cpf_pessoa, nome, email, cep, rua, numero, complemento)
    VALUES ('36481215706', 'Letícia da Cunha', 'ldc435@gmail.com', '64016745', 'Rua Doutor Area Leão', 307, 'Casa');
INSERT INTO pessoa(cpf_pessoa, nome, email, cep, rua, numero, complemento)
    VALUES ('38540174804', 'Bruna Monteiro', 'bmdsaf24@outlook.com', '54080420', 'Rua Marechal Deodoro da Fonsêca', 30, 'apt. 101');
INSERT INTO pessoa(cpf_pessoa, nome, email, cep, rua, numero, complemento)
    VALUES ('29586233197', 'Manuela Caldeira', 'mc432659@outlook.com', '76801198', 'Rua Hebert de Azevedo', 20, 'apt. 105');
INSERT INTO pessoa(cpf_pessoa, nome, email, cep, rua, numero)
    VALUES ('41582782792', 'Alice Jesus', 'aj2463@gmail.com', '65630970', 'Rua Magalhães de Almeida', 98);
INSERT INTO pessoa(cpf_pessoa, nome, email, cep, rua, numero, complemento)
    VALUES ('25455186892', 'Luiz Felipe da Costa', 'lfdc@hotmail.com', '78552105', 'Rua das Canelas', 60, 'Casa');
INSERT INTO pessoa(cpf_pessoa, nome, email, cep, rua)
    VALUES ('89987766420', 'Helena Barbosa', 'hb245@gmail.com', '79114200', 'Rua Oswaldo Goeld');
INSERT INTO pessoa(cpf_pessoa, nome, email, cep, rua, numero, complemento)
    VALUES ('18041727662', 'Thales Nogueira', 'tn90825@gmail.com', '76913744', 'Rua Santa Clara', 73, 'Casa');
INSERT INTO pessoa(cpf_pessoa, nome, email, cep, rua, numero, complemento)
    VALUES ('70775502227', 'Carolina das Neves', 'cdn09872435@gmail.com', '69039080', 'Rua Herdeiro do Rei', 75, 'apt. 104');
INSERT INTO pessoa(cpf_pessoa, nome, email, cep, rua, numero, complemento)
    VALUES ('07262636308', 'Vitor Hugo Caldeira', 'vhc278679375@gmail.com', '84051010', 'Rua Braulina Carneiro de Quadros', 78, 'apt. 606');
INSERT INTO pessoa(cpf_pessoa, nome, email, cep, rua, complemento)
    VALUES ('86385882594', 'Vicente Rocha', 'vr5555@yahoo.com.br', '69313405', 'Rua Raimunda Mendes de Almeida', 'apt. 102');
INSERT INTO pessoa(cpf_pessoa, nome, email, cep, rua, numero, complemento)
    VALUES ('62704882819', 'Noah Alves', 'nha256@gmail.com', '68906091', 'Rua Santa Tereza', 830, 'Casa');
INSERT INTO pessoa(cpf_pessoa, nome, email, cep, rua, complemento)
    VALUES ('06661573325', 'Arthur Nogueira', 'athn776543999@gmail.com', '27213000', 'Rua A', 'Casa');
INSERT INTO pessoa(cpf_pessoa, nome, email, cep, rua, numero)
    VALUES ('25952848788', 'Isabel Rodrigues', 'ir4432211@gmail.com', '69312593', 'Rua Sobral', 32);

-- inserção na tabela telefones  

INSERT INTO telefones(num_tel, cpf_pessoa)
    VALUES ('36386225', '58235053454');
INSERT INTO telefones(num_tel, cpf_pessoa)
    VALUES ('7923149467', '58235053454');
INSERT INTO telefones(num_tel, cpf_pessoa)
    VALUES ('984149467', '44882211491');
INSERT INTO telefones(num_tel, cpf_pessoa)
    VALUES ('923991327', '17267832946');
INSERT INTO telefones(num_tel, cpf_pessoa)
    VALUES ('923148027', '72610547200');
INSERT INTO telefones(num_tel, cpf_pessoa)
    VALUES ('988931207', '64784744290');
INSERT INTO telefones(num_tel, cpf_pessoa)
    VALUES ('999149467', '02702912532');
INSERT INTO telefones(num_tel, cpf_pessoa)
    VALUES ('923149499', '21542193818');
INSERT INTO telefones(num_tel, cpf_pessoa)
    VALUES ('995439467', '85449302711');
INSERT INTO telefones(num_tel, cpf_pessoa)
    VALUES ('942749467', '26348686850');
INSERT INTO telefones(num_tel, cpf_pessoa)
    VALUES ('915009467', '37521229517');
INSERT INTO telefones(num_tel, cpf_pessoa)
    VALUES ('977749467', '23238276344');
INSERT INTO telefones(num_tel, cpf_pessoa)
    VALUES ('974209467', '48174058303');
INSERT INTO telefones(num_tel, cpf_pessoa)
    VALUES ('940609467', '11467512060');
    
-- inserção na tabela funcionario

INSERT INTO funcionario(cpf_funcionario, data_adm, funcao, salario, cpf_supervisor)
    VALUES ('25952848788', '02/03/2023', 'Supervisor', 3000, '41582782792');
INSERT INTO funcionario(cpf_funcionario, data_adm, funcao, salario, cpf_supervisor)
    VALUES ('06661573325', '05/08/2022', 'Munitor', 4500, '41582782792');
INSERT INTO funcionario(cpf_funcionario, data_adm, funcao, salario, cpf_supervisor)
    VALUES ('62704882819', '10/11/2022', 'Gerente', 5000, '41582782792');
INSERT INTO funcionario(cpf_funcionario, data_adm, funcao, salario, cpf_supervisor)
    VALUES ('86385882594', '11/11/2022', 'Gerente', 5000, '41582782792');
INSERT INTO funcionario(cpf_funcionario, data_adm, funcao, salario, cpf_supervisor)
    VALUES ('07262636308', '30/05/2022', 'Munitor', 4500, '41582782792');
INSERT INTO funcionario(cpf_funcionario, data_adm, funcao, salario, cpf_supervisor)
    VALUES ('70775502227', '29/09/2022', 'Munitor', 4500, '41582782792');
INSERT INTO funcionario(cpf_funcionario, data_adm, funcao, salario, cpf_supervisor)
    VALUES ('18041727662', '29/09/2022', 'Munitor', 4500, '41582782792');
INSERT INTO funcionario(cpf_funcionario, data_adm, funcao, salario, cpf_supervisor)
    VALUES ('89987766420', '20/01/2023', 'Munitor', 4500, '41582782792');
INSERT INTO funcionario(cpf_funcionario, data_adm, funcao, salario, cpf_supervisor)
    VALUES ('25455186892', '15/01/2023', 'Gerente', 5000, '41582782792');
INSERT INTO funcionario(cpf_funcionario, data_adm, funcao, salario, cpf_supervisor)
    VALUES ('41582782792', '02/03/2023', 'Supervisor', 3000, '25952848788');
    
-- inserção na tabela vendedor

INSERT INTO vendedor(cpf_vendedor, data_registro)
	VALUES ('72610547200', '28/09/2021');
INSERT INTO vendedor(cpf_vendedor, data_registro)
	VALUES ('02702912532', '25/12/2022');
INSERT INTO vendedor(cpf_vendedor, data_registro, cnpj)
	VALUES ('21542193818', '14/02/2019', '49155590088587');
INSERT INTO vendedor(cpf_vendedor, data_registro, cnpj)
	VALUES ('26348686850', '10/12/2021', '69799235852540');
INSERT INTO vendedor(cpf_vendedor, data_registro)
	VALUES ('37521229517', '23/01/2021');
INSERT INTO vendedor(cpf_vendedor, data_registro)
	VALUES ('23238276344', '03/04/2022');
INSERT INTO vendedor(cpf_vendedor, data_registro, cnpj)
	VALUES ('11467512060', '31/10/2019', '95348312139969');
INSERT INTO vendedor(cpf_vendedor, data_registro, cnpj)
	VALUES ('24366201640', '13/08/2022', '29569137111307');
INSERT INTO vendedor(cpf_vendedor, data_registro, cnpj)
	VALUES ('25666674978', '16/11/2023', '39667455254750');
INSERT INTO vendedor(cpf_vendedor, data_registro)
	VALUES ('38540174804', '15/05/2020');
INSERT INTO vendedor(cpf_vendedor, data_registro)
	VALUES ('41582782792', '10/10/2019');
INSERT INTO vendedor(cpf_vendedor, data_registro)
	VALUES ('25455186892', '24/07/2023');
INSERT INTO vendedor(cpf_vendedor, data_registro, cnpj)
	VALUES ('18041727662', '20/03/2022', '29836175987778');
INSERT INTO vendedor(cpf_vendedor, data_registro)
	VALUES ('86385882594', '11/10/2021');
INSERT INTO vendedor(cpf_vendedor, data_registro, cnpj)
	VALUES ('62704882819', '11/12/2023', '72900262685102');
    
-- inserção na tabela cliente

INSERT INTO cliente(cpf_cliente, cnpj)
    VALUES ('44882211491', '78239009188379');
INSERT INTO cliente(cpf_cliente)
    VALUES ('17267832946');
INSERT INTO cliente(cpf_cliente)
    VALUES ('64784744290');
INSERT INTO cliente(cpf_cliente)
    VALUES ('85449302711');
INSERT INTO cliente(cpf_cliente, cnpj)
    VALUES ('26348686850', '40744428773628');
INSERT INTO cliente(cpf_cliente, cnpj)
    VALUES ('37521229517', '39718905425493');
INSERT INTO cliente(cpf_cliente, cnpj)
    VALUES ('11467512060', '95348312139969');
INSERT INTO cliente(cpf_cliente)
    VALUES ('31109286635');
INSERT INTO cliente(cpf_cliente)
    VALUES ('24366201640');
INSERT INTO cliente(cpf_cliente, cnpj)
    VALUES ('25666674978', '39667455254750');
INSERT INTO cliente(cpf_cliente, cnpj)
    VALUES ('75708608706', '14919544252152');
INSERT INTO cliente(cpf_cliente)
    VALUES ('38540174804');
INSERT INTO cliente(cpf_cliente, cnpj)
    VALUES ('29586233197', '39286626777506');
INSERT INTO cliente(cpf_cliente)
    VALUES ('41582782792');
INSERT INTO cliente(cpf_cliente, cnpj)
    VALUES ('89987766420', '36951827922116');
INSERT INTO cliente(cpf_cliente)
    VALUES ('70775502227');
INSERT INTO cliente(cpf_cliente, cnpj)
    VALUES ('07262636308', '43837950543179');
INSERT INTO cliente(cpf_cliente)
    VALUES ('86385882594');
INSERT INTO cliente(cpf_cliente, cnpj)
    VALUES ('25952848788', '24090254388633');
    
-- inserção na tabela espaco

INSERT INTO espaco(cod_espaco, tamanho, tipo, comissao, cpf_funcionario)
    VALUES ();
    
-- inserção na tabela produto

INSERT INTO produto(cod_produto, valor, tipo, nome)
    VALUES ();
    
-- inserção na tabela assistente

INSERT INTO assistente(cpf_vendedor, nome)
    VALUES ('02702912532', 'Rodrigo Ferreira de Souza');
INSERT INTO assistente(cpf_vendedor, nome)
    VALUES ('26348686850', 'Renato Martins de Moura');
INSERT INTO assistente(cpf_vendedor, nome)
    VALUES ('37521229517', 'Marília Luísa de Santana');
INSERT INTO assistente(cpf_vendedor, nome)
    VALUES ('24366201640', 'Ruy Magalhães');
INSERT INTO assistente(cpf_vendedor, nome)
    VALUES ('24366201640', 'Pedro Souza Silva');
INSERT INTO assistente(cpf_vendedor, nome)
    VALUES ('25666674978', 'Ana Souza de Lima');
INSERT INTO assistente(cpf_vendedor, nome)
    VALUES ('41582782792', 'Luísa Freire');
INSERT INTO assistente(cpf_vendedor, nome)
    VALUES ('18041727662', 'Adriano de Souza Lima');
INSERT INTO assistente(cpf_vendedor, nome)
    VALUES ('18041727662', 'Guilherme De Luca');
INSERT INTO assistente(cpf_vendedor, nome)
    VALUES ('62704882819', 'Pedro Luís Silva');
INSERT INTO assistente(cpf_vendedor, nome)
    VALUES ('62704882819', 'Lucas Pereira de Morais');
    
-- inserção na tabela cartao_fidelidade

INSERT INTO cartao_fidelidade(cpf_cliente, cod_cartao)
    VALUES ('44882211491', cod_fid.NEXTVAL);
INSERT INTO cartao_fidelidade(cpf_cliente, cod_cartao)
    VALUES ('64784744290', cod_fid.NEXTVAL);
INSERT INTO cartao_fidelidade(cpf_cliente, cod_cartao)
    VALUES ('85449302711', cod_fid.NEXTVAL);
INSERT INTO cartao_fidelidade(cpf_cliente, cod_cartao)
    VALUES ('37521229517', cod_fid.NEXTVAL);
INSERT INTO cartao_fidelidade(cpf_cliente, cod_cartao)
    VALUES ('24366201640', cod_fid.NEXTVAL);
INSERT INTO cartao_fidelidade(cpf_cliente, cod_cartao)
    VALUES ('25666674978', cod_fid.NEXTVAL);
INSERT INTO cartao_fidelidade(cpf_cliente, cod_cartao)
    VALUES ('29586233197', cod_fid.NEXTVAL);
INSERT INTO cartao_fidelidade(cpf_cliente, cod_cartao)
    VALUES ('41582782792', cod_fid.NEXTVAL);
INSERT INTO cartao_fidelidade(cpf_cliente, cod_cartao)
    VALUES ('89987766420', cod_fid.NEXTVAL);
INSERT INTO cartao_fidelidade(cpf_cliente, cod_cartao)
    VALUES ('86385882594', cod_fid.NEXTVAL);
    
-- inserção na tabela venda

INSERT INTO venda(data_hora, cod_produto, cpf_cliente, cpf_vendedor,
    cpf_funcionario, desconto, quantidade, valor_unit, valor_total)
    VALUES ();
    
-- inserção na tabela disponibiliza

INSERT INTO disponibiliza(cpf_vendedor, cpf_funcionario, cod_espaco,
    hora_inicio, hora_fim, data_inicio, data_fim)
    VALUES ();
