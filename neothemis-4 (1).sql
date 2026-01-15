# Andre Ferreira Dias RGM: 11251100724
# Guilherme Borges RGM: 11251100564
#Igor Dias Viana RGM: 11251100289
#Glaucio dos Santos Abrantes Soares RGM: 11251100887
#Renan Pereira Andreata RGM: 112500818

#Número da equipe: 12

create database neothemis;
use neothemis;

create table cliente (
    id_cliente int primary key,
    nome varchar(100) not null,
    cpf decimal(11) unique not null,
    email varchar(100) not null,
    telefone decimal(11) not null,
    endereco varchar(200),
    status enum('Ativo','Inativo')
);
create table advogado (
    id_advogado int primary key,
    nome varchar(100) not null,
    oab decimal(6) unique not null,
    email varchar(100),
    telefone decimal(11),
    cargo varchar(50),
    status enum('Ativo','Inativo')
);

create table processo (
    id_processo int primary key,
    numero varchar(50) not null,
    tipo_acao varchar(100) not null,
    descricao varchar(500),
    status enum('Aberto','Finalizado'),
    data_abertura datetime default now(),
    id_cliente int,
    id_adv_resp int,
    constraint fk_cliente foreign key (id_cliente) 
    references cliente(id_cliente),
    constraint fk_advogado foreign key (id_adv_resp) 
    references advogado(id_advogado)
);

create table documento (
    id_documento int primary key,
    titulo varchar(100),
    tipo_doc varchar(50),
    data_envio date,
    arquivo_url varchar(300),
    id_processo int,
    status enum('Ativo','Inativo') default 'Ativo',
    constraint fk_processo foreign key (id_processo) 
    references processo(id_processo)
);
create table andamento (
    id_andamento int primary key,
    data_anda date,
    descricao varchar(500),
    id_processo int,
    status enum('Ativo','Inativo') default 'Ativo',
    constraint fk_pro_anda foreign key (id_processo)
    references processo(id_processo)
);
create table audiencia (
    id_audiencia int primary key,
    data_hora datetime,
    local varchar(100),
    observacoes varchar(500),
    id_processo int,
    status enum('Ativo','Inativo') default 'Ativo',
    constraint fk_id_pro_audi foreign key (id_processo) 
    references processo(id_processo)
);

create table controle_usuario (
    id_usuario int primary key auto_increment,
    nome varchar(200) not null,
    email varchar(100) unique not null,
    senha varchar(255) not null,
    perfil enum('Administrador_Global','Administrador_Escritorio','Gestor','Advogado','Estagiario','Cliente') not null,
    status enum('ativo','inativo') default 'ativo',
    data_criacao datetime default Now()
); #prof usei enum aqui pq achei q usar o check ia ficar meio ruim, se n for permitido depois mudo

insert into cliente values 	
(1, 'Joao', 12345678901, 'joao@gmail.com', 11987654321, 'Rua das Flores, 123','Ativo'),
(2, 'Pedro', 98765432100, 'pedro@gmail.com', 11999887766, 'Av. Paulista, 200','Ativo'),
(3, 'Renan', 45678912300, 'renan@gmail.com', 11933445566, 'Rua Verde, 50','Ativo'),
(4, 'Carlos', 32165498700, 'carlos@gmail.com', 11988776655, 'Rua Azul, 800','Ativo'),
(5, 'Igor', 78945612300, 'igor@gmail.com', 11944556677, 'Praça Central, 12','Ativo'),
(6, 'Gabriel', 12345612300, 'gabis@gmail.com', 11897556677, 'Rua da praia verde, 20','Ativo');

insert into advogado values 	
(1, 'Jose', 123456, 'jose.adv@gmail.com', 11999998888, 'Cível','Ativo'),
(2, 'Mariana', 234567, 'mariana.adv@gmail.com', 11911112222, 'Trabalhista','Ativo'),
(3, 'Ronaldo', 345678, 'ronaldo.adv@gmail.com', 11922223333, 'Penal','Ativo'),
(4, 'Fernanda', 456789, 'fernanda.adv@gmail.com', 11933334444, 'Família','Ativo'),
(5, 'Gustavo', 567890, 'gustavo.adv@gmail.com', 11944445555, 'Tributário','Ativo'),
(6, 'Leticia', 523890, 'lele.adv@gmail.com', 11942345555, 'Tributário','Ativo');


