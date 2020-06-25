--- 1. Sa se afiseze cu majuscula numele animalutului care se termina cu litera "y" si se afla in
-- adapost de 2 luni si sa se ordoneze animalutele in functie de numarul de luni de sedere la adapost.
SELECT  initcap(a.pet_name)
FROM  animale_bog a left join  datas b on (a.data_id = b.data_id)
WHERE a.pet_name like '%y' and round(months_between( TO_DATE(TO_CHAR(b.data_plecare),'YYYY-MM-DD'),TO_DATE(TO_CHAR(b.data_aducere),'YYYY-MM-DD'))) = 2;


--- 2. Sa se listeze numele si data de aducere in adapost a animalelor care nu au un camp null
--- la adresa strazii.  

select  a.pet_name,b.data_aducere as data
from  animale_bog a left join  datas b on (a.data_id = b.data_id)
where a.locatie_id in (select locatie_id
        from locatie
        where street_address is not NULL) 
        order by data DESC;
        
--- 3. Sa se listeze toate animalele cu numele ingrijitorului lor, iar daca nu au ingrijitor, sa scrie
--- "fara ingrijitor".        
        
select a.pet_name,b.first_name || ' ' || b.last_name as Nume, NVL(TO_CHAR(a.ingrijitor),'fara ingrijitor') as Ingrijitor
from  animale_bog a left join angajati_bog b on (a.ingrijitor = b.id_angajati);  


--- 4. Sa se afiseze animalele si numele lor din adapost cu origine din SUA.
       
select a.pet_name,b.nume_rasa
from animale_bog a join breed b on ( a.breed_id = b.breed_id)
where b.origine = 'SUA'; 

--- 5.Afisati numele tuturor ingrijitorilor al pisicilor si limita de varsta a acestora.

select  b.first_name || ' ' || b.last_name as Nume, c.varsta_maxima
from  animale_bog a
full join angajati_bog b on ( a.ingrijitor = b.id_angajati)
join breed c on (a.breed_id = c.breed_id)
where c.nume_rasa LIKE '%Pisicut%';

--- 6. Sa se afiseze toti angajatii care ingrijesc pisicute si au salariu intre 1500 si 1700 lei, iar a 
-- treia litera din numele lor este "n".

select  b.first_name || ' ' || b.last_name as Nume
from  animale_bog a
full join angajati_bog b on ( a.ingrijitor = b.id_angajati)
join breed c on (a.breed_id = c.breed_id)
where c.nume_rasa LIKE '%Pisicut%' and b.salary between 1500 and 1700 and b.first_name LIKE '__n%';

--- 7. Sa se obtina codurile raselor animalutelor care nu sunt ingrijite de nimeni.

select c.nume_rasa
from  animale_bog a 
join breed c on (a.breed_id = c.breed_id)
where a.ingrijitor is NULL;

--- 8. Se cer codurile raselor animalutelor ale caror nume contine sirul "iu" sau cele care sunt ingrijite de
-- angajati avand codul "2".

select c.breed_id
from  animale_bog a 
join breed c on (a.breed_id = c.breed_id)
where a.ingrijitor = 2 and a.pet_name LIKE '%iu%'; 

--- 9. Aceeasi cerinta ca la 8, cu UNION
select breed_id
from breed
where nume_rasa like 'Pisicuta Tiffany'
UNION
select breed_id
from animale_bog
where ingrijitor = 2;

 --- 10. Sa se afiseze (cu subcereri) animalutele ingrijite de Dorina.
select pet_name
from animale_bog 
where ingrijitor = (select id_angajati
                    from angajati_bog
                    where first_name = 'Dorina');
                    
--- 11. Sa se afiseze numele animalutului cu cea mai mica limita de varsta din rasele ingrijite de angajati
-- avand salariul mai mic decat salariul mediu. 

 select  a.pet_name
from  animale_bog a
full join angajati_bog b on ( a.ingrijitor = b.id_angajati)
join breed c on (a.breed_id = c.breed_id)
where c.varsta_maxima = (select MIN(varsta_maxima)
                            from breed)
                            and a.ingrijitor  in (select id_angajati
                                                 from angajati_bog
                                                  where salary < (select AVG(salary)
                                                                   from angajati_bog 
                                                                   )
                                                )
group by a.pet_name;

--- 12. Sa se creeze o cerere prin care sa se afiseze numarul total de animalute si, din acest total, 
-- numarul celor care au fost aduse in adapost in 2019  si 2020.

select count(*)
from animale_bog a
join datas b on (a.data_id = b.data_id)
where   b.data_aducere between '2019-01-01' and '2020-01-01';
                     
--- 13.  Sa se afiseze numele, salariul, codul mai mare ca 3 si salariul mediu al angajatilor ingrijitori.
 
 select b.first_name ||' ' ||  b.last_name,avg(b.salary)
from  animale_bog a
full join angajati_bog b on ( a.ingrijitor = b.id_angajati)
join breed c on (a.breed_id = c.breed_id)
group by a.ingrijitor,b.first_name, b.last_name
having a.ingrijitor > 3;

--- 14. Pentru fiecare oras, sa se listeze numele acestuia, numele si varsta maxima a 
-- animalutelor care traiesc  cel mai putin.

select distinct(b.city),c.nume_rasa,a.pet_name, min(c.varsta_maxima)
from  animale_bog a
join locatie b on ( a.locatie_id = b.locatie_id)
join breed c on (a.breed_id = c.breed_id)
group by b.city,c.nume_rasa,a.pet_name;