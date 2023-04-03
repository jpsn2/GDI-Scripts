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


-- inserção na tabela endereco

INSERT INTO tb_Endereco VALUES(
    tp_Endereco('49038420', 'Rua Orlando Sobral dos Santos', 45, 'Casa')
);

INSERT INTO tb_Endereco VALUES(
    tp_Endereco('29090820', 'Rua Victorino Cardoso', 2, 'Casa')
);

INSERT INTO tb_Endereco VALUES(
    tp_Endereco('78120786', 'Travessa do Nenê', 156)
);

INSERT INTO tb_Endereco VALUES(
    tp_Endereco('49087423', 'Rua B', 43, 'Casa')
);

INSERT INTO tb_Endereco VALUES(
    tp_Endereco('21511110', 'Rua Gentil de Almeida', 'apt. 21')
);

INSERT INTO tb_Endereco VALUES(
    tp_Endereco('88702446', 'Rua Caminho da Luz', 167)
);

INSERT INTO tb_Endereco VALUES(
    tp_Endereco('94828106', 'Rua C', 5, 'Casa')
);

INSERT INTO tb_Endereco VALUES(
    tp_Endereco('26062420', 'Rua Américo Vespúcio', 48, 'apt. 05')
);

INSERT INTO tb_Endereco VALUES(
    tp_Endereco('26060370', 'Rua Dona Eulália', 145, 'Casa')
);

INSERT INTO tb_Endereco VALUES(
    tp_Endereco('84036145', 'Rua Joaquim Jurandir Collares', 202)
);

INSERT INTO tb_Endereco VALUES(
    tp_Endereco('58058340', 'Rua Irene Alves P. Celani', 32, 'apt. 103')
);

INSERT INTO tb_Endereco VALUES(
    tp_Endereco('49009073', 'Rua José Domingos Maia III', 21, 'apt. 304')
);

INSERT INTO tb_Endereco VALUES(
    tp_Endereco('64088510', 'Rua Pindaíba', 78)
);

INSERT INTO tb_Endereco VALUES(
    tp_Endereco('64001010', 'Avenida Maranhão', 65, 'apt. 708')
);

INSERT INTO tb_Endereco VALUES(
    tp_Endereco('78132808', 'Avenida Leoncio Lopes de Miranda', 978, 'apt. 501')
);

INSERT INTO tb_Endereco VALUES(
    tp_Endereco('78725030', 'Rua General de Marcos', 5, 'Casa')
);

INSERT INTO tb_Endereco VALUES(
    tp_Endereco('79100290', 'Rua da Promissão', 465, 'Casa')
);

INSERT INTO tb_Endereco VALUES(
    tp_Endereco('64016745', 'Rua Doutor Area Leão', 307, 'Casa')
);

INSERT INTO tb_Endereco VALUES(
    tp_Endereco('54080420', 'Rua Marechal Deodoro da Fonsêca', 30, 'apt. 101')
);

INSERT INTO tb_Endereco VALUES(
    tp_Endereco('76801198', 'Rua Hebert de Azevedo', 20, 'apt. 105')
);

INSERT INTO tb_Endereco VALUES(
    tp_Endereco('65630970', 'Rua Magalhães de Almeida', 98)
);

INSERT INTO tb_Endereco VALUES(
    tp_Endereco('78552105', 'Rua das Canelas', 60, 'Casa')
);

INSERT INTO tb_Endereco VALUES(
    tp_Endereco('79114200', 'Rua Oswaldo Goeld')
);

INSERT INTO tb_Endereco VALUES(
    tp_Endereco('76913744', 'Rua Santa Clara', 73, 'Casa')
);

INSERT INTO tb_Endereco VALUES(
    tp_Endereco('69039080', 'Rua Herdeiro do Rei', 75, 'apt. 104')
);

INSERT INTO tb_Endereco VALUES(
    tp_Endereco('84051010', 'Rua Braulina Carneiro de Quadros', 78, 'apt. 606')
);

INSERT INTO tb_Endereco VALUES(
    tp_Endereco('69313405', 'Rua Raimunda Mendes de Almeida', 'apt. 102')
);

INSERT INTO tb_Endereco VALUES(
    tp_Endereco('68906091', 'Rua Santa Tereza', 830, 'Casa')
);

INSERT INTO tb_Endereco VALUES(
    tp_Endereco('27213000', 'Rua A', 'Casa')
);

INSERT INTO tb_Endereco VALUES(
    tp_Endereco('69312593', 'Rua Sobral', 32)
);

INSERT INTO tb_Endereco VALUES(
    tp_Endereco('24020000', 'Rua Almeida', 'Casa')
);

INSERT INTO tb_Endereco VALUES(
    tp_Endereco('27556600', 'Rua Imperial', 'Casa')
);

INSERT INTO tb_Endereco VALUES(
    tp_Endereco('88926600', 'Rua Aurora', 'Casa')
);

INSERT INTO tb_Endereco VALUES(
    tp_Endereco('64289080', 'Rua Sá e Souza', 725, 'apt. 401')
);

INSERT INTO tb_Endereco VALUES(
    tp_Endereco('64289081', 'Rua Cruzeiro do Forte', 112, 'Casa')
);


-- inserção na tabela funcionario

INSERT INTO tb_Funcionario
    VALUES (
        tp_Funcionario(
            '56991573326', 'Marcelo Campos', 'macam@gmail.com',
            (SELECT REF(e) FROM tb_Endereco e WHERE e.cep = '49038420'),
            tp_Telefones(tp_Telefone('36386225'), tp_Telefone('7923149467')),
            '02/04/2021','Diretor',8000, null
        )
    );

INSERT INTO tb_Funcionario
    VALUES (
        tp_Funcionario(
            '06402073325', 'Vitor Henrique', 'vithen@gmail.com',
            (SELECT REF(e) FROM tb_Endereco e WHERE e.cep = '54080420'),
            null,
            '22/07/2021','Monitor',2200,
            (SELECT REF(f) FROM tb_Funcionario f WHERE f.cpf = '56991573326')
        )
    );

INSERT INTO tb_Funcionario
    VALUES (
        tp_Funcionario(
            '06651573325', 'Arthur Nogueira', 'athn776543999@gmail.com',
            (SELECT REF(e) FROM tb_Endereco e WHERE e.cep = '49038420'),
            null,
            '15/09/2021','Monitor',1500,
            (SELECT REF(f) FROM tb_Funcionario f WHERE f.cpf = '06402073325')
        )
    );