insert into processo values
(1, 'P001', 'Divórcio', 'Separação amigável', 'Em andamento', '2024-03-10', (select cliente.id_cliente from cliente where id_cliente = 1), (select advogado.id_advogado from advogado where id_advogado = 4)),
(2, 'P002', 'Ação trabalhista', 'Reivindicação salarial', 'Aberto', '2023-11-05',(select cliente.id_cliente from cliente where id_cliente = 2), (select advogado.id_advogado from advogado where id_advogado = 2)),
(3, 'P003', 'Ação penal', 'Investigação de furto', 'Arquivado', '2022-08-22', (select cliente.id_cliente from cliente where id_cliente = 3), (select advogado.id_advogado from advogado where id_advogado = 3)),
(4, 'P004', 'Danos morais', 'Indenização por calúnia', 'Concluído', '2023-05-18',(select cliente.id_cliente from cliente where id_cliente = 4), (select advogado.id_advogado from advogado where id_advogado = 1)),
(5, 'P005', 'Ação tributária', 'Revisão de impostos', 'Em andamento', '2024-02-01', (select cliente.id_cliente from cliente where id_cliente = 5), (select advogado.id_advogado from advogado where id_advogado = 5)),
(6, 'P006', 'Ação tributária', 'Revisão de impostos', 'Em andamento', '2025-12-01', (select cliente.id_cliente from cliente where id_cliente = 6), (select advogado.id_advogado from advogado where id_advogado = 6));

insert into documento values 	
(1, 'Petição Inicial', 'PDF', '2024-03-11', 'docs/peticao_inicial.pdf', (select processo.id_processo from processo where id_processo = 1)),
(2, 'Contrato de Trabalho', 'DOCX', '2023-11-10', 'docs/contrato_trabalho.docx', (select processo.id_processo from processo where id_processo = 2)),
(3, 'Boletim de Ocorrência', 'PDF', '2022-08-25', 'docs/boletim.pdf', (select processo.id_processo from processo where id_processo = 3)),
(4, 'Comprovante Bancário', 'PDF', '2023-05-20', 'docs/comprovante.pdf',(select processo.id_processo from processo where id_processo = 4)),
(5, 'Declaração Fiscal', 'PDF', '2024-02-03', 'docs/declaracao.pdf',(select processo.id_processo from processo where id_processo = 5)),
(6, 'Declaração Fiscal', 'PDF', '2025-12-01', 'docs/declaracao.pdf',(select processo.id_processo from processo where id_processo = 6));

insert into andamento values 	
(1, '2024-03-15', 'Audiência de conciliação marcada', (select processo.id_processo from processo where id_processo = 1)),
(2, '2023-11-20', 'Empresa apresentou defesa', (select processo.id_processo from processo where id_processo = 2)),
(3, '2022-09-10', 'Processo encerrado', (select processo.id_processo from processo where id_processo = 3)),
(4, '2023-06-01', 'Audiência finalizada com acordo',(select processo.id_processo from processo where id_processo = 4)),
(5, '2024-02-10', 'Perícia solicitada', (select processo.id_processo from processo where id_processo = 5)),
(6, '2025-12-10', 'Perícia solicitada', (select processo.id_processo from processo where id_processo = 6));

insert into audiencia values 	
(1, '2024-04-01 14:00:00', 'Fórum Central - Sala 3', 'Audiência de conciliação', (select processo.id_processo from processo where id_processo = 1)),
(2, '2023-12-10 09:00:00', 'Fórum Trabalhista - Sala 5', 'Audiência de instrução', (select processo.id_processo from processo where id_processo = 2)),
(3, '2022-09-12 16:00:00', 'Fórum Criminal - Sala 2', 'Audiência de encerramento', (select processo.id_processo from processo where id_processo = 3)),
(4, '2023-06-05 10:00:00', 'Fórum Cível - Sala 1', 'Acordo homologado', (select processo.id_processo from processo where id_processo = 4)),
(5, '2024-03-15 11:30:00', 'Fórum Tributário - Sala 4', 'Audiência de análise fiscal', (select processo.id_processo from processo where id_processo = 5)),
(6, '2025-12-15 12:30:00', 'Fórum Tributário - Sala 3', 'Audiência de análise fiscal', (select processo.id_processo from processo where id_processo = 6));


