create sequence SEQ_ASISTURI
increment by 1 
start with 1 
maxvalue 99999
minvalue 1 
nocycle 
nocache; 

create sequence SEQ_RECUPERARI
increment by 1 
start with 1 
maxvalue 9999
minvalue 1 
nocycle 
nocache; 

create sequence SEQ_PARTIDA
increment by 1 
start with 1 
maxvalue 999
minvalue 1 
nocycle 
nocache; 

create sequence SEQ_ECHIPA
increment by 1 
start with 1 
maxvalue 999999
minvalue 1 
nocycle 
nocache; 

create sequence SEQ_ECHIPA_PARTIDA
increment by 1 
start with 1 
maxvalue 999
minvalue 1 
nocycle 
nocache; 

create sequence SEQ_JUCATOR
increment by 1 
start with 1 
maxvalue 9999999
minvalue 1 
nocycle 
nocache; 

create sequence SEQ_ARENA
increment by 1 
start with 1 
maxvalue 999
minvalue 1 
nocycle 
nocache; 

create sequence SEQ_PUNCTE
increment by 1 
start with 1 
maxvalue 999999
minvalue 1 
nocycle 
nocache; 

create sequence SEQ_ANTRENOR
increment by 1 
start with 1 
maxvalue 999999
minvalue 1 
nocycle 
nocache; 

CREATE TABLE ASISTURI (
  id_asisturi number,
  id_jucator number,
  id_echipa number,
  numar_asisturi number,
  PRIMARY KEY (id_asisturi)
);

CREATE INDEX Key ON  ASISTURI (numar_asisturi);

CREATE TABLE RECUPERARI (
  id_recuperari number,
  id_jucator number,
  id_echipa number,
  numar_recuperari number,
  PRIMARY KEY (id_recuperari)
);

CREATE INDEX Key ON  RECUPERARI (numar_recuperari);

CREATE TABLE PARTIDA (
  id_partida number,
  data_partida date,
  numar_spectatori number,
  PRIMARY KEY (id_partida)
);

CREATE INDEX Key ON  PARTIDA (data_partida, numar_spectatori);

CREATE TABLE ECHIPA (
  id_echipa number,
  id_arena number,
  denumire_echipa varchar2(30),
  oras varchar2(30),
  nume_presedinte varchar2(50),
  PRIMARY KEY (id_echipa)
);

CREATE INDEX Key ON  ECHIPA (denumire_echipa, oras, nume_presedinte);

CREATE TABLE ECHIPA_PARTIDA (
  id_echipa_partida number,
  id_echipa number,
  id_partida number,
  PRIMARY KEY (id_echipa_partida),
  FOREIGN KEY (id_partida)
    REFERENCES PARTIDA(id_partida),
  FOREIGN KEY (id_echipa)
    REFERENCES ECHIPA(id_echipa)
);

CREATE TABLE JUCATOR (
  id_jucator number,
  id_echipa number,
  nume varchar2(25),
  prenume varchar2(50),
  nationalitate varchar2(30),
  cetatenie varchar2(50),
  varsta number,
  PRIMARY KEY (id_jucator)
);

CREATE INDEX Key ON  JUCATOR (nume, prenume, nationalitate, cetatenie, varsta);

CREATE TABLE ARENA (
  id_arena number,
  denumire_arena varchar2(30),
  capacitate number,
  PRIMARY KEY (id_arena)
);

CREATE INDEX Key ON  ARENA (denumire_arena, capacitate);

CREATE TABLE PUNCTE (
  id_puncte number,
  id_jucator number,
  id_echipa number,
  cosuri_3pct number,
  cosuri_2pct number,
  cosuri_1pct number,
  PRIMARY KEY (id_puncte)
);

CREATE INDEX Key ON  PUNCTE (cosuri_3pct, cosuri_2pct, cosuri_1pct);

CREATE TABLE ANTRENOR (
  id_antrenor number,
  id_echipa number,
  nume_antrenor varchar2(30),
  prenume_antrenor varchar2(50),
  PRIMARY KEY (id_antrenor)
);

