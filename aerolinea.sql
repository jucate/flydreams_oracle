drop table AEROPUERTO cascade constraints;
drop table TIPO_AVION cascade constraints;
drop table AVION cascade constraints;
drop table GENERO cascade constraints;
drop table PERSONA cascade constraints;
drop table AZAFATA cascade constraints;
drop table PILOTO cascade constraints;
drop table PILOTA cascade constraints;
drop table PASAJERO cascade constraints;
drop table TAMANIO_EQUIPAJE cascade constraints;
drop table EQUIPAJE cascade constraints;
drop table BOLETO cascade constraints;
drop table VUELO cascade constraints;
drop table POSEE cascade constraints;
drop table SE_ASIGNA cascade constraints;


/*==============================================================*/
/* Table: AEROPUERTO                                            */
/*==============================================================*/
create table AEROPUERTO 
(
   AEROPUERTO_ID        NUMBER(10)               not null,
   NOMBRE               VARCHAR2(10)         not null,
   PAIS                 VARCHAR2(10)         not null,
   CIUDAD               VARCHAR2(10)         not null,
   constraint PK_AEROPUERTO primary key (AEROPUERTO_ID)
);



/*==============================================================*/
/* Table: TIPO_AVION                                            */
/*==============================================================*/
create table TIPO_AVION 
(
   TIPO_ID              NUMBER(10)         not null,
   TIPO_AVION           VARCHAR2(10)       not null,
   constraint PK_TIPO_AVION primary key (TIPO_ID)
);

/*==============================================================*/
/* Table: AVION                                                 */
/*==============================================================*/
create table AVION 
(
   AVION_ID             NUMBER(10)           not null,
   TIPO_ID              NUMBER(10)           not null,
   CAPACIDAD_PASAJEROS  NUMBER(10)           not null,
   CAPACIDAD_VUELO      NUMBER(10)           not null,
   CAPACIDAD_COMBUSTIBLE NUMBER(10)          not null,
   constraint PK_AVION primary key (AVION_ID)
);
alter table AVION
   add constraint FK_AVION_ES_UN_TIPO_AVI foreign key (TIPO_ID)
      references TIPO_AVION (TIPO_ID);
      
      
/*==============================================================*/
/* Table: GENERO                                                */
/*==============================================================*/
create table GENERO 
(
   GENERO_ID            NUMBER(10)               not null,
   GENERO               VARCHAR2(10)             not null,
   constraint PK_GENERO primary key (GENERO_ID)
);

/*==============================================================*/
/* Table: PERSONA                                               */
/*==============================================================*/
create table PERSONA 
(
   PERSONA_ID           NUMBER(10)               not null,
   GENERO_ID            NUMBER(10)               not null,
   NUMERO_IDENTIFICAION NUMBER(10)               not null,
   NOMBRE               VARCHAR2(10)             not null,
   APELLIDO             VARCHAR2(10)             not null,
   FECHA_NAC            VARCHAR2(10)             not null,
   constraint PK_PERSONA primary key (PERSONA_ID)
);
alter table PERSONA
   add constraint FK_PERSONA_TIENE_GENERO foreign key (GENERO_ID)
      references GENERO (GENERO_ID);

/*==============================================================*/
/* Table: AZAFATA                                               */
/*==============================================================*/
create table AZAFATA 
(
   PERSONA_ID           NUMBER(10)               not null,
   AZAFATA_ID           NUMBER(10)               not null,
   constraint PK_AZAFATA primary key (AZAFATA_ID)
);
alter table AZAFATA
   add constraint FK_AZAFATA_ES_UNA_PERSONA foreign key (PERSONA_ID)
      references PERSONA (PERSONA_ID);


/*==============================================================*/
/* Table: PILOTO                                                */
/*==============================================================*/
create table PILOTO 
(
   PERSONA_ID           NUMBER(10)               not null,
   PILOTO_ID            NUMBER(10)               not null,
   VUELOS               NUMBER(10)               not null,
   constraint PK_PILOTO primary key (PILOTO_ID)
);
alter table PILOTO
   add constraint FK_PILOTO_ES_UNA_PERSONA foreign key (PERSONA_ID)
      references PERSONA (PERSONA_ID);
      
/*==============================================================*/
/* Table: PASAJERO                                              */
/*==============================================================*/
create table PASAJERO 
(
   PERSONA_ID           NUMBER(10)               not null,
   PASAJERO_ID          NUMBER(10)               not null,
   COMPANION_ID         NUMBER(10)               not null,
   constraint PK_PASAJERO primary key (PASAJERO_ID)
);
alter table PASAJERO
   add constraint FK_PASAJERO_ACOMPANIA_PASAJERO foreign key (COMPANION_ID)
      references PASAJERO (PASAJERO_ID);

alter table PASAJERO
   add constraint FK_PASAJERO_ES_UN4_PERSONA foreign key (PERSONA_ID)
      references PERSONA (PERSONA_ID);
      
/*==============================================================*/
/* Table: PILOTA                                                */
/*==============================================================*/
create table PILOTA 
(
   PILOTO_ID            NUMBER(10)               not null,
   AVION_ID             NUMBER(10)               not null,
   FECHA_INICIO         DATE                 not null,
   FECHA_FIN            DATE                 not null,
   constraint PK_PILOTA primary key (PILOTO_ID, AVION_ID, FECHA_INICIO, FECHA_FIN)
);