select * from cliente;


# view pra puxar nome do processo, andamento

create view processo_usuario (advogado, processo, andamento) as
select advogado.nome, processo.numero, andamento.descricao
from advogado, processo, andamento
where processo.id_processo = andamento.id_processo and 
advogado.id_advogado = processo.id_processo
order by processo.id_processo;

select * from processo_usuario;

# view para puxar advogado, e quantidade de processos

create view advogado_processo (advogado, quantidade) as
select advogado.nome, count(*)
from advogado, processo
where advogado.id_advogado = processo.id_adv_resp
group by processo.id_processo
order by advogado.nome;

select * from advogado_processo;

#view pra apresentar a quantidade de processos agrupados por status

create view processo_status (status, quantidade) as
select processo.status, count(*)
from processo
where processo.status is not null
group by processo.status
order by count(*) desc;

select * from processo_status;

#view pra mostrar todos os processos por cliente

create view historico_cliente1 (cliente, processo, status, andamento, documento, tipo_doc, data_doc) as
select cliente.nome, processo.numero, processo.status, andamento.descricao, documento.titulo, documento.tipo_doc, documento.data_envio
from cliente, processo, andamento, documento
where processo.id_cliente = cliente.id_cliente
and andamento.id_processo = processo.id_processo
and documento.id_processo = processo.id_processo
order by cliente.nome, processo.numero, andamento.data_anda;

select * from historico_cliente1;

#view pra listar todas as próximas audiências com detalhes dos processo comparando com a data atual

create view audiencias_proximas (processo, tipo_acao, data_audiencia, local_audiencia, observacoes) as
select processo.numero, processo.tipo_acao, audiencia.data_hora, audiencia.local, audiencia.observacoes
from processo, audiencia
where processo.id_processo = audiencia.id_processo
and audiencia.data_hora > NOW()
order by audiencia.data_hora;

select * from audiencias_proximas;

#view pra mostra os documentos divididos por tipo para cada processo

create view documentos_por_processo (numero_processo, tipo_acao, total_documentos, tipos_distintos) as
select processo.numero, processo.tipo_acao, COUNT(documento.id_documento), COUNT(distinct documento.tipo_doc)
from processo, documento
where processo.id_processo = documento.id_processo
group by processo.id_processo, processo.numero, processo.tipo_acao
order by processo.numero desc;
#coloquei o dinstict aqui pra ele contar todos os documentos diferentes (se tiver errado depois tiro)
select * from documentos_por_processo;

#indices

#indice para relacionar processos e clientes
create index idx_processo_cliente 
on processo (id_cliente);

#indice para otimizar as consultas por advogado
create index idx_processo_advogado 
on processo (id_adv_resp);

#indice para melhorar desempenho das auditorias e históricos processuais
create index idx_andamento_processo_data 
on andamento (id_processo, data_anda);

#adicionei eses alter table aqui pra adicionar a coluna status em todo mundo que eu ia precisar pra fazer exlusão logica
alter table documento
add column status enum('Ativo','Inativo') default 'Ativo';

alter table andamento
add column status enum('Ativo','Inativo') default 'Ativo';

alter table audiencia
add column status enum('Ativo','Inativo') default 'Ativo';

#as procedures :)

delimiter \\

#tabela do cliente
#insert
create procedure insert_cliente(
  in p_id_cliente int,
  in p_nome varchar(100),
  in p_cpf decimal(11),
  in p_email varchar(100),
  in p_telefone decimal(11),
  in p_endereco varchar(200)
)
begin
  insert into cliente (id_cliente, nome, cpf, email, telefone, endereco, status)
  values (p_id_cliente, p_nome, p_cpf, p_email, p_telefone, p_endereco, 'Ativo');