INSERT INTO tb_Funcionario
    VALUES (
        tp_Funcionario(
            '40510573325', 'Vinicius José', 'vinjose@gmail.com',
            (SELECT REF(e) FROM tb_Endereco e WHERE e.cep = '21511110'),
            null,
            '12/04/2021','Monitor',2300,
            (SELECT REF(f) FROM tb_Funcionario f WHERE f.cpf = '56991573326')
        )
    );

INSERT INTO tb_Funcionario
    VALUES (
        tp_Funcionario(
            '90805502227', 'Fernanda Diniz', 'ferdi@gmail.com',
            (SELECT REF(e) FROM tb_Endereco e WHERE e.cep = '26060370'),
            null,
            '07/01/2021','Gerente',2850,
            (SELECT REF(f) FROM tb_Funcionario f WHERE f.cpf = '56991573326')
        )
    );  

INSERT INTO tb_Funcionario
    VALUES (
        tp_Funcionario(
            '99124502227', 'Fabio Alpes','fabal@gmail.com',
            (SELECT REF(e) FROM tb_Endereco e WHERE e.cep = '26062420'),
            null,
            '15/02/2021','Gerente ',2700,
            (SELECT REF(f) FROM tb_Funcionario f WHERE f.cpf = '90805502227')
        )
    );

INSERT INTO tb_Funcionario
    VALUES (
        tp_Funcionario(
            '41582782792', 'Alice Jesus', 'aj2463@gmail.com',
            (SELECT REF(e) FROM tb_Endereco e WHERE e.cep = '64088510'),
            null,
            '02/03/2023', 'Supervisor', 3000, 
            (SELECT REF(f) FROM tb_Funcionario f WHERE f.cpf = '99124502227')
        )
    );

INSERT INTO tb_Funcionario
    VALUES (
        tp_Funcionario(
            '25952848788', 'Isabel Rodrigues', 'ir4432211@gmail.com',
            (SELECT REF(e) FROM tb_Endereco e WHERE e.cep = '88702446'),
            null,
            '02/03/2023', 'Supervisor', 3000, 
            (SELECT REF(f) FROM tb_Funcionario f WHERE f.cpf = '41582782792')
        )
    );

INSERT INTO tb_Funcionario
    VALUES (
        tp_Funcionario(
            '62704882819', 'Noah Alves', 'nha256@gmail.com',
            (SELECT REF(e) FROM tb_Endereco e WHERE e.cep = '54080420'),
            null,
            '10/11/2022', 'Gerente', 5000, 
            (SELECT REF(f) FROM tb_Funcionario f WHERE f.cpf = '41582782792')
        )
    );
    
INSERT INTO tb_Funcionario
    VALUES (
        tp_Funcionario(
            '86385882594', 'Vicente Rocha', 'vr5555@yahoo.com.br',
            (SELECT REF(e) FROM tb_Endereco e WHERE e.cep = '76913744'),
            null,
            '11/11/2022', 'Gerente', 5000, 
            (SELECT REF(f) FROM tb_Funcionario f WHERE f.cpf = '41582782792')
        )
    );

INSERT INTO tb_Funcionario
    VALUES (
        tp_Funcionario(
            '07262636308', 'Vitor Hugo Caldeira', 'vhc278679375@gmail.com',
            (SELECT REF(e) FROM tb_Endereco e WHERE e.cep = '27213000'),
            null,
            '30/05/2022', 'Monitor', 4500, 
            (SELECT REF(f) FROM tb_Funcionario f WHERE f.cpf = '41582782792')
        )
    );

INSERT INTO tb_Funcionario
    VALUES (
        tp_Funcionario(
            '70775502227', 'Carolina das Neves', 'cdn09872435@gmail.com',
            (SELECT REF(e) FROM tb_Endereco e WHERE e.cep = '64289080'),
            null,
            '29/09/2022', 'Monitor', 4500, 
            (SELECT REF(f) FROM tb_Funcionario f WHERE f.cpf = '41582782792')
        )
    );

INSERT INTO tb_Funcionario
    VALUES (
        tp_Funcionario(
            '18041727662', 'Thales Nogueira', 'tn90825@gmail.com',
            (SELECT REF(e) FROM tb_Endereco e WHERE e.cep = '64289081'),
            null,
            '29/09/2022', 'Monitor', 4500, 
            (SELECT REF(f) FROM tb_Funcionario f WHERE f.cpf = '41582782792')
        )
    );

INSERT INTO tb_Funcionario
    VALUES (
        tp_Funcionario(
            '89987766420', 'Helena Barbosa', 'hb245@gmail.com',
            (SELECT REF(e) FROM tb_Endereco e WHERE e.cep = '27213000'),
            null,
            '20/01/2023', 'Monitor', 4500, 
            (SELECT REF(f) FROM tb_Funcionario f WHERE f.cpf = '41582782792')
        )
    );

INSERT INTO tb_Funcionario
    VALUES (
        tp_Funcionario(
            '25455186892', 'Luiz Felipe da Costa', 'lfdc@hotmail.com',
            (SELECT REF(e) FROM tb_Endereco e WHERE e.cep = '64289081'),
            null,
            '15/01/2023', 'Gerente', 5000, 
            (SELECT REF(f) FROM tb_Funcionario f WHERE f.cpf = '41582782792')
        )
    );

-- inserção na tabela vendedor

INSERT INTO tb_Vendedor
    VALUES (
        tp_Vendedor(
            '72610547200', 'Pedro Lucas Barbosa', 'plb2526@yahoo.com.br',
            (SELECT REF(e) FROM tb_Endereco e WHERE e.cep = '49087423'),
            tp_Telefones(tp_Telefone('923148027')),
            '28/09/2021', null,
    		tp_nt_Assistente()
        )
    );
UPDATE tb_Vendedor
    SET assistentes = 
    	tp_nt_Assistente(
    		tp_Assistente(
    			'nomeassistente',
    			(SELECT REF(v) FROM tb_vendedor v WHERE v.cpf = '72610547200')
            )
        )
    WHERE cpf = '72610547200';