CREATE INDEX Key ON  ANTRENOR(nume_antrenor, prenume_antrenor);

--Insert Arena
INSERT INTO ARENA (id_arena, denumire_arena, capacitate)
VALUES (SEQ_ARENA.NEXTVAL, 'Romexpo Arena', 6000);

INSERT INTO ARENA (id_arena, denumire_arena, capacitate)
VALUES (SEQ_ARENA.NEXTVAL, 'Sala Polivalenta Bucuresti', 7500);

INSERT INTO ARENA (id_arena, denumire_arena, capacitate)
VALUES (SEQ_ARENA.NEXTVAL, 'Sala Polivalenta Cluj', 9000);

INSERT INTO ARENA (id_arena, denumire_arena, capacitate)
VALUES (SEQ_ARENA.NEXTVAL, 'Dinamo Arena', 15000);

INSERT INTO ARENA (id_arena, denumire_arena, capacitate)
VALUES (SEQ_ARENA.NEXTVAL, 'Sala Polivalenta Timisoara', 8000);

INSERT INTO ARENA (id_arena, denumire_arena, capacitate)
VALUES (SEQ_ARENA.NEXTVAL, 'Sala Polivalenta Craiova', 6700);

--Insert Echipa
INSERT INTO ECHIPA (id_echipa, id_arena, denumire_echipa, oras, nume_presedinte)
VALUES (SEQ_ECHIPA.NEXTVAL, 1, 'Steaua Bucuresti', 'Bucuresti', 'Ion Popescu');

INSERT INTO ECHIPA (id_echipa, id_arena, denumire_echipa, oras, nume_presedinte)
VALUES (SEQ_ECHIPA.NEXTVAL, 3, 'U Cluj', 'Cluj-Napoca', 'Marius Popa');

INSERT INTO ECHIPA (id_echipa, id_arena, denumire_echipa, oras, nume_presedinte)
VALUES (SEQ_ECHIPA.NEXTVAL, 6, 'Universitatea Craiova', 'Craiova', 'Andrei Ionescu');

INSERT INTO ECHIPA (id_echipa, id_arena, denumire_echipa, oras, nume_presedinte)
VALUES (SEQ_ECHIPA.NEXTVAL, 4, 'Dinamo Bucuresti', 'Bucuresti', 'George Popa');

INSERT INTO ECHIPA (id_echipa, id_arena, denumire_echipa, oras, nume_presedinte)
VALUES (SEQ_ECHIPA.NEXTVAL, 5, 'Poli Timisoara', 'Giurgiu', 'Mihai Radu');

INSERT INTO ECHIPA (id_echipa, id_arena, denumire_echipa, oras, nume_presedinte)
VALUES (SEQ_ECHIPA.NEXTVAL, 2, 'Rapid Bucuresti', 'Bucuresti', 'Andrei Ditoiu');

--Insert Jucator

INSERT INTO JUCATOR (id_jucator, id_echipa, nume, prenume, nationalitate, cetatenie, varsta)
VALUES (SEQ_JUCATOR.NEXTVAL, 1, 'Popescu', 'Alexandru', 'Romania', 'Romania', 24);

INSERT INTO JUCATOR (id_jucator, id_echipa, nume, prenume, nationalitate, cetatenie, varsta)
VALUES (SEQ_JUCATOR.NEXTVAL, 1, 'Ionescu', 'Ionut', 'Romania', 'Romania, Moldova', 26);

INSERT INTO JUCATOR (id_jucator, id_echipa, nume, prenume, nationalitate, cetatenie, varsta)
VALUES (SEQ_JUCATOR.NEXTVAL, 2, 'Popovici', 'Vladimir', 'Romania', 'Romania, Serbia', 34);

INSERT INTO JUCATOR (id_jucator, id_echipa, nume, prenume, nationalitate, cetatenie, varsta)
VALUES (SEQ_JUCATOR.NEXTVAL, 2, 'Andrei', 'Dragos', 'Romania', 'Romania', 23);