end \\

delimiter ;

delimiter \\
#update
create procedure update_cliente(
  in p_id_cliente int,
  in p_nome varchar(100),
  in p_cpf decimal(11),
  in p_email varchar(100),
  in p_telefone decimal(11),
  in p_endereco varchar(200),
  in p_status enum('Ativo','Inativo')
)
begin
  declare se_existe int default 0;
  select count(*) into se_existe from cliente where id_cliente = p_id_cliente;
  if se_existe = 0 then
    select 'Cliente não encontrado' as mensagem_de_erro;
  else
    update cliente set
      nome = p_nome,
      cpf = p_cpf,
      email = p_email,
      telefone = p_telefone,
      endereco = p_endereco,
      status = p_status
    where id_cliente = p_id_cliente;
  end if;
end \\

delimiter ;

delimiter \\
#exclusão logica do cliente
create procedure delete_cliente_logico(
  in p_id_cliente int
)
begin
  declare se_existe int default 0;
  select count(*) into se_existe from cliente where id_cliente = p_id_cliente;
  if se_existe = 0 then
    select 'Cliente não encontrado' as mensagem_de_erro;
  else
    update cliente set status = 'Inativo' where id_cliente = p_id_cliente;
  end if;
end \\

delimiter ;

#tabela de advogados

delimiter \\
#insert
create procedure insert_advogado(
  in p_id_advogado int,
  in p_nome varchar(100),
  in p_oab decimal(6),
  in p_email varchar(100),
  in p_telefone decimal(11),
  in p_cargo varchar(50)
)
begin
  insert into advogado (id_advogado, nome, oab, email, telefone, cargo, status)
  values (p_id_advogado, p_nome, p_oab, p_email, p_telefone, p_cargo, 'Ativo');
end \\

delimiter ;

delimiter \\
#update
create procedure update_advogado(
  in p_id_advogado int,
  in p_nome varchar(100),
  in p_oab decimal(6),
  in p_email varchar(100),
  in p_telefone decimal(11),
  in p_cargo varchar(50),
  in p_status enum('Ativo','Inativo')
)
begin
  declare se_existe int default 0;
  select count(*) into se_existe from advogado where id_advogado = p_id_advogado;
  if se_existe = 0 then
    select 'Advogado não encontrado' as mensagem_de_erro;
  else
    update advogado set
      nome = p_nome,
      oab = p_oab,
      email = p_email,
      telefone = p_telefone,
      cargo = p_cargo,
      status = p_status
    where id_advogado = p_id_advogado;
  end if;
end \\

delimiter ;
delimiter \\

#exclusão logica
create procedure delete_advogado_logico(
  in p_id_advogado int
)
begin
  declare se_existe int default 0;
  select count(*) into se_existe from advogado where id_advogado = p_id_advogado;
  if se_existe = 0 then
    select 'Advogado não encontrado' as mensagem_de_erro;
  else
    update advogado set status = 'Inativo' where id_advogado = p_id_advogado;
  end if;
end \\

delimiter ;

#tabela de processos

delimiter \\

#insert
create procedure insert_processo(
  in p_id_processo int,
  in p_numero varchar(50),
  in p_tipo_acao varchar(100),
  in p_descricao varchar(500),
  in p_status varchar(50),
  in p_data_abertura datetime,
  in p_id_cliente int,
  in p_id_adv_resp int
)
begin
  declare se_existe_cli int default 0;
  declare se_existe_adv int default 0;

  select count(*) into se_existe_cli from cliente where id_cliente = p_id_cliente;
  select count(*) into se_existe_adv from advogado where id_advogado = p_id_adv_resp;

  if se_existe_cli = 0 then
    select 'Cliente não existe' as mensagem_de_erro_cli;
  elseif se_existe_adv = 0 then
    select 'Advogado não existe' as mensagem_de_erro_adv;
  else
    insert into processo (id_processo, numero, tipo_acao, descricao, status, data_abertura, id_cliente, id_adv_resp)
    values (p_id_processo, p_numero, p_tipo_acao, p_descricao, p_status, p_data_abertura, p_id_cliente, p_id_adv_resp);
  end if;