INSERT INTO tb_Vendedor
    VALUES (
        tp_Vendedor(
            '02702912532', 'Calebe Ferreira', 'cf9485@hotmail.com',
            (SELECT REF(e) FROM tb_Endereco e WHERE e.cep = '88702446'),
            tp_Telefones(tp_Telefone('999149467')),
            '25/12/2022', null,
    		tp_nt_Assistente()
        )
    );
UPDATE tb_Vendedor
    SET assistentes = 
    	tp_nt_Assistente(
    		tp_Assistente(
    			'Rodrigo Ferreira de Souza',
    			(SELECT REF(v) FROM tb_vendedor v WHERE v.cpf = '02702912532')
            )
        )
    WHERE cpf = '02702912532';

INSERT INTO tb_Vendedor
    VALUES (
        tp_Vendedor(
            '21542193818', 'Eduardo Cardoso', 'ec3333@gmail.com',
            (SELECT REF(e) FROM tb_Endereco e WHERE e.cep = '94828106'),
            tp_Telefones(tp_Telefone('923149499')),
            '14/02/2019', '49155590088587',
    		tp_nt_Assistente()
        )
    );
UPDATE tb_Vendedor
    SET assistentes = 
    	tp_nt_Assistente(
    		tp_Assistente(
    			'nomeassistente',
    			(SELECT REF(v) FROM tb_vendedor v WHERE v.cpf = '21542193818')
            )
        )
    WHERE cpf = '21542193818';

INSERT INTO tb_Vendedor
    VALUES (
        tp_Vendedor(
            '26348686850', 'Kamilly Aragão', 'kafd56367@outlook.com',
            (SELECT REF(e) FROM tb_Endereco e WHERE e.cep = '26060370'),
            tp_Telefones(tp_Telefone('942749467')),
            '10/12/2021', '69799235852540',
    		tp_nt_Assistente()
        )
    );
UPDATE tb_Vendedor
    SET assistentes = 
    	tp_nt_Assistente(
    		tp_Assistente(
    			'Renato Martins de Moura',
    			(SELECT REF(v) FROM tb_vendedor v WHERE v.cpf = '26348686850')
            )
        )
    WHERE cpf = '26348686850';

INSERT INTO tb_Vendedor
    VALUES (
        tp_Vendedor(
            '37521229517', 'Luana Melo', 'lm@cin.ufpe.br',
            (SELECT REF(e) FROM tb_Endereco e WHERE e.cep = '84036145'),
            tp_Telefones(tp_Telefone('915009467')),
            '23/01/2021', null,
    		tp_nt_Assistente()
        )
    );
UPDATE tb_Vendedor
    SET assistentes = 
    	tp_nt_Assistente(
    		tp_Assistente(
    			'Marília Luísa de Santana',
    			(SELECT REF(v) FROM tb_vendedor v WHERE v.cpf = '37521229517')
            )
        )
    WHERE cpf = '37521229517';

INSERT INTO tb_Vendedor
    VALUES (
        tp_Vendedor(
            '23238276344', 'Ana Júlia das Neves', 'ajdn0935@gmail.com',
            (SELECT REF(e) FROM tb_Endereco e WHERE e.cep = '58058340'),
            tp_Telefones(tp_Telefone('977749467')),
            '03/04/2022', null,
    		tp_nt_Assistente()
        )
    );
UPDATE tb_Vendedor
    SET assistentes = 
    	tp_nt_Assistente(
    		tp_Assistente(
    			'nomeassistente',
    			(SELECT REF(v) FROM tb_vendedor v WHERE v.cpf = '23238276344')
            )
        )
    WHERE cpf = '23238276344';

INSERT INTO tb_Vendedor
    VALUES (
        tp_Vendedor(
            '11467512060', 'Larissa Moura', 'lm@yahoo.com.br',
            (SELECT REF(e) FROM tb_Endereco e WHERE e.cep = '64088510'),
            tp_Telefones(tp_Telefone('940609467')),
            '31/10/2019', '95348312139969',
    		tp_nt_Assistente()
        )
    );
UPDATE tb_Vendedor
    SET assistentes = 
    	tp_nt_Assistente(
    		tp_Assistente(
    			'nomeassistente',
    			(SELECT REF(v) FROM tb_vendedor v WHERE v.cpf = '11467512060')
            )
        )
    WHERE cpf = '11467512060';

INSERT INTO tb_Vendedor
    VALUES (
        tp_Vendedor(
            '24366201640', 'Kevin Almeida', 'ka4325@gmail.com',
            (SELECT REF(e) FROM tb_Endereco e WHERE e.cep = '78132808'),
            tp_Telefones(tp_Telefone('96554562'), tp_Telefone('894543116')),
            '13/08/2022', '29569137111307',
    		tp_nt_Assistente()
        )
    );
UPDATE tb_Vendedor
    SET assistentes = 
    	tp_nt_Assistente(
    		tp_Assistente(
    			'Ruy Magalhães',
    			(SELECT REF(v) FROM tb_vendedor v WHERE v.cpf = '24366201640')),
		tp_Assistente(
    			'Pedro Souza Silva',
    			(SELECT REF(v) FROM tb_vendedor v WHERE v.cpf = '24366201640')
            )
        )
    WHERE cpf = '24366201640';

INSERT INTO tb_Vendedor
    VALUES (
        tp_Vendedor(
            '25666674978', 'Carolina Duarte', 'cd87875672678@gmail.com',
            (SELECT REF(e) FROM tb_Endereco e WHERE e.cep = '78725030'),
            tp_Telefones(tp_Telefone('56944332'), tp_Telefone('984352400')),
            '16/11/2023', '39667455254750',
    		tp_nt_Assistente()
        )
    );
UPDATE tb_Vendedor
    SET assistentes = 
    	tp_nt_Assistente(
    		tp_Assistente(
    			'Ana Souza de Lima',
    			(SELECT REF(v) FROM tb_vendedor v WHERE v.cpf = '25666674978')
            )
        )
    WHERE cpf = '25666674978';

INSERT INTO tb_Vendedor
    VALUES (
        tp_Vendedor(
            '38540174804', 'Bruna Monteiro', 'bmdsaf24@outlook.com',
            (SELECT REF(e) FROM tb_Endereco e WHERE e.cep = '54080420'),
            tp_Telefones(tp_Telefone('955724560')),
            '5/05/2020', null,
    		tp_nt_Assistente()
        )
    );
