create schema petshopADS;

show databases;

use petshopADS;

-- Criando a tabela Cliente
create table Cliente(
	cpf varchar(14) primary key not null,
    nome varchar(60) not null,
    numTelefone varchar(11) not null,
    numTelefone2 varchar(11) null,
    email varchar(60) unique null,
    corresponsavel varchar(60) null
);

show tables;

desc cliente;

create table Endereco(
	Cliente_cpf varchar(14) primary key not null,
    uf char(2) not null,
    cidade varchar(45) not null,
    bairro varchar(45) not null,
	rua varchar(45) not null,
    numero int null,
    comp varchar(45) null,
    cep char(9) not null,
    foreign key(Cliente_cpf) references Cliente(cpf)
		on update cascade
        on delete cascade
);

drop database petshop;

drop table endereco;

create table PET(
	idPET int primary key auto_increment not null,
    nome varchar(45) not null,
	idade int null, 
    especie varchar(45) not null, 
    raca varchar(45) not null,
    cor varchar(45) not null,
    porte varchar(45) null,
    peso decimal(5,2) null,
    alergia varchar(80) null,
    obs varchar(150) null,
    Cliente_cpf varchar(14) not null,
    foreign key(Cliente_cpf) references Cliente(cpf)
		on update cascade
        on delete cascade
);