end \\

delimiter ;

delimiter \\
#update
create procedure update_processo(
  in p_id_processo int,
  in p_numero varchar(50),
  in p_tipo_acao varchar(100),
  in p_descricao varchar(500),
  in p_status varchar(50),
  in p_id_cliente int,
  in p_id_adv_resp int
)
begin
  declare se_existe int default 0;
  declare se_existe_cli int default 0;
  declare se_existe_adv int default 0;

  select count(*) into se_existe from processo where id_processo = p_id_processo;
  if se_existe = 0 then
    select 'Processo não encontrado' as mensagem_de_erro;
  else
    select count(*) into se_existe_cli from cliente where id_cliente = p_id_cliente;
    select count(*) into se_existe_adv from advogado where id_advogado = p_id_adv_resp;

    if se_existe_cli = 0 then
      select 'Cliente não existe' as mensagem_de_erro_cli;
    elseif se_existe_adv = 0 then
      select 'Advogado não existe' as mensagem_de_erro_cli;
    else
      update processo set
        numero = p_numero,
        tipo_acao = p_tipo_acao,
        descricao = p_descricao,
        status = p_status,
        id_cliente = p_id_cliente,
        id_adv_resp = p_id_adv_resp
      where id_processo = p_id_processo;
    end if;
  end if;
end \\

delimiter ;

delimiter \\
#exclusão logica
create procedure delete_processo_logico(
  in p_id_processo int
)
begin
  declare se_existe int default 0;
  select count(*) into se_existe from processo where id_processo = p_id_processo;
  if se_existe = 0 then
    select 'Processo não encontrado' as mensagem_de_erro;
  else
    update processo set status = 'Finalizado' where id_processo = p_id_processo;
  end if;
end \\

delimiter ;

#table de documento

delimiter \\

#insert
create procedure insert_documento(
  in p_id_documento int,
  in p_titulo varchar(100),
  in p_tipo_doc varchar(50),
  in p_data_envio date,
  in p_arquivo_url varchar(300),
  in p_id_processo int
)
begin
  declare se_existe_proc int default 0;
  select count(*) into se_existe_proc from processo where id_processo = p_id_processo;
  if se_existe_proc = 0 then
    select 'Processo não existe' as mensagem_de_erro;
  else
    insert into documento (id_documento, titulo, tipo_doc, data_envio, arquivo_url, id_processo, status)
    values (p_id_documento, p_titulo, p_tipo_doc, p_data_envio, p_arquivo_url, p_id_processo, 'Ativo');
  end if;
end \\

delimiter ;

delimiter \\

#update
create procedure update_documento(
  in p_id_documento int,
  in p_titulo varchar(100),
  in p_tipo_doc varchar(50),
  in p_data_envio date,
  in p_arquivo_url varchar(300),
  in p_id_processo int,
  in p_status enum('Ativo','Inativo')
)
begin
  declare se_existe int default 0;
  declare se_existe_proc int default 0;
  select count(*) into se_existe from documento where id_documento = p_id_documento;
  select count(*) into se_existe_proc from processo where id_processo = p_id_processo;
  if se_existe = 0 then
    select 'Documento não encontrado' as mensagem_de_erro;
  elseif se_existe_proc = 0 then
    select 'Processo não existe' as mensagem_de_erro_pro;
  else
    update documento set
      titulo = p_titulo,
      tipo_doc = p_tipo_doc,
      data_envio = p_data_envio,
      arquivo_url = p_arquivo_url,
      id_processo = p_id_processo,
      status = p_status
    where id_documento = p_id_documento;
  end if;
end \\

delimiter ;

#exclusão logica

delimiter \\

create procedure delete_documento_logico(
  in p_id_documento int
)
begin
  declare se_existe int default 0;
  select count(*) into se_existe from documento where id_documento = p_id_documento;
  if se_existe = 0 then
    select 'Documento não encontrado' as mensagem_de_erro;
  else
    update documento set status = 'Inativo' where id_documento = p_id_documento;
  end if;