UPDATE tb_Vendedor
    SET assistentes = 
    	tp_nt_Assistente(
    		tp_Assistente(
    			'nomeassistente',
    			(SELECT REF(v) FROM tb_vendedor v WHERE v.cpf = '38540174804')
            )
        )
    WHERE cpf = '38540174804';

INSERT INTO tb_Vendedor
    VALUES (
        tp_Vendedor(
            '41582782792', 'Alice Jesus', 'aj2463@gmail.com',
            (SELECT REF(e) FROM tb_Endereco e WHERE e.cep = '65630970'),
            tp_Telefones(),
            '10/10/2019', null,
    		tp_nt_Assistente()
        )
    );
UPDATE tb_Vendedor
    SET assistentes = 
    	tp_nt_Assistente(
    		tp_Assistente(
    			'Luísa Freire',
    			(SELECT REF(v) FROM tb_vendedor v WHERE v.cpf = '41582782792')
            )
        )
    WHERE cpf = '41582782792';

INSERT INTO tb_Vendedor
    VALUES (
        tp_Vendedor(
            '25455186892', 'Luiz Felipe da Costa', 'lfdc@hotmail.com',
            (SELECT REF(e) FROM tb_Endereco e WHERE e.cep = '78552105'),
            tp_Telefones(tp_Telefone('9673243601'), tp_Telefone('90349234')),
            '24/07/2023', null,
    		tp_nt_Assistente()
        )
    );
UPDATE tb_Vendedor
    SET assistentes = 
    	tp_nt_Assistente(
    		tp_Assistente(
    			'nomeassistente',
    			(SELECT REF(v) FROM tb_vendedor v WHERE v.cpf = '25455186892')
            )
        )
    WHERE cpf = '25455186892';

INSERT INTO tb_Vendedor
    VALUES (
        tp_Vendedor(
            '18041727662', 'Thales Nogueira', 'tn90825@gmail.com',
            (SELECT REF(e) FROM tb_Endereco e WHERE e.cep = 'cepv76913744endedor'),
            tp_Telefones(tp_Telefone('93488203')),
            '20/03/2022', '29836175987778',
    		tp_nt_Assistente()
        )
    );
UPDATE tb_Vendedor
    SET assistentes = 
    	tp_nt_Assistente(
    		tp_Assistente(
    			'Adriano de Souza Lima',
    			(SELECT REF(v) FROM tb_vendedor v WHERE v.cpf = '18041727662')),
		tp_Assistente(
    			'Guilherme De Luca',
    			(SELECT REF(v) FROM tb_vendedor v WHERE v.cpf = '18041727662'))
        )
    WHERE cpf = '18041727662';

INSERT INTO tb_Vendedor
    VALUES (
        tp_Vendedor(
            '86385882594', 'Vicente Rocha', 'vr5555@yahoo.com.br',
            (SELECT REF(e) FROM tb_Endereco e WHERE e.cep = '69313405'),
            tp_Telefones(tp_Telefone('938428451')),
            '11/10/2021', null,
    		tp_nt_Assistente()
        )
    );
UPDATE tb_Vendedor
    SET assistentes = 
    	tp_nt_Assistente(
    		tp_Assistente(
    			'nomeassistente',
    			(SELECT REF(v) FROM tb_vendedor v WHERE v.cpf = '86385882594'))
        )
    WHERE cpf = '86385882594';

INSERT INTO tb_Vendedor
    VALUES (
        tp_Vendedor(
            '62704882819', 'Noah Alves', 'nha256@gmail.com',
            (SELECT REF(e) FROM tb_Endereco e WHERE e.cep = '68906091'),
            tp_Telefones(tp_Telefone('91802104'), tp_Telefone('953224981')),
            '11/12/2023', '72900262685102',
    		tp_nt_Assistente()
        )
    );
UPDATE tb_Vendedor
    SET assistentes = 
    	tp_nt_Assistente(
    		tp_Assistente(
    			'Pedro Luís Silva',
    			(SELECT REF(v) FROM tb_vendedor v WHERE v.cpf = '62704882819')),
		tp_Assistente(
    			'Lucas Pereira de Morais',
    			(SELECT REF(v) FROM tb_vendedor v WHERE v.cpf = '62704882819'))
        )
    WHERE cpf = '62704882819';
    
-- inserção na tabela cliente

INSERT INTO tb_Cliente
    VALUES (
        tp_Cliente(
            '44882211491', 'Miguel Alves', 'ma356@outlook.com',
            (SELECT REF(e) FROM tb_Endereco e WHERE e.cep = '29090820'),
            tp_Telefones(tp_Telefone('984149467')),
            '78239009188379',
    		tp_Cartao_fidelidade(cod_fid.NEXTVAL)
        )
    );

  INSERT INTO tb_Cliente
    VALUES (
        tp_Cliente(
            '17267832946', 'Ana Vitória Vieira', 'avc259@gmail.com',
            (SELECT REF(e) FROM tb_Endereco e WHERE e.cep = '78120786'),
            tp_Telefones(tp_Telefone('923991327')),
            null,
    		tp_Cartao_fidelidade(cod_fid.NEXTVAL)
        )
    );

 INSERT INTO tb_Cliente
    VALUES (
        tp_Cliente(
            '64784744290', 'João Nascimento', 'jn2@gmail.com',
            (SELECT REF(e) FROM tb_Endereco e WHERE e.cep = '21511110'),
            tp_Telefones(tp_Telefone('988931207')),
            null,
    		tp_Cartao_fidelidade(cod_fid.NEXTVAL)
        )
    );

INSERT INTO tb_Cliente
    VALUES (
        tp_Cliente(
            '85449302711', 'Marcelo Rocha', 'mrq45@gmail.com',
            (SELECT REF(e) FROM tb_Endereco e WHERE e.cep = '26062420'),
            tp_Telefones(tp_Telefone('995439467')),
            null,
    		tp_Cartao_fidelidade(cod_fid.NEXTVAL)
        )
    );

INSERT INTO tb_Cliente
    VALUES (
        tp_Cliente(
            '26348686850', 'Kamilly Aragão', 'kafd56367@outlook.com',
            (SELECT REF(e) FROM tb_Endereco e WHERE e.cep = '26060370'),
            tp_Telefones(tp_Telefone('942749467')),
            '40744428773628',
    		tp_Cartao_fidelidade(cod_fid.NEXTVAL)
        )
    );

