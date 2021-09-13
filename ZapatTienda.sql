create database zapatienda;

use zapatienda;

create table cliente(
	cod_cliente int identity(1, 1) primary key,
	id_cliente bigint not null,
	nom_cliente nchar(30) not null,
	tel_cliente nchar(12) not null,
	pas_cliente nchar(10) not null
);

create table proveedor(
	cod_prov int identity(1, 1) primary key,
	nit_prov nchar(12) not null,
	nom_prov nchar(30) not null,
	dir_prov nchar(30) not null,
	tel_prov nchar(12) not null,
	rete_prov tinyint not null
);

create table articulo(
	cod_art int identity(1, 1) primary key,
	ref_art nchar(10) not null,
	nom_art nchar(30) not null,
	cod_prov int not null,
	exist_art int not null,
	prec_art int not null,
	iva_art int not null,
	foto_art nchar(10),
	desc_art nchar(50)
	CONSTRAINT FK_prv_art FOREIGN KEY (cod_prov) REFERENCES proveedor (cod_prov) ON DELETE CASCADE ON UPDATE CASCADE
);

create table cab_fact(
	nro_fact int primary key,
	fecha_fact date not null,
	cod_cliente int not null
	CONSTRAINT FK_cte_cabf FOREIGN KEY (cod_cliente) REFERENCES cliente (cod_cliente) ON DELETE CASCADE ON UPDATE CASCADE
);

create table det_fact(
	nro_fact int,
	cod_art int,
	cant_art int not null,
	subt_art int not null,
	iva_art int not null,
	CONSTRAINT PK_detf PRIMARY KEY CLUSTERED (nro_fact ASC, cod_art ASC),
	CONSTRAINT FK_cabf_detf FOREIGN KEY (nro_fact) REFERENCES cab_fact (nro_fact) ON DELETE CASCADE ON UPDATE CASCADE,
	CONSTRAINT FK_art_detf FOREIGN KEY (cod_art) REFERENCES articulo (cod_art) ON DELETE CASCADE ON UPDATE CASCADE
);

create table cab_compra(
	nro_fact nchar(12) primary key,
	fecha_fact date not null,
	cod_prov int not null
	CONSTRAINT FK_prov_cabc FOREIGN KEY (cod_prov) REFERENCES proveedor (cod_prov) ON DELETE CASCADE ON UPDATE CASCADE
);

create table det_compra(
	nro_fact nchar(12),
	cod_art int,
	cant_art int not null,
	subt_art int not null,
	CONSTRAINT PK_detc PRIMARY KEY CLUSTERED (nro_fact ASC, cod_art ASC),
	CONSTRAINT FK_cabc_detc FOREIGN KEY (nro_fact) REFERENCES cab_compra (nro_fact) ON DELETE CASCADE ON UPDATE CASCADE,
	CONSTRAINT FK_art_detc FOREIGN KEY (cod_art) REFERENCES articulo (cod_art)
);

create table usuario(
	cod_user int identity(1, 1) primary key,
	id_user nchar(12) not null,
	nom_user nchar(30) not null,
	pas_user nchar(10) not null
);