INSERT INTO JUCATOR (id_jucator, id_echipa, nume, prenume, nationalitate, cetatenie, varsta)
VALUES (SEQ_JUCATOR.NEXTVAL, 3, 'Sorin', 'George', 'Romania', 'Romania', 19);

INSERT INTO JUCATOR (id_jucator, id_echipa, nume, prenume, nationalitate, cetatenie, varsta)
VALUES (SEQ_JUCATOR.NEXTVAL, 3, 'Popescu', 'Andrei', 'Romania', 'Romania, Germania', 25);

INSERT INTO JUCATOR (id_jucator, id_echipa, nume, prenume, nationalitate, cetatenie, varsta)
VALUES (SEQ_JUCATOR.NEXTVAL, 4, 'Ivanov', 'Dmitri', 'Rusia', 'Rusia, Ucraina', 27);

INSERT INTO JUCATOR (id_jucator, id_echipa, nume, prenume, nationalitate, cetatenie, varsta)
VALUES (SEQ_JUCATOR.NEXTVAL, 4, 'Smith', 'John', 'SUA', 'SUA, Anglia', 29);

INSERT INTO JUCATOR (id_jucator, id_echipa, nume, prenume, nationalitate, cetatenie, varsta)
VALUES (SEQ_JUCATOR.NEXTVAL, 5, 'Gonzalez', 'Carlos', 'Argentinian', 'Argentinian', 18);

INSERT INTO JUCATOR (id_jucator, id_echipa, nume, prenume, nationalitate, cetatenie, varsta)
VALUES (SEQ_JUCATOR.NEXTVAL, 5, 'Muller', 'Hans', 'Germania', 'Germania, Austria', 24);

INSERT INTO JUCATOR (id_jucator, id_echipa, nume, prenume, nationalitate, cetatenie, varsta)
VALUES (SEQ_JUCATOR.NEXTVAL, 5, 'Popescu', 'Ion', 'Romania', 'Romania, Italia', 31);

INSERT INTO JUCATOR (id_jucator, id_echipa, nume, prenume, nationalitate, cetatenie, varsta)
VALUES (SEQ_JUCATOR.NEXTVAL, 6, 'Silva', 'Pedro', 'Romania', 'Romania, Portugalia, Spania', 27);

INSERT INTO JUCATOR (id_jucator, id_echipa, nume, prenume, nationalitate, cetatenie, varsta)
VALUES (SEQ_JUCATOR.NEXTVAL, 6, 'Santos', 'Rafael', 'Brazilia', 'Brazilia, Spania', 29);

--Insert Antrenor

INSERT INTO ANTRENOR (id_antrenor, id_echipa, nume_antrenor, prenume_antrenor)
VALUES (SEQ_ANTRENOR.NEXTVAL, 1, 'James', 'Kolo');

INSERT INTO ANTRENOR (id_antrenor, id_echipa, nume_antrenor, prenume_antrenor)
VALUES (SEQ_ANTRENOR.NEXTVAL, 2, 'Garcia', 'Juan Eduardo');

INSERT INTO ANTRENOR (id_antrenor, id_echipa, nume_antrenor, prenume_antrenor)
VALUES (SEQ_ANTRENOR.NEXTVAL, 3, 'Ghita', 'Laurentiu Pavel');

INSERT INTO ANTRENOR (id_antrenor, id_echipa, nume_antrenor, prenume_antrenor)
VALUES (SEQ_ANTRENOR.NEXTVAL, 4, 'Bogdanovici', 'Bogdan');

INSERT INTO ANTRENOR (id_antrenor, id_echipa, nume_antrenor, prenume_antrenor)
VALUES (SEQ_ANTRENOR.NEXTVAL, 5, 'Gomez', 'Gerdht');