INSERT INTO tb_Cliente
    VALUES (
        tp_Cliente(
            '37521229517', 'Luana Melo', 'lm@cin.ufpe.br',
            (SELECT REF(e) FROM tb_Endereco e WHERE e.cep = '84036145'),
            tp_Telefones(tp_Telefone('915009467')),
            '39718905425493',
    		tp_Cartao_fidelidade(cod_fid.NEXTVAL)
        )
    );

INSERT INTO tb_Cliente
    VALUES (
        tp_Cliente(
            '11467512060', 'Larissa Moura', 'lm@yahoo.com.br',
            (SELECT REF(e) FROM tb_Endereco e WHERE e.cep = '64088510'),
            tp_Telefones(tp_Telefone('940609467')),
            '95348312139969',
    		tp_Cartao_fidelidade(cod_fid.NEXTVAL)
        )
    );

INSERT INTO tb_Cliente
    VALUES (
        tp_Cliente(
            '31109286635', 'Renan Silveira', 'rsj32j@gmail.com',
            (SELECT REF(e) FROM tb_Endereco e WHERE e.cep = '64001010'),
            tp_Telefones(tp_Telefone('92382754')),
            null,
    		tp_Cartao_fidelidade(cod_fid.NEXTVAL)
        )
    );

INSERT INTO tb_Cliente
    VALUES (
        tp_Cliente(
            '24366201640', 'Kevin Almeida', 'ka4325@gmail.com',
            (SELECT REF(e) FROM tb_Endereco e WHERE e.cep = '78132808'),
            tp_Telefones(tp_Telefone('98274641'),tp_Telefone('923828010')),
            null,
    		tp_Cartao_fidelidade(cod_fid.NEXTVAL)
        )
    );

INSERT INTO tb_Cliente
    VALUES (
        tp_Cliente(
            '25666674978', 'Carolina Duarte', 'cd87875672678@gmail.com',
            (SELECT REF(e) FROM tb_Endereco e WHERE e.cep = '78725030'),
            tp_Telefones(tp_Telefone('94837274')),
            '39667455254750',
    		tp_Cartao_fidelidade(cod_fid.NEXTVAL)
        )
    );

INSERT INTO tb_Cliente
    VALUES (
        tp_Cliente(
            '75708608706', 'Pedro Lucas Martins', 'plm24243f@gmail.com',
            (SELECT REF(e) FROM tb_Endereco e WHERE e.cep = '79100290'),
            tp_Telefones(),
            '14919544252152',
    		tp_Cartao_fidelidade(cod_fid.NEXTVAL)
        )
    );

INSERT INTO tb_Cliente
    VALUES (
        tp_Cliente(
            '38540174804', 'Pedro Lucas Martins', 'plm24243f@gmail.com',
            (SELECT REF(e) FROM tb_Endereco e WHERE e.cep = '79100290'),
            tp_Telefones(tp_Telefone('94837372')),
            null,
    		tp_Cartao_fidelidade(cod_fid.NEXTVAL)
        )
    );

INSERT INTO tb_Cliente
    VALUES (
        tp_Cliente(
            '29586233197', 'Manuela Caldeira', 'mc432659@outlook.com',
            (SELECT REF(e) FROM tb_Endereco e WHERE e.cep = '76801198'),
            tp_Telefones(tp_Telefone('93883875'),tp_Telefone('683998302')),
            '39286626777506',
    		tp_Cartao_fidelidade(cod_fid.NEXTVAL)
        )
    );

INSERT INTO tb_Cliente
    VALUES (
        tp_Cliente(
            '41582782792', 'Alice Jesus', 'aj2463@gmail.com',
            (SELECT REF(e) FROM tb_Endereco e WHERE e.cep = '65630970'),
            tp_Telefones(tp_Telefone('920398483')),
            null,
    		tp_Cartao_fidelidade(cod_fid.NEXTVAL)
        )
    );

INSERT INTO tb_Cliente
    VALUES (
        tp_Cliente(
            '89987766420', 'Helena Barbosa', 'hb245@gmail.com',
            (SELECT REF(e) FROM tb_Endereco e WHERE e.cep = '79114200'),
            tp_Telefones(tp_Telefone('8473883858'),tp_Telefone('38583948')),
            '36951827922116',
    		tp_Cartao_fidelidade(cod_fid.NEXTVAL)
        )
    );

INSERT INTO tb_Cliente
    VALUES (
        tp_Cliente(
            '70775502227', 'Carolina das Neves', 'cdn09872435@gmail.co',
            (SELECT REF(e) FROM tb_Endereco e WHERE e.cep = '69039080'),
            tp_Telefones(),
            null,
    		tp_Cartao_fidelidade(cod_fid.NEXTVAL)
        )
    );  

INSERT INTO tb_Cliente
    VALUES (
        tp_Cliente(
            '07262636308', 'Vitor Hugo Caldeira', 'vhc278679375@gmail.com',
            (SELECT REF(e) FROM tb_Endereco e WHERE e.cep = '84051010'),
            tp_Telefones(tp_Telefone('85939838')),
            '43837950543179',
    		tp_Cartao_fidelidade(cod_fid.NEXTVAL)
        )
    );

INSERT INTO tb_Cliente
    VALUES (
        tp_Cliente(
            '86385882594', 'Vicente Rocha', 'vr5555@yahoo.com.br',
            (SELECT REF(e) FROM tb_Endereco e WHERE e.cep = '69313405'),
            tp_Telefones(tp_Telefone('48339885')),
            null,
    		tp_Cartao_fidelidade(cod_fid.NEXTVAL)
        )
    );

INSERT INTO tb_Cliente
    VALUES (
        tp_Cliente(
            '25952848788', 'Isabel Rodrigues', 'ir4432211@gmail.com',
            (SELECT REF(e) FROM tb_Endereco e WHERE e.cep = '69312593'),
            tp_Telefones(tp_Telefone('928785730'),tp_Telefone('38586901')),
            '24090254388633',
    		tp_Cartao_fidelidade(cod_fid.NEXTVAL)
        )
    );
    
-- inserção na tabela espaco

