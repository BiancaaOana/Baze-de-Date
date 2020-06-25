-------------------- CREAREA TABELELOR ----------------------

--- TABELUL ANGAJATI ---

CREATE TABLE angajati_bog
    ( id_angajati      NUMBER 
       CONSTRAINT id_angajati_nn NOT NULL 
    , first_name    VARCHAR2(25) 
     , last_name    VARCHAR2(25) 
     , email    VARCHAR2(40) 
     , salary NUMBER 
    );
 commit;
 
--- INTRODUCEM DATELE ---    
    
insert into angajati_bog
values(1,	'Tiberiu',	'Dancu',	'tibi.dan@yahoo.com',	1500);
commit;

insert into angajati_bog
values(2,	'Dorina',	'Petcu',	'dorinap@gmail.com',	1800);
commit;

insert into angajati_bog
values(3,	'Lenuta',	'Jalba',	'jalba.lenuta@yahoo.ca',	1650);
commit;

insert into angajati_bog
values(4,	'Cornelia',	'Anastasie',	'cornelia344@gmail.com',	1700);
commit;

insert into angajati_bog
values(5,	'Dumitru',	'Mihai',	'mihaidumi68@gmail.com',	1900);
commit;

insert into angajati_bog
values(6,	'Radu',	'Bondar',	'bondir22@yahoo.com',	1478);
commit;

insert into angajati_bog
values(7,	'Corina',	'Dobre',	'dobrec@yahoo.com',	1687);
commit;

insert into angajati_bog
values(8,	'Doina',	'Muresean',	'mureseandoina65@gmail.com',	2403);
commit;

insert into angajati_bog
values(9,	'Marius',	'Constantin',	'maryuscta@yahoo.ro',	1470);
commit;

insert into angajati_bog
values(10,	'Ilinca',	'Vanda',	'iliv7865@gmail.com',	1650);
commit;

   
--- STABILIREA CHEII PRIMARE ---

CREATE UNIQUE INDEX id_ang_pk
ON angajati_bog (id_angajati);
commit;

ALTER TABLE angajati_bog
ADD ( CONSTRAINT id_ang_pk
       		 PRIMARY KEY (id_angajati)
    ) ;
 commit;   
    
--- TABELUL ANIMALE ---

 CREATE TABLE animale_bog
    ( pet_id      NUMBER 
       CONSTRAINT  pet_id_nn NOT NULL 
    , pet_name    VARCHAR2(40) 
    , data_id       NUMBER 
    , CONSTRAINT     pet_p_id_pk 
        	     PRIMARY KEY (pet_id) 
    , locatie_id NUMBER
    , breed_id NUMBER
    , ingrijitor NUMBER
    , jucarii_id NUMBER
    ) ;
  commit;  
  
    
 --- ADAUGARE DE DATE ---
 
 insert into animale_bog
values(100,	'Ms Miu',	317,	211,	12, 	1,     40 );
commit;

insert into animale_bog
values(101,	'Mr Miu',	311,	212,	11, 	2,     41);
commit;

insert into animale_bog
values(102,	'Kindred',	320,	213,	13, 	3,     42);
commit;

insert into animale_bog
values(103,	'Puffy',	324,	214,	18, 	4,     43);
commit;

insert into animale_bog
values(104,	'Mr Butternut',	314,	215,	15, 	5,   44);
commit;

insert into animale_bog
values(105,	'Barky',	310,	216,	20, 	NULL,    45);
commit;

insert into animale_bog
values(106,	'Candy',	313,	211,	19, 	7,    46);
commit;

insert into animale_bog
values(107,	'Casey',	323,	212,	18, 	8,    47);
commit;

insert into animale_bog
values(108,	'Dixie',	312,	213,	24, 	9,    48);
commit;

insert into animale_bog
values(109,	'Hector',	310,	214,	17, 	10,   49);
commit;

insert into animale_bog
values(110,	'Baby Yoda',	321,	215,	21, 	3,   48);
commit;

insert into animale_bog
values(111,	'Xerath',	318,	216,	23, 	6,    47);
commit;

insert into animale_bog
values(112,	'Sona',	324,	212,	14, 	NULL,    46);
commit;

insert into animale_bog
values(113,	'Varus',	314,	213,	16, 	8,    47);
commit;

insert into animale_bog
values(114,	'Morgana',	310,	212,	24,	    4,    45);
commit;

insert into animale_bog
values(115,	'Xayah',	313,	216,	22, 	2,    44);
commit;

insert into animale_bog
values(116,	'Linda',	316,	211,	25, 	2,    44);
commit;

insert into animale_bog
values(117,	'Miury',	312,	215,	11, 	9,    43);
commit;

insert into animale_bog
values(118,	'Bobby',	310,	214,	19, 	1,    41);
commit;

insert into animale_bog
values(119,	'Stan',	315,	211,	21, 	6,    49);
commit;