INSERT INTO ANTRENOR (id_antrenor, id_echipa, nume_antrenor, prenume_antrenor)
VALUES (SEQ_ANTRENOR.NEXTVAL, 6, 'Aries', 'Vasile Alexandru');

--Insert Partide

INSERT INTO PARTIDA (id_partida, data_partida, numar_spectatori)
VALUES (SEQ_PARTIDA.NEXTVAL, TO_DATE('2023-05-28', 'YYYY-MM-DD'), 4300);

INSERT INTO PARTIDA (id_partida, data_partida, numar_spectatori)
VALUES (SEQ_PARTIDA.NEXTVAL, TO_DATE('2023-06-04', 'YYYY-MM-DD'), 5340);

INSERT INTO PARTIDA (id_partida, data_partida, numar_spectatori)
VALUES (SEQ_PARTIDA.NEXTVAL, TO_DATE('2023-06-26', 'YYYY-MM-DD'), 4000);

INSERT INTO PARTIDA (id_partida, data_partida, numar_spectatori)
VALUES (SEQ_PARTIDA.NEXTVAL, TO_DATE('2023-07-13', 'YYYY-MM-DD'), 3650);

INSERT INTO PARTIDA (id_partida, data_partida, numar_spectatori)
VALUES (SEQ_PARTIDA.NEXTVAL, TO_DATE('2024-01-12', 'YYYY-MM-DD'), 4600);

--Insert Echipa_Partida

INSERT INTO ECHIPA_PARTIDA (id_echipa_partida, id_echipa, id_partida)
VALUES (SEQ_ECHIPA_PARTIDA.NEXTVAL, 3, 1);

INSERT INTO ECHIPA_PARTIDA (id_echipa_partida, id_echipa, id_partida)
VALUES (SEQ_ECHIPA_PARTIDA.NEXTVAL, 1, 1);

INSERT INTO ECHIPA_PARTIDA (id_echipa_partida, id_echipa, id_partida)
VALUES (SEQ_ECHIPA_PARTIDA.NEXTVAL, 2, 2);

INSERT INTO ECHIPA_PARTIDA (id_echipa_partida, id_echipa, id_partida)
VALUES (SEQ_ECHIPA_PARTIDA.NEXTVAL, 4, 2);

INSERT INTO ECHIPA_PARTIDA (id_echipa_partida, id_echipa, id_partida)
VALUES (SEQ_ECHIPA_PARTIDA.NEXTVAL, 5, 3);

INSERT INTO ECHIPA_PARTIDA (id_echipa_partida, id_echipa, id_partida)
VALUES (SEQ_ECHIPA_PARTIDA.NEXTVAL, 6, 3);

INSERT INTO ECHIPA_PARTIDA (id_echipa_partida, id_echipa, id_partida)
VALUES (SEQ_ECHIPA_PARTIDA.NEXTVAL, 4, 4);

INSERT INTO ECHIPA_PARTIDA (id_echipa_partida, id_echipa, id_partida)
VALUES (SEQ_ECHIPA_PARTIDA.NEXTVAL, 6, 4);

INSERT INTO ECHIPA_PARTIDA (id_echipa_partida, id_echipa, id_partida)
VALUES (SEQ_ECHIPA_PARTIDA.NEXTVAL, 3, 5);

INSERT INTO ECHIPA_PARTIDA (id_echipa_partida, id_echipa, id_partida)
VALUES (SEQ_ECHIPA_PARTIDA.NEXTVAL, 2, 5);


--Insert Puncte

INSERT INTO PUNCTE (id_puncte, id_jucator, id_echipa, cosuri_3pct, cosuri_2pct, cosuri_1pct)
VALUES (SEQ_PUNCTE.NEXTVAL, 1, 1, 5, 10, 32);

INSERT INTO PUNCTE (id_puncte, id_jucator, id_echipa, cosuri_3pct, cosuri_2pct, cosuri_1pct)
VALUES (SEQ_PUNCTE.NEXTVAL, 2, 1, 13, 38, 22);