INSERT INTO tb_Espaco
    VALUES (
        tp_Espaco(
            cod_esp.NEXTVAL, 'P', 'P', 11,
            (SELECT REF(f) FROM tb_funcionario f WHERE f.cpf = '06651573325')
        )
    );

INSERT INTO tb_Espaco
    VALUES (
        tp_Espaco(
            cod_esp.NEXTVAL, 'P', 'P', 12,
            (SELECT REF(f) FROM tb_funcionario f WHERE f.cpf = '06651573325')
        )
    );

INSERT INTO tb_Espaco
    VALUES (
        tp_Espaco(
            cod_esp.NEXTVAL, 'P', 'P', 11,
            (SELECT REF(f) FROM tb_funcionario f WHERE f.cpf = '06402073325')
        )
    );

INSERT INTO tb_Espaco
    VALUES (
        tp_Espaco(
            cod_esp.NEXTVAL, 'M', 'P', 12,
            (SELECT REF(f) FROM tb_funcionario f WHERE f.cpf = '06402073325')
        )
    );

INSERT INTO tb_Espaco
    VALUES (
        tp_Espaco(
            cod_esp.NEXTVAL, 'M', 'B', 14,
            (SELECT REF(f) FROM tb_funcionario f WHERE f.cpf = '40510573325')
        )
    );

INSERT INTO tb_Espaco
    VALUES (
        tp_Espaco(
            cod_esp.NEXTVAL, 'M', 'B', 15,
            (SELECT REF(f) FROM tb_funcionario f WHERE f.cpf = '56991573326')
        )
    );

INSERT INTO tb_Espaco
    VALUES (
        tp_Espaco(
            cod_esp.NEXTVAL, 'G', 'B', 17,
            (SELECT REF(f) FROM tb_funcionario f WHERE f.cpf = '56991573326')
        )
    );

INSERT INTO tb_Espaco
    VALUES (
        tp_Espaco(
            cod_esp.NEXTVAL, 'G', 'B', 17,
            (SELECT REF(f) FROM tb_funcionario f WHERE f.cpf = '90805502227')
        )
    );

INSERT INTO tb_Espaco
    VALUES (
        tp_Espaco(
            cod_esp.NEXTVAL, 'M', 'B', 14,
            (SELECT REF(f) FROM tb_funcionario f WHERE f.cpf = '90805502227')
        )
    );

INSERT INTO tb_Espaco
    VALUES (
        tp_Espaco(
            cod_esp.NEXTVAL, 'M', 'P', 12,
            (SELECT REF(f) FROM tb_funcionario f WHERE f.cpf = '99124502227')
        )
    );

INSERT INTO tb_Espaco
    VALUES (
        tp_Espaco(
            cod_esp.NEXTVAL, 'M', 'P', 13,
            (SELECT REF(f) FROM tb_funcionario f WHERE f.cpf = '99124502227')
        )
    );
    
-- inserção na tabela produto

INSERT INTO tb_Produto
    VALUES (tp_Produto(cod_prod.NEXTVAL, 2.5, 'Fruta', 'Abacate'));

INSERT INTO tb_Produto
    VALUES (tp_Produto(cod_prod.NEXTVAL, 3, 'Fruta', 'Abacaxi'));

INSERT INTO tb_Produto
    VALUES (tp_Produto(cod_prod.NEXTVAL, 1.2, 'Fruta', 'Banana'));

INSERT INTO tb_Produto
    VALUES (tp_Produto(cod_prod.NEXTVAL, 4.5, 'Fruta', 'Graviola'));

INSERT INTO tb_Produto
    VALUES (tp_Produto(cod_prod.NEXTVAL, 1.8, 'Fruta', 'Mamão'));

INSERT INTO tb_Produto
    VALUES (tp_Produto(cod_prod.NEXTVAL, 3.5, 'Hortaliça', 'Beterraba'));

INSERT INTO tb_Produto
    VALUES (tp_Produto(cod_prod.NEXTVAL, 1.25, 'Hortaliça', 'Chuchu'));

INSERT INTO tb_Produto
    VALUES (tp_Produto(cod_prod.NEXTVAL, 2, 'Hortaliça', 'Repolho'));

INSERT INTO tb_Produto
    VALUES (tp_Produto(cod_prod.NEXTVAL, 11.9, 'Pescado', 'Sardinha'));

INSERT INTO tb_Produto
    VALUES (tp_Produto(cod_prod.NEXTVAL, 48, 'Pescado', 'Bacalhau'));

INSERT INTO tb_Produto
    VALUES (tp_Produto(cod_prod.NEXTVAL, 2.3, 'Cereais e Diversos', 'Milho'));
	
INSERT INTO tb_Produto
    VALUES (tp_Produto(cod_prod.NEXTVAL, 4.6, 'Cereais e Diversos', 'Arroz Branco'));

INSERT INTO tb_Produto
    VALUES (tp_Produto(cod_prod.NEXTVAL, 32, 'Carne', 'Charque Bovina'));

INSERT INTO tb_Produto
    VALUES (tp_Produto(cod_prod.NEXTVAL, 22, 'Laticíneo', 'Queijo Coalho'));

INSERT INTO tb_Produto
    VALUES (tp_Produto(cod_prod.NEXTVAL, 0.6, 'Ovos', 'Ovo Branco'));
    
-- inserção na tabela venda

INSERT INTO tb_Venda
    VALUES ('25/01/2023 14:30:00',
        (SELECT REF(p) FROM tb_Produto p WHERE cod_produto = 4),
        (SELECT REF(c) FROM tb_Cliente c WHERE cpf = '44882211491'),
        (SELECT REF(v) FROM tb_Vendedor v WHERE cpf = '72610547200'),
        (SELECT REF(f) FROM tb_Funcionario f WHERE cpf = '18041727662'),
        0.07, 7, 4.5, 4.5 * 7 * 0.93);
INSERT INTO tb_Venda
    VALUES ('27/01/2023 10:15:00',
        (SELECT REF(p) FROM tb_Produto p WHERE cod_produto = 8),
        (SELECT REF(c) FROM tb_Cliente c WHERE cpf = '64784744290'),
        (SELECT REF(v) FROM tb_Vendedor v WHERE cpf = '21542193818'),
        (SELECT REF(f) FROM tb_Funcionario f WHERE cpf = '62704882819'),
        0.05, 13, 2, 2 * 13 * 0.95);