--- STABILIREA CHEILOR STRAINE ---

ALTER TABLE animale_bog
ADD ( CONSTRAINT anim_data_fk
        	 FOREIGN KEY (data_id)
          	  REFERENCES datas(data_id) 
     );
commit;    
    
ALTER TABLE animale_bog    
ADD ( CONSTRAINT anim_locatie_fk
        	 FOREIGN KEY (locatie_id)
          	  REFERENCES locatie(locatie_id) 
     );  
commit;

     
ALTER TABLE animale_bog    
ADD ( CONSTRAINT anim_breed_fk
        	 FOREIGN KEY (breed_id)
          	  REFERENCES breed(breed_id) 
    ) ;  
commit;

    
ALTER TABLE animale_bog    
ADD ( CONSTRAINT anim_ingrij_fk
        	 FOREIGN KEY (ingrijitor)
          	  REFERENCES angajati_bog(id_angajati) 
    ) ;       
commit;

ALTER TABLE animale_bog
ADD (CONSTRAINT anim_jucarii_fk
            FOREIGN KEY (jucarii_id)
            REFERENCES jucarii(jucarii_id)
     );        
commit;

 --- TABELUL JUCARII ---
 
 
 CREATE TABLE jucarii
    (jucarii_id NUMBER(2)
    CONSTRAINT jucarii_id_nn NOT NULL
   , denumire_jucarie VARCHAR(40)
   CONSTRAINT denumire_jucarie_nn NOT NULL
   );
   commit;
   
  --- STABILIREA CHEII PRIMARE ---

CREATE UNIQUE INDEX id_juc_pk
ON jucarii (jucarii_id);
commit;

ALTER TABLE jucarii
ADD ( CONSTRAINT id_juc_pk
       		 PRIMARY KEY (jucarii_id)
    ) ;
 commit;
 
  --- ADAUGARE DE DATE ---
 
insert into jucarii
values(40,	'ursulet de plus');
commit;
insert into jucarii
values(41,	'minge de cauciuc');
commit;
 insert into jucarii
values(42,	'os de ros');
commit;
 insert into jucarii
values(43,	'unicorn');
commit;
 insert into jucarii
values(44,	'pisicuta pufoasa');
commit;
 insert into jucarii
values(45,	'rotita de alergat');
commit;
 insert into jucarii
values(46,	'morcov de jucarie');
commit;
 insert into jucarii
values(47,	'guma colorata');
commit;
 insert into jucarii
values(48,	'catelus de plus');
commit;
 insert into jucarii
values(49,	'jucarie colorata');
commit;
  
 
 --- TABELUL LOCATIE ---
 
 CREATE TABLE locatie
    ( locatie_id    NUMBER(4)
    , street_address VARCHAR2(40)
    , postal_code    VARCHAR2(12)
    , city       VARCHAR2(30)
	CONSTRAINT     loc_city_nn  NOT NULL
    , state_province VARCHAR2(25)

    ) ;  
commit;
 
 --- INTRODUCERE DE DATE --- 
 
 insert into locatie
values(211,	'Soseaua Berceni',	00100,	'Bucuresti',	'Romania');
commit;

insert into locatie
values(212,	'Saturn',	21342,	'Galati',	'Romania');
commit;

insert into locatie
values(213,	null, null,		'Bucuresti',	'Romania');
commit;

insert into locatie
values(214,	'Zambilelor',	null,	'Ploiesti', 	'Romania');
commit;

insert into locatie
values(215,	null, null,		'Braila',	'Romania');
commit;

insert into locatie
values(216,	'Kings',	null,	'Londra',  null	);
commit;

insert into locatie
values(217,	'Lalelelor',	32454,	'Tecuci',	'Romania');
commit;

insert into locatie
values(218,	null, null,		'Pitesti',	'Romania');
commit;

insert into locatie
values(219,	'Nucilor',	43642,	'Cluj',	'Romania');
commit;

insert into locatie
values(220,	'Trandafirilor',	43256,	'Cluj',	'Romania');
commit;

    
--- STABILIREA CHEII PRIMARE ---    

CREATE UNIQUE INDEX loc_id_pk
ON locatie(locatie_id) ;
ALTER TABLE locatie
ADD ( CONSTRAINT loc_id_pk
       		 PRIMARY KEY (locatie_id)
             );
commit;

   
--- TABELUL DATAS ---   
    
CREATE TABLE datas
    ( data_id NUMBER(4)
      CONSTRAINT data_id_nn NOT NULL
    , data_aducere VARCHAR(25)
      CONSTRAINT data_aducere_nn NOT NULL
    , data_plecare VARCHAR(25)
    );
commit;    
 
 --- INTRODUCERE DATE IN TABEL --- 
 
 
 insert into datas