end \\

delimiter ;

delimiter \\

#tabela andamento
#insert
create procedure insert_andamento(
  in p_id_andamento int,
  in p_data_anda date,
  in p_descricao varchar(500),
  in p_id_processo int
)
begin
  declare se_existe_proc int default 0;
  select count(*) into se_existe_proc from processo where id_processo = p_id_processo;
  if se_existe_proc = 0 then
    select 'Processo não existe' as mensagem_de_erro;
  else
    insert into andamento (id_andamento, data_anda, descricao, id_processo, status)
    values (p_id_andamento, p_data_anda, p_descricao, p_id_processo, 'Ativo');
  end if;
end \\

delimiter ;
delimiter \\

#update
create procedure update_andamento(
  in p_id_andamento int,
  in p_data_anda date,
  in p_descricao varchar(500),
  in p_id_processo int,
  in p_status enum('Ativo','Inativo')
)
begin
  declare se_existe int default 0;
  declare se_existe_proc int default 0;
  select count(*) into se_existe from andamento where id_andamento = p_id_andamento;
  select count(*) into se_existe_proc from processo where id_processo = p_id_processo;
  if se_existe = 0 then
    select 'Andamento não encontrado' as mensagem_de_erro;
  elseif se_existe_proc = 0 then
    select 'Processo não existe' as mensagem_de_erro_proc;
  else
    update andamento set
      data_anda = p_data_anda,
      descricao = p_descricao,
      id_processo = p_id_processo,
      status = p_status
    where id_andamento = p_id_andamento;
  end if;
end \\

delimiter ;
delimiter \\

#exclusão logica
create procedure delete_andamento_logico(
  in p_id_andamento int
)
begin
  declare se_existe int default 0;
  select count(*) into se_existe from andamento where id_andamento = p_id_andamento;
  if se_existe = 0 then
    select 'Andamento não encontrado' as mensagem_de_erro;
  else
    update andamento set status = 'Inativo' where id_andamento = p_id_andamento;
  end if;
end \\

delimiter ;

delimiter \\
#tabela de audiencia
#insert
create procedure insert_audiencia(
  in p_id_audiencia int,
  in p_data_hora datetime,
  in p_local varchar(100),
  in p_observacoes varchar(500),
  in p_id_processo int
)
begin
  declare se_existe_proc int default 0;
  select count(*) into se_existe_proc from processo where id_processo = p_id_processo;
  if se_existe_proc = 0 then
    select 'Processo não existe' as mensagem_de_erro;
  else
    insert into audiencia (id_audiencia, data_hora, local, observacoes, id_processo, status)
    values (p_id_audiencia, p_data_hora, p_local, p_observacoes, p_id_processo, 'Ativo');
  end if;
end \\

delimiter ;
delimiter \\

#update
create procedure update_audiencia(
  in p_id_audiencia int,
  in p_data_hora datetime,
  in p_local varchar(100),
  in p_observacoes varchar(500),
  in p_id_processo int,
  in p_status enum('Ativo','Inativo')
)
begin
  declare se_existe int default 0;
  declare se_existe_proc int default 0;
  select count(*) into se_existe from audiencia where id_audiencia = p_id_audiencia;
  select count(*) into se_existe_proc from processo where id_processo = p_id_processo;
  if se_existe = 0 then
    select 'Audiência não encontrada' as mensagem_de_erro;
  elseif se_existe_proc = 0 then
    select 'Processo não existe' as mensagem_de_erro_proc;
  else
    update audiencia set
      data_hora = p_data_hora,
      local = p_local,
      observacoes = p_observacoes,
      id_processo = p_id_processo,
      status = p_status
    where id_audiencia = p_id_audiencia;
  end if;
end \\

delimiter ;
delimiter \\

#exclusão logica
create procedure delete_audiencia_logico(
  in p_id_audiencia int
)
begin
  declare se_existe int default 0;
  select count(*) into se_existe from audiencia where id_audiencia = p_id_audiencia;
  if se_existe = 0 then
    select 'Audiência não encontrada' as mensagem_de_erro;
  else
    update audiencia set status = 'Inativo' where id_audiencia = p_id_audiencia;
  end if;