INSERT INTO PUNCTE (id_puncte, id_jucator, id_echipa, cosuri_3pct, cosuri_2pct, cosuri_1pct)
VALUES (SEQ_PUNCTE.NEXTVAL, 3, 2, 7, 12, 1);

INSERT INTO PUNCTE (id_puncte, id_jucator, id_echipa, cosuri_3pct, cosuri_2pct, cosuri_1pct)
VALUES (SEQ_PUNCTE.NEXTVAL, 4, 2, 9, 9, 9);

INSERT INTO PUNCTE (id_puncte, id_jucator, id_echipa, cosuri_3pct, cosuri_2pct, cosuri_1pct)
VALUES (SEQ_PUNCTE.NEXTVAL, 5, 3, 23, 19, 22);

INSERT INTO PUNCTE (id_puncte, id_jucator, id_echipa, cosuri_3pct, cosuri_2pct, cosuri_1pct)
VALUES (SEQ_PUNCTE.NEXTVAL, 6, 3, 6, 11, 3);

INSERT INTO PUNCTE (id_puncte, id_jucator, id_echipa, cosuri_3pct, cosuri_2pct, cosuri_1pct)
VALUES (SEQ_PUNCTE.NEXTVAL, 7, 4, 8, 14, 2);

INSERT INTO PUNCTE (id_puncte, id_jucator, id_echipa, cosuri_3pct, cosuri_2pct, cosuri_1pct)
VALUES (SEQ_PUNCTE.NEXTVAL, 8, 4, 34, 16, 7);

INSERT INTO PUNCTE (id_puncte, id_jucator, id_echipa, cosuri_3pct, cosuri_2pct, cosuri_1pct)
VALUES (SEQ_PUNCTE.NEXTVAL, 9, 5, 13, 27, 31);

INSERT INTO PUNCTE (id_puncte, id_jucator, id_echipa, cosuri_3pct, cosuri_2pct, cosuri_1pct)
VALUES (SEQ_PUNCTE.NEXTVAL, 10, 5, 6, 13, 2);

INSERT INTO PUNCTE (id_puncte, id_jucator, id_echipa, cosuri_3pct, cosuri_2pct, cosuri_1pct)
VALUES (SEQ_PUNCTE.NEXTVAL, 11, 5, 2, 5, 3);

INSERT INTO PUNCTE (id_puncte, id_jucator, id_echipa, cosuri_3pct, cosuri_2pct, cosuri_1pct)
VALUES (SEQ_PUNCTE.NEXTVAL, 12, 6, 9, 9, 12);

INSERT INTO PUNCTE (id_puncte, id_jucator, id_echipa, cosuri_3pct, cosuri_2pct, cosuri_1pct)
VALUES (SEQ_PUNCTE.NEXTVAL, 13, 6, 15, 29, 22);


--Insert Asisturi

INSERT INTO ASISTURI (id_asisturi, id_jucator, id_echipa, numar_asisturi)
VALUES (SEQ_ASISTURI.NEXTVAL, 1, 1, 38);

INSERT INTO ASISTURI (id_asisturi, id_jucator, id_echipa,  numar_asisturi)
VALUES (SEQ_ASISTURI.NEXTVAL, 2, 1, 14);

INSERT INTO ASISTURI (id_asisturi, id_jucator, id_echipa, numar_asisturi)
VALUES (SEQ_ASISTURI.NEXTVAL, 3, 2, 28);

INSERT INTO ASISTURI (id_asisturi, id_jucator, id_echipa, numar_asisturi)
VALUES (SEQ_ASISTURI.NEXTVAL, 4, 2, 16);

INSERT INTO ASISTURI (id_asisturi, id_jucator, id_echipa, numar_asisturi)
VALUES (SEQ_ASISTURI.NEXTVAL, 5, 3, 8);

INSERT INTO ASISTURI (id_asisturi, id_jucator, id_echipa, numar_asisturi)
VALUES (SEQ_ASISTURI.NEXTVAL, 6, 3, 15);