alter table PILOTA
   add constraint FK_PILOTA_PILOTA_PILOTO foreign key (PILOTO_ID)
      references PILOTO (PILOTO_ID);

alter table PILOTA
   add constraint FK_PILOTA_PILOTA_AVION foreign key (AVION_ID)
      references AVION (AVION_ID);
      
/*==============================================================*/
/* Table: TAMANIO_EQUIPAJE                                      */
/*==============================================================*/
create table TAMANIO_EQUIPAJE 
(
   TAMANIO_ID           NUMBER(10)               not null,
   TIPO                 VARCHAR2(10)             not null,
   constraint PK_TAMANIO_EQUIPAJE primary key (TAMANIO_ID)
);


/*==============================================================*/
/* Table: EQUIPAJE                                              */
/*==============================================================*/
create table EQUIPAJE 
(
   EQUIPAJE_ID          NUMBER(10)                not null,
   PASAJERO_ID          NUMBER(10)               not null,
   TAMANIO_ID           NUMBER(10)               not null,
   PESO                 NUMBER(10)               not null,
   constraint PK_EQUIPAJE primary key (EQUIPAJE_ID)
);
alter table EQUIPAJE
   add constraint FK_EQUIPAJE_TIENE_1_PASAJERO foreign key (PASAJERO_ID)
      references PASAJERO (PASAJERO_ID);
      
alter table EQUIPAJE
   add constraint FK_EQUIPAJE_TIENE_1_TAMANIO foreign key (TAMANIO_ID)
      references TAMANIO_EQUIPAJE (TAMANIO_ID);



/*==============================================================*/
/* Table: BOLETO                                                */
/*==============================================================*/
create table BOLETO 
(
   BOLETO_ID            NUMBER(10)               not null,
   PASAJERO_ID          NUMBER(10)               not null,
   COSTO                NUMBER(10)               not null,
   DESTINO              VARCHAR2(10)             not null,
   constraint PK_BOLETO primary key (BOLETO_ID)
);
alter table BOLETO
   add constraint FK_BOLETO_TIENE2_PASAJERO foreign key (PASAJERO_ID)
      references PASAJERO (PASAJERO_ID);
      

/*==============================================================*/
/* Table: VUELO                                                 */
/*==============================================================*/
create table VUELO 
(
   VUELO_ID              NUMBER(10)               not null,
   AEROPUERTO_SALIDA_ID  NUMBER(10)               not null,
   AEROPUERTO_LLEGADA_ID NUMBER(10)               not null,
   DESTINO               VARCHAR2(10)             not null,
   FECHA_SALIDA          DATE                     not null,
   FECHA_LLEGADA         DATE                     not null,
   CANTIDAD_PASAJEROS    NUMBER(10)               not null,
   constraint PK_VUELO primary key (VUELO_ID)
);
alter table VUELO
   add constraint FK_VUELO_RECIBE_AEROPUER foreign key (AEROPUERTO_LLEGADA_ID)
      references AEROPUERTO (AEROPUERTO_ID);

alter table VUELO
   add constraint FK_VUELO_SALE_AEROPUER foreign key ( AEROPUERTO_SALIDA_ID)
      references AEROPUERTO (AEROPUERTO_ID);

/*==============================================================*/
/* Table: POSEE                                                 */
/*==============================================================*/
create table POSEE 
(
   BOLETO_ID            NUMBER(10)               not null,
   VUELO_ID             NUMBER(10)               not null,
   constraint PK_POSEE primary key (BOLETO_ID, VUELO_ID)
);
alter table POSEE
   add constraint FK_POSEE_POSEE_BOLETO foreign key (BOLETO_ID)
      references BOLETO (BOLETO_ID);

alter table POSEE
   add constraint FK_POSEE_POSEE2_VUELO foreign key (VUELO_ID)
      references VUELO (VUELO_ID);
      

/*==============================================================*/
/* Table: SE_ASIGNA                                             */
/*==============================================================*/
create table SE_ASIGNA 
(
   AZAFATA_ID           NUMBER(10)           not null,
   VUELO_ID             NUMBER(10)           not null,
   FECHA_INICIO         DATE                 not null,
   FECHA_FIN            DATE                 not null,
   constraint PK_SE_ASIGNA primary key (AZAFATA_ID, VUELO_ID, FECHA_INICIO, FECHA_FIN)
);

alter table SE_ASIGNA
   add constraint FK_SE_ASIGN_SE_ASIGNA_AZAFATA foreign key (AZAFATA_ID)
      references AZAFATA (AZAFATA_ID);

alter table SE_ASIGNA
   add constraint FK_SE_ASIGN_SE_ASIGNA_VUELO foreign key (VUELO_ID)
      references VUELO (VUELO_ID);
      
INSERT INTO TIPO_AVION VALUES (1, 'tipo1');
INSERT INTO AVION VALUES (1, 1, 20, 20, 20);

SELECT * FROM 
avion a INNER JOIN tipo_avion ta
ON a.tipo_id = ta.tipo_id;