end \\

delimiter ;
delimiter \\

#tabela de controle de usuario
#insert
create procedure insert_controle_usuario(
  in p_nome varchar(200),
  in p_email varchar(100),
  in p_senha varchar(255),
  in p_perfil enum('Administrador_Global','Administrador_Escritorio','Gestor','Advogado','Estagiario','Cliente')
)
begin
  insert into controle_usuario (nome, email, senha, perfil, status)
  values (p_nome, p_email, p_senha, p_perfil, 'ativo');
end \\

delimiter ;
delimiter \\

#update
create procedure update_controle_usuario(
  in p_id_usuario int,
  in p_nome varchar(200),
  in p_email varchar(100),
  in p_senha varchar(255),
  in p_perfil enum('Administrador_Global','Administrador_Escritorio','Gestor','Advogado','Estagiario','Cliente'),
  in p_status enum('ativo','inativo')
)
begin
  declare se_existe int default 0;
  select count(*) into se_existe from controle_usuario where id_usuario = p_id_usuario;
  if se_existe = 0 then
    select 'Usuário não encontrado' as mensagem_de_erro;
  else
    update controle_usuario set
      nome = p_nome,
      email = p_email,
      senha = p_senha,
      perfil = p_perfil,
      status = p_status
    where id_usuario = p_id_usuario;
  end if;
end \\

delimiter ;
delimiter \\

#exclusão logica
create procedure delete_controle_usuario_logico(
  in p_id_usuario int
)
begin
  declare se_existe int default 0;
  select count(*) into se_existe from controle_usuario where id_usuario = p_id_usuario;
  if se_existe = 0 then
    select 'Usuário não encontrado' as mensagem_de_erro;
  else
    update controle_usuario set status = 'inativo' where id_usuario = p_id_usuario;
  end if;
end \\

delimiter ;


#trigger da rn

#essa trigger valida existência do processo e impede agendamento se o processo estiver finalizado
delimiter \\
create trigger trg_antes_insert_audiencia
before insert on audiencia
for each row
begin
  declare v_count int;
  declare v_status varchar(50);

  select count(*), status into v_count, v_status
  from processo
  where id_processo = new.id_processo;

#nos dois ifs abaixo eu usei o signal sqlstate pra criar um erro manualmente, eu pesquisei como q poderia devolver
#resultado dentro da trigger e acabei achando o signal q acabo ficando perfeito, e pelo que vi usa esse codigo de 45000 diz 
#pro sistema q é um erro feito pelo usuario, ai usei isso pra devolver um erro pra cada if

  if v_count = 0 then 
  signal sqlstate '45000' 
  set message_text = 'Erro: processo não existe'; 
  end if; 
    
  if v_status = 'Finalizado' then 
  signal sqlstate '45000' 
  set message_text = 'Erro: processo finalizado então não é permitido agendamento'; 
  end if;
end \\

#essa trigger garante que processo fique em andamento e cria registro de andamento
create trigger trg_apos_insert_audiencia
after insert on audiencia
for each row
begin
  declare v_next int;
 
  update processo
  set status = 'Em andamento'
  where id_processo = new.id_processo;

  select ifnull(max(id_andamento), 0) + 1 into v_next from andamento;
  #fiz esse select aqui q basicamente usa o if null pra verificar se o id_andamento é vazio, se ele for ele coloca um 0 
  #no lugar e depois adiciona mais um, eu poderia resolver isso so transformando a id 
  #em auto increment mas ja foi, n vou mudar tudo la atras n :)
  
  insert into andamento (id_andamento, data_anda, descricao, id_processo, status)
  values (
    v_next,
    date(new.data_hora),
    concat('Audiência agendada: ', new.data_hora, ' - ', new.local),
    #usei um concat aqui pra deixar pronto a estrutura do texto da descrição invez de digitar algo aleatorio e fora de padrão toda vez
    new.id_processo,
    'Ativo'
  );
end \\

delimiter ;