INSERT INTO tb_Venda
    VALUES ('28/01/2023 09:00:00',
        (SELECT REF(p) FROM tb_Produto p WHERE cod_produto = 10),
        (SELECT REF(c) FROM tb_Cliente c WHERE cpf = '85449302711'),
        (SELECT REF(v) FROM tb_Vendedor v WHERE cpf = '26348686850'),
        (SELECT REF(f) FROM tb_Funcionario f WHERE cpf = '18041727662'),
        0, 14, 48, 48 * 14 * 1);
INSERT INTO tb_Venda
    VALUES ('03/01/2023 09:00:00',
        (SELECT REF(p) FROM tb_Produto p WHERE cod_produto = 7),
        (SELECT REF(c) FROM tb_Cliente c WHERE cpf = '26348686850'),
        (SELECT REF(v) FROM tb_Vendedor v WHERE cpf = '37521229517'),
        (SELECT REF(f) FROM tb_Funcionario f WHERE cpf = '56991573326'),
        0.02, 11, 1.25, 1.25 * 11 * 0.98);
INSERT INTO tb_Venda
    VALUES ('03/03/2023 09:00:00',
        (SELECT REF(p) FROM tb_Produto p WHERE cod_produto = 6),
        (SELECT REF(c) FROM tb_Cliente c WHERE cpf = '11467512060'),
        (SELECT REF(v) FROM tb_Vendedor v WHERE cpf = '11467512060'),
        (SELECT REF(f) FROM tb_Funcionario f WHERE cpf = '56991573326'),
        0, 14, 3.5, 3.5 * 14 * 1);
INSERT INTO tb_Venda
    VALUES ('03/04/2023 09:00:00',
        (SELECT REF(p) FROM tb_Produto p WHERE cod_produto = 7),
        (SELECT REF(c) FROM tb_Cliente c WHERE cpf = '31109286635'),
        (SELECT REF(v) FROM tb_Vendedor v WHERE cpf = '24366201640'),
        (SELECT REF(f) FROM tb_Funcionario f WHERE cpf = '56991573326'),
        0, 19, 1.25, 1.25 * 19 * 1);
INSERT INTO tb_Venda
    VALUES ('05/03/2023 09:00:00',
        (SELECT REF(p) FROM tb_Produto p WHERE cod_produto = 8),
        (SELECT REF(c) FROM tb_Cliente c WHERE cpf = '24366201640'),
        (SELECT REF(v) FROM tb_Vendedor v WHERE cpf = '25666674978'),
        (SELECT REF(f) FROM tb_Funcionario f WHERE cpf = '90805502227'),
        0.10, 20, 2, 2 * 20 * 0.9);
INSERT INTO tb_Venda
    VALUES ('02/03/2023 09:00:00',
        (SELECT REF(p) FROM tb_Produto p WHERE cod_produto = 2),
        (SELECT REF(c) FROM tb_Cliente c WHERE cpf = '25666674978'),
        (SELECT REF(v) FROM tb_Vendedor v WHERE cpf = '38540174804'),
        (SELECT REF(f) FROM tb_Funcionario f WHERE cpf = '99124502227'),
        0.04, 14, 3, 3 * 14 * 0.96);
INSERT INTO tb_Venda
    VALUES ('03/03/2023 15:40:00',
        (SELECT REF(p) FROM tb_Produto p WHERE cod_produto = 2),
        (SELECT REF(c) FROM tb_Cliente c WHERE cpf = '75708608706'),
        (SELECT REF(v) FROM tb_Vendedor v WHERE cpf = '41582782792'),
        (SELECT REF(f) FROM tb_Funcionario f WHERE cpf = '41582782792'),
        0.08, 15, 3, 3 * 15 * 0.92);
INSERT INTO tb_Venda
    VALUES ('04/03/2023 09:00:00',
        (SELECT REF(p) FROM tb_Produto p WHERE cod_produto = 6),
        (SELECT REF(c) FROM tb_Cliente c WHERE cpf = '38540174804'),
        (SELECT REF(v) FROM tb_Vendedor v WHERE cpf = '25455186892'),
        (SELECT REF(f) FROM tb_Funcionario f WHERE cpf = '41582782792'),
        0.09, 7, 3.5, 3.5 * 7 * 0.91);
INSERT INTO tb_Venda
    VALUES ('05/03/2023 09:27:36',
        (SELECT REF(p) FROM tb_Produto p WHERE cod_produto = 8),
        (SELECT REF(c) FROM tb_Cliente c WHERE cpf = '29586233197'),
        (SELECT REF(v) FROM tb_Vendedor v WHERE cpf = '18041727662'),
        (SELECT REF(f) FROM tb_Funcionario f WHERE cpf = '41582782792'),
        0.06, 19, 2, 19 * 2 * 0.94);
INSERT INTO tb_Venda
    VALUES ('06/03/2023 09:00:00',
        (SELECT REF(p) FROM tb_Produto p WHERE cod_produto = 2),
        (SELECT REF(c) FROM tb_Cliente c WHERE cpf = '41582782792'),
        (SELECT REF(v) FROM tb_Vendedor v WHERE cpf = '86385882594'),
        (SELECT REF(f) FROM tb_Funcionario f WHERE cpf = '41582782792'),
        0.07, 9, 3, 3 * 9 * 0.93);
INSERT INTO tb_Venda
    VALUES ('02/03/2023 12:23:35',
        (SELECT REF(p) FROM tb_Produto p WHERE cod_produto = 5),
        (SELECT REF(c) FROM tb_Cliente c WHERE cpf = '25666674978'),
        (SELECT REF(v) FROM tb_Vendedor v WHERE cpf = '72610547200'),
        (SELECT REF(f) FROM tb_Funcionario f WHERE cpf = '06402073325'),
        0.05, 10, 1.8, 1.8 * 10 * 0.95);
INSERT INTO tb_Venda
    VALUES ('08/03/2023 10:15:00',
        (SELECT REF(p) FROM tb_Produto p WHERE cod_produto = 3),
        (SELECT REF(c) FROM tb_Cliente c WHERE cpf = '85449302711'),
        (SELECT REF(v) FROM tb_Vendedor v WHERE cpf = '21542193818'),
        (SELECT REF(f) FROM tb_Funcionario f WHERE cpf = '18041727662'),
        0.06, 8, 1.5, 1.5 * 8 * 0.94);
