create database neothemis;
use neothemis;

create table cliente (
    id_cliente 	int primary key,
    nome 		varchar(100) not null,
    cpf 		decimal(11) unique not null,
    email 		varchar(100),
    telefone 	decimal(11),
    endereco 	varchar(200)
);
create table advogado (
    id_advogado int primary key,
    nome 		varchar(100) not null,
    oab 		decimal(6) unique not null,
    email 		varchar(100),
    telefone 	decimal(11),
    cargo 		varchar(50)
);

create table processo (
    id_processo int primary key,
    numero 		varchar(50) not null,
    tipo_acao 	varchar(100) not null,
    descricao 	varchar(500),
    status 		varchar(50),
    data_abertura date,
    id_cliente 	int,
    id_adv_resp int,
    constraint fk_cliente foreign key (id_cliente) 
    references cliente(id_cliente),
    constraint fk_advogado foreign key (id_adv_resp) 
    references advogado(id_advogado)
);

create table documento (
    id_documento int primary key,
    titulo 		 varchar(100),
    tipo_doc 	 varchar(50),
    data_envio 	 date,
    arquivo_url  varchar(300),
    id_processo  int,
    constraint fk_processo foreign key (id_processo) 
    references processo(id_processo)
);
create table andamento (
    id_andamento int primary key,
    data_anda date,
    descricao varchar(500),
    id_processo int,
    constraint fk_pro_anda foreign key (id_processo)
    references processo(id_processo)
);
create table audiencia (
    id_audiencia int primary key,
    data_hora datetime,
    local varchar(100),
    observacoes varchar(500),
    id_processo int,
    constraint fk_id_pro_audi foreign key (id_processo) 
    references processo(id_processo)
);


insert into cliente values 	
(1, 'Joao', 12345678901, 'joao@gmail.com', 11987654321, 'Rua das Flores, 123'),
(2, 'Pedro', 98765432100, 'pedro@gmail.com', 11999887766, 'Av. Paulista, 200'),
(3, 'Renan', 45678912300, 'renan@gmail.com', 11933445566, 'Rua Verde, 50'),
(4, 'Carlos', 32165498700, 'carlos@gmail.com', 11988776655, 'Rua Azul, 800'),
(5, 'Igor', 78945612300, 'igor@gmail.com', 11944556677, 'Praça Central, 12');

insert into advogado values 	
(1, 'Jose', 123456, 'jose.adv@gmail.com', 11999998888, 'Cível'),
(2, 'Mariana', 234567, 'mariana.adv@gmail.com', 11911112222, 'Trabalhista'),
(3, 'Ronaldo', 345678, 'ronaldo.adv@gmail.com', 11922223333, 'Penal'),
(4, 'Fernanda', 456789, 'fernanda.adv@gmail.com', 11933334444, 'Família'),
(5, 'Gustavo', 567890, 'gustavo.adv@gmail.com', 11944445555, 'Tributário');


insert into processo values
(1, 'P001', 'Divórcio', 'Separação amigável', 'Em andamento', '2024-03-10', (select cliente.id_cliente from cliente where id_cliente = 1), (select advogado.id_advogado from advogado where id_advogado = 4)),
(2, 'P002', 'Ação trabalhista', 'Reivindicação salarial', 'Aberto', '2023-11-05',(select cliente.id_cliente from cliente where id_cliente = 2), (select advogado.id_advogado from advogado where id_advogado = 2)),
(3, 'P003', 'Ação penal', 'Investigação de furto', 'Arquivado', '2022-08-22', (select cliente.id_cliente from cliente where id_cliente = 3), (select advogado.id_advogado from advogado where id_advogado = 3)),
(4, 'P004', 'Danos morais', 'Indenização por calúnia', 'Concluído', '2023-05-18',(select cliente.id_cliente from cliente where id_cliente = 4), (select advogado.id_advogado from advogado where id_advogado = 1)),
(5, 'P005', 'Ação tributária', 'Revisão de impostos', 'Em andamento', '2024-02-01', (select cliente.id_cliente from cliente where id_cliente = 5), (select advogado.id_advogado from advogado where id_advogado = 5));

insert into documento values 	
(1, 'Petição Inicial', 'PDF', '2024-03-11', 'docs/peticao_inicial.pdf', (select processo.id_processo from processo where id_processo = 1)),
(2, 'Contrato de Trabalho', 'DOCX', '2023-11-10', 'docs/contrato_trabalho.docx', (select processo.id_processo from processo where id_processo = 2)),
(3, 'Boletim de Ocorrência', 'PDF', '2022-08-25', 'docs/boletim.pdf', (select processo.id_processo from processo where id_processo = 3)),
(4, 'Comprovante Bancário', 'PDF', '2023-05-20', 'docs/comprovante.pdf',(select processo.id_processo from processo where id_processo = 4)),
(5, 'Declaração Fiscal', 'PDF', '2024-02-03', 'docs/declaracao.pdf',(select processo.id_processo from processo where id_processo = 5));

insert into andamento values 	
(1, '2024-03-15', 'Audiência de conciliação marcada', (select processo.id_processo from processo where id_processo = 1)),
(2, '2023-11-20', 'Empresa apresentou defesa', (select processo.id_processo from processo where id_processo = 2)),
(3, '2022-09-10', 'Processo encerrado', (select processo.id_processo from processo where id_processo = 3)),
(4, '2023-06-01', 'Audiência finalizada com acordo',(select processo.id_processo from processo where id_processo = 4)),
(5, '2024-02-10', 'Perícia solicitada', (select processo.id_processo from processo where id_processo = 5));

insert into audiencia values 	
(1, '2024-04-01 14:00:00', 'Fórum Central - Sala 3', 'Audiência de conciliação', (select processo.id_processo from processo where id_processo = 1)),
(2, '2023-12-10 09:00:00', 'Fórum Trabalhista - Sala 5', 'Audiência de instrução', (select processo.id_processo from processo where id_processo = 2)),
(3, '2022-09-12 16:00:00', 'Fórum Criminal - Sala 2', 'Audiência de encerramento', (select processo.id_processo from processo where id_processo = 3)),
(4, '2023-06-05 10:00:00', 'Fórum Cível - Sala 1', 'Acordo homologado', (select processo.id_processo from processo where id_processo = 4)),
(5, '2024-03-15 11:30:00', 'Fórum Tributário - Sala 4', 'Audiência de análise fiscal', (select processo.id_processo from processo where id_processo = 5));