INSERT INTO ASISTURI (id_asisturi, id_jucator, id_echipa, numar_asisturi)
VALUES (SEQ_ASISTURI.NEXTVAL, 7, 4, 49);

INSERT INTO ASISTURI (id_asisturi, id_jucator, id_echipa, numar_asisturi)
VALUES (SEQ_ASISTURI.NEXTVAL, 8, 4, 35);

INSERT INTO ASISTURI (id_asisturi, id_jucator, id_echipa, numar_asisturi)
VALUES (SEQ_ASISTURI.NEXTVAL, 9, 5, 28);

INSERT INTO ASISTURI (id_asisturi, id_jucator, id_echipa, numar_asisturi)
VALUES (SEQ_ASISTURI.NEXTVAL, 10, 5, 5);

INSERT INTO ASISTURI (id_asisturi, id_jucator, id_echipa, numar_asisturi)
VALUES (SEQ_ASISTURI.NEXTVAL, 11, 5, 23);

INSERT INTO ASISTURI (id_asisturi, id_jucator, id_echipa, numar_asisturi)
VALUES (SEQ_ASISTURI.NEXTVAL, 12, 6, 52);

INSERT INTO ASISTURI (id_asisturi, id_jucator, id_echipa, numar_asisturi)
VALUES (SEQ_ASISTURI.NEXTVAL, 13, 6, 33);


--Insert Recuperari
INSERT INTO RECUPERARI (id_recuperari, id_jucator, id_echipa, numar_recuperari)
VALUES (SEQ_RECUPERARI.NEXTVAL, 1, 1, 8);

INSERT INTO RECUPERARI (id_recuperari, id_jucator, id_echipa, numar_recuperari)
VALUES (SEQ_RECUPERARI.NEXTVAL, 2, 1, 15);

INSERT INTO RECUPERARI (id_recuperari, id_jucator, id_echipa, numar_recuperari)
VALUES (SEQ_RECUPERARI.NEXTVAL, 3, 2, 25);

INSERT INTO RECUPERARI (id_recuperari, id_jucator, id_echipa, numar_recuperari)
VALUES (SEQ_RECUPERARI.NEXTVAL, 4, 2, 12);

INSERT INTO RECUPERARI (id_recuperari, id_jucator, id_echipa, numar_recuperari)
VALUES (SEQ_RECUPERARI.NEXTVAL, 5, 3, 6);

INSERT INTO RECUPERARI (id_recuperari, id_jucator, id_echipa, numar_recuperari)
VALUES (SEQ_RECUPERARI.NEXTVAL, 6, 3, 36);

INSERT INTO RECUPERARI (id_recuperari, id_jucator, id_echipa, numar_recuperari)
VALUES (SEQ_RECUPERARI.NEXTVAL, 7, 4, 19);

INSERT INTO RECUPERARI (id_recuperari, id_jucator, id_echipa, numar_recuperari)
VALUES (SEQ_RECUPERARI.NEXTVAL, 8, 4, 5);

INSERT INTO RECUPERARI (id_recuperari, id_jucator, id_echipa, numar_recuperari)
VALUES (SEQ_RECUPERARI.NEXTVAL, 9, 5, 9);

INSERT INTO RECUPERARI (id_recuperari, id_jucator, id_echipa, numar_recuperari)
VALUES (SEQ_RECUPERARI.NEXTVAL, 10, 5, 23);

INSERT INTO RECUPERARI (id_recuperari, id_jucator, id_echipa, numar_recuperari)
VALUES (SEQ_RECUPERARI.NEXTVAL, 11, 5, 37);

INSERT INTO RECUPERARI (id_recuperari, id_jucator, id_echipa, numar_recuperari)
VALUES (SEQ_RECUPERARI.NEXTVAL, 12, 6, 27);

INSERT INTO RECUPERARI (id_recuperari, id_jucator, id_echipa, numar_recuperari)
VALUES (SEQ_RECUPERARI.NEXTVAL, 13, 6, 32);