values(310,	TO_DATE('2019-05-05','yyy-mm-dd'), TO_DATE('2019-05-10','yyy-mm-dd');
commit;

insert into datas
values(311,	TO_DATE('2019-03-05','yyy-mm-dd'), TO_DATE('2019-03-15','yyy-mm-dd');
commit;

insert into datas
values(312,	TO_DATE('2020-01-13','yyy-mm-dd'), TO_DATE('2020-03-13','yyy-mm-dd');
commit;

insert into datas
values(313,	TO_DATE('2020-03-20','yyy-mm-dd'), TO_DATE('2020-03-24','yyy-mm-dd');
commit;

insert into datas
values(314,	TO_DATE('2019-12-01','yyy-mm-dd'), TO_DATE('2019-12-15','yyy-mm-dd');
commit;

insert into datas
values(315,	TO_DATE('2020-04-23','yyy-mm-dd'), TO_DATE('2020-05-01','yyy-mm-dd');
commit;

insert into datas
values(316,	TO_DATE('2020-02-18','yyy-mm-dd'), TO_DATE('2020-02-22','yyy-mm-dd');
commit;

insert into datas
values(317,	TO_DATE('2020-01-4','yyy-mm-dd'), TO_DATE('2020-01-09','yyy-mm-dd');
commit;

insert into datas
values(318,	TO_DATE('2019-07-23','yyy-mm-dd'), TO_DATE('2019-08-01','yyy-mm-dd');
commit;

insert into datas
values(319,	TO_DATE('2019-03-03','yyy-mm-dd'), TO_DATE('2019-06-03','yyy-mm-dd');
commit;

insert into datas
values(320,	TO_DATE('2020-04-04','yyy-mm-dd'), TO_DATE('2020-04-12','yyy-mm-dd');
commit;

insert into datas
values(321,	TO_DATE('2020-02-23','yyy-mm-dd'), TO_DATE('2020-03-01','yyy-mm-dd');
commit;

insert into datas
values(322,	TO_DATE('2020-05-01','yyy-mm-dd'), TO_DATE('2020-05-10','yyy-mm-dd');
commit;

insert into datas
values(323,	TO_DATE('2019-09-09','yyy-mm-dd'), TO_DATE('2019-09-18','yyy-mm-dd');
commit;

insert into datas
values(324,	TO_DATE('2020-04-03','yyy-mm-dd'), TO_DATE('2020-07-12','yyy-mm-dd');
commit;

    
--- STABILIREA CHEII PRIMARE --- 

    CREATE UNIQUE INDEX data_id_pk
    ON datas(data_id);
    ALTER TABLE datas
    ADD ( CONSTRAINT data_id_pk
                PRIMARY KEY (data_id)
         );  
commit;

         
 --- TABELUL BREED ---
 
CREATE TABLE breed
    ( breed_id NUMBER(4)
    CONSTRAINT breed_id_nn NOT NULL
    , nume_rasa VARCHAR(30)
    CONSTRAINT nume_rasa_nn NOT NULL
    , origine VARCHAR(30)
    CONSTRAINT origine_nn NOT NULL
    , varsta_maxima NUMBER(2)
    CONSTRAINT varsta_maxima_nn NOT NULL
    );
commit;    


--- ADAUGARE DE DATE ---

insert into breed
values(11,	'Pisicuta Tiffany',	'Asia',	20);
commit;

insert into breed
values(12,	'Pisicuta Selkirk', 'Rex',	'SUA',	13);
commit;

insert into breed
values(13,	'Pisicuta Ragamuffin',	'SUA',	15);
commit;

insert into breed
values(14,	'Pisicuta Balineza',	'SUA',	14);
commit;

insert into breed
values(15,	'Pisicuta Siameza',	'China',	15);
commit;

insert into breed
values(16,	'Ciobanesc german',	'Germania',	13);
commit;

insert into breed
values(17,	'Golden Retriever',	'Regatul Unit',	12);
commit;

insert into breed
values(18,	'Malamut de Alaska',	'Alaska',	12);
commit;

insert into breed
values(19,	'Samoyed',	'Siberia',	13);
commit;

insert into breed
values(20,	'Shiba Inu',	'Japonia',	15);
commit;

insert into breed
values(21,	'Porcusor de Guineea abisinian',	'Europa',	7);
commit;

insert into breed
values(22,	'Chinchilla',	'SUA',	10);
commit;

insert into breed
values(23,	'Gerbil',	'Londra',	5);
commit;

insert into breed
values(24,	'Hamster',	'China',	3);
commit;

insert into breed
values(25,	'Iepure',	'Europa',	2);
commit;


--- STABILIREA CHEII PRIMARE --- 
    
    CREATE UNIQUE INDEX breed_id_pk
    ON breed(breed_id); 
    ALTER TABLE breed
    ADD ( CONSTRAINT breed_id_pk
                PRIMARY KEY(breed_id)
        );
commit;

        
        
    