INSERT INTO tb_Venda
    VALUES ('09/03/2023 09:00:00',
        (SELECT REF(p) FROM tb_Produto p WHERE cod_produto = 5),
        (SELECT REF(c) FROM tb_Cliente c WHERE cpf = '44882211491'),
        (SELECT REF(v) FROM tb_Vendedor v WHERE cpf = '26348686850'),
        (SELECT REF(f) FROM tb_Funcionario f WHERE cpf = '56991573326'),
        0, 20, 2.2, 2.2 * 20 * 1);
INSERT INTO tb_Venda
    VALUES ('11/03/2023 09:00:00',
        (SELECT REF(p) FROM tb_Produto p WHERE cod_produto = 2),
        (SELECT REF(c) FROM tb_Cliente c WHERE cpf = '26348686850'),
        (SELECT REF(v) FROM tb_Vendedor v WHERE cpf = '37521229517'),
        (SELECT REF(f) FROM tb_Funcionario f WHERE cpf = '99124502227'),
        0.03, 10, 4, 4 * 10 * 0.97);
INSERT INTO tb_Venda
    VALUES ('12/03/2023 09:00:00',
        (SELECT REF(p) FROM tb_Produto p WHERE cod_produto = 6),
        (SELECT REF(c) FROM tb_Cliente c WHERE cpf = '31109286635'),
        (SELECT REF(v) FROM tb_Vendedor v WHERE cpf = '25666674978'),
        (SELECT REF(f) FROM tb_Funcionario f WHERE cpf = '56991573326'),
        0, 10, 3.5, 3.5 * 10 * 1);
INSERT INTO tb_Venda
    VALUES ('13/03/2023 09:00:00',
        (SELECT REF(p) FROM tb_Produto p WHERE cod_produto = 4),
        (SELECT REF(c) FROM tb_Cliente c WHERE cpf = '11467512060'),
        (SELECT REF(v) FROM tb_Vendedor v WHERE cpf = '24366201640'),
        (SELECT REF(f) FROM tb_Funcionario f WHERE cpf = '90805502227'),
        0.10, 15, 3, 3 * 15 * 0.9);

-- inserção na tabela disponibiliza

INSERT INTO disponibiliza(cpf_vendedor, cpf_funcionario, cod_espaco,
    hora_inicio, hora_fim, data_inicio, data_fim)
    VALUES ('72610547200', '18041727662', 1, 8, 12, '23/12/2022', '23/05/2023');
INSERT INTO disponibiliza(cpf_vendedor, cpf_funcionario, cod_espaco,
    hora_inicio, hora_fim, data_inicio, data_fim)
    VALUES ('02702912532', '06402073325', 2, 8, 12, '23/12/2022', '23/05/2023');
INSERT INTO disponibiliza(cpf_vendedor, cpf_funcionario, cod_espaco,
    hora_inicio, hora_fim, data_inicio, data_fim)
    VALUES ('21542193818', '06651573325', 3, 8, 12, '23/12/2022', '23/05/2023');
INSERT INTO disponibiliza(cpf_vendedor, cpf_funcionario, cod_espaco,
    hora_inicio, hora_fim, data_inicio, data_fim)
    VALUES ('26348686850', '06402073325', 4, 8, 12, '23/12/2022', '23/05/2023');
INSERT INTO disponibiliza(cpf_vendedor, cpf_funcionario, cod_espaco,
    hora_inicio, hora_fim, data_inicio, data_fim)
    VALUES ('37521229517', '06402073325', 5, 8, 12, '23/12/2022', '23/05/2023');
INSERT INTO disponibiliza(cpf_vendedor, cpf_funcionario, cod_espaco,
    hora_inicio, hora_fim, data_inicio, data_fim)
    VALUES ('23238276344', '06651573325', 6, 8, 12, '23/12/2022', '23/05/2023');
INSERT INTO disponibiliza(cpf_vendedor, cpf_funcionario, cod_espaco,
    hora_inicio, hora_fim, data_inicio, data_fim)
    VALUES ('11467512060', '89987766420', 7, 8, 12, '23/12/2022', '23/05/2023');
INSERT INTO disponibiliza(cpf_vendedor, cpf_funcionario, cod_espaco,
    hora_inicio, hora_fim, data_inicio, data_fim)
    VALUES ('24366201640', '40510573325', 8, 8, 12, '23/12/2022', '23/05/2023');
INSERT INTO disponibiliza(cpf_vendedor, cpf_funcionario, cod_espaco,
    hora_inicio, hora_fim, data_inicio, data_fim)
    VALUES ('25666674978', '06402073325', 9, 8, 12, '23/12/2022', '23/05/2023');
INSERT INTO disponibiliza(cpf_vendedor, cpf_funcionario, cod_espaco,
    hora_inicio, hora_fim, data_inicio, data_fim)
    VALUES ('38540174804', '06651573325', 10, 8, 12, '23/12/2022', '23/05/2023');
INSERT INTO disponibiliza(cpf_vendedor, cpf_funcionario, cod_espaco,
    hora_inicio, hora_fim, data_inicio, data_fim)
    VALUES ('41582782792', '06402073325', 0, 14, 18, '23/12/2022', '23/05/2023');
INSERT INTO disponibiliza(cpf_vendedor, cpf_funcionario, cod_espaco,
    hora_inicio, hora_fim, data_inicio, data_fim)
    VALUES ('25455186892', '07262636308', 10, 14, 18, '23/12/2022', '23/05/2023');
INSERT INTO disponibiliza(cpf_vendedor, cpf_funcionario, cod_espaco,
    hora_inicio, hora_fim, data_inicio, data_fim)
    VALUES ('18041727662', '70775502227', 7, 14, 18, '23/12/2022', '23/05/2023');
INSERT INTO disponibiliza(cpf_vendedor, cpf_funcionario, cod_espaco,
    hora_inicio, hora_fim, data_inicio, data_fim)
    VALUES ('86385882594', '70775502227', 1, 14, 18, '23/12/2022', '23/05/2023');
INSERT INTO disponibiliza(cpf_vendedor, cpf_funcionario, cod_espaco,
    hora_inicio, hora_fim, data_inicio, data_fim)
    VALUES ('62704882819', '06402073325', 3, 14, 18, '23/12/2022', '23/05/2023');
