---------------------- Laborator 3 -------------------------

----1. Scrie?i o cerere pentru a se afi?a numele, luna (în litere) ?i anul angaj?rii pentru to?i
--salaria?ii din acela?i departament cu Gates, al c?ror nume con?ine litera “a”. Se va
--exclude Gates.

SELECT e.last_name Nume, to_char(e.hire_date, 'MON') Luna, to_char(e.hire_date, 'YYYY') Anul 
FROM employees e, employees g 
WHERE lower(g.last_name) = 'gates' AND e.department_id = g.department_id AND 
lower(e.last_name) LIKE ('%a%') AND lower(e.last_name) != 'gates';

--OR
SELECT
  e.last_name Nume,
  to_char(e.hire_date,'MONTH') Luna,
  to_char(e.hire_date, 'YYYY') An
FROM
  employees e
JOIN
  employees g on (e.department_id = g.department_id)
WHERE
  lower(e.last_name) LIKE ('%a%')
  AND
  lower(e.last_name) != 'gates'
  AND
  lower(g.last_name) = 'gates';
  

----2. S? se afi?eze codul ?i numele angaja?ilor care lucreaz? în acelasi departament cu
--cel pu?in un angajat al c?rui nume con?ine litera “t”. Se vor afi?a, de asemenea, codul ?i 
--numele departamentului respectiv. Rezultatul va fi ordonat alfabetic dup? nume. Se vor
--da 2 solu?ii pentru join (condi?ie în clauza WHERE ?i sintaxa introdus? de standardul
--SQL3). 


SELECT DISTINCT
  e.employee_id ID,
  e.last_name Nume,
  d.department_id,
  d.department_name
FROM
  employees e
JOIN
  employees a on (e.department_id = a.department_id)
JOIN
  departments d on (e.department_id = d.department_id)
WHERE
  lower(a.last_name) like ('%t%')
ORDER BY
e.last_name;
  
 ---- 3. Sa se afiseze numele, salariul, titlul job-ului, ora?ul ?i ?ara în care lucreaz? angajatii
 --condusi direct de King.
 
 SELECT
  e.last_name,
  e.salary,
  j.job_title,
  l.city,
  c.country_name
FROM
  employees e
JOIN
  employees k on (e.manager_id = k.employee_id)
left outer join
  jobs j on (e.job_id = j.job_id)
left outer join
  departments d on (e.department_id = d.department_id)
left outer join
  locations l on (d.location_id = l.location_id)
left outer join
  countries c on (l.country_id = c.country_id)
WHERE
  lower(k.last_name) like ('king');
  
----4. Sa se afiseze codul departamentului, numele departamentului, numele si job-ul tuturor
--angajatilor din departamentele al c?ror nume con?ine ?irul ‘ti’. De asemenea, se va lista
--salariul angaja?ilor, în formatul “$99,999.00”. Rezultatul se va ordona alfabetic dup? numele
--departamentului, ?i în cadrul acestuia, dup? numele angaja?ilor.

SELECT
  e.department_id,
  e.last_name,
  j.job_title,
  d.department_name,
  to_char(salary, '$99,999.00') "Salariu"
FROM
  employees e
JOIN
  jobs j on (e.job_id = j.job_id)
JOIN
  departments d on (e.department_id = d.department_id)
WHERE
  lower(d.department_name) like ('%ti%')
ORDER BY  d.department_name ASC,
  e.last_name;
  
----5. Sa se afiseze numele angajatilor, numarul departamentului, numele departamentului,
--ora?ul si job-ul tuturor salariatilor al caror departament este localizat in Oxford.

SELECT
  e.last_name,
  e.department_id,
  d.department_name,
  l.city,
  j.job_title
FROM
  employees e
JOIN
  jobs j on (e.job_id = j.job_id)
JOIN
  departments d on (e.department_id = d.department_id)
JOIN
  locations l on (d.location_id = l.location_id)
WHERE
  lower(l.city) LIKE ('Oxford');
  
   --sau-- 
   
SELECT last_name, job_id, department_id
FROM   employees
WHERE  department_id IN
        (SELECT department_id
         FROM   departments
         WHERE  location_id = (SELECT location_id
                               FROM   locations
                               WHERE  city = 'Oxford'));
                               
  
----6. Afisati codul, numele si salariul tuturor angajatilor care castiga mai mult decat salariul
--mediu pentru job-ul corespunz?tor si lucreaza intr-un departament cu cel putin unul din
--angajatii al caror nume contine litera “t”.
---------Obs: Salariul mediu pentru un job se va considera drept media aritmetic? a valorilor minime
--?i maxime admise pentru acesta (media valorilor coloanelor min_salary ?i max_salary).


SELECT DISTINCT
  e.employee_id,
  e.last_name,
  e.salary
FROM
  employees e
JOIN
  employees a on (e.department_id = a.department_id)
JOIN
  departments d on (e.department_id = d.department_id)
JOIN
  jobs j on (e.job_id = j.job_id)
WHERE
  lower(a.last_name) like ('%t%')
  AND
  e.salary > (j.min_salary + j.max_salary) / 2;
  
----7. S? se afi?eze numele salaria?ilor ?i numele departamentelor în care lucreaz?. Se vor
--afi?a ?i salaria?ii care nu au asociat un departament. (right outer join, 2 variante). 

--LEFT OUTER JOIN:
 
SELECT
  e.last_name,
  d.department_name
FROM
  employees e
left outer join
  departments d on (e.department_id = d.department_id);
  
 --RIGHT OUTER JOIN
  
SELECT
  e.last_name,
  d.department_name
FROM
  departments d
right outer join
  employees e on (e.department_id = e.department_id);
  
----8. S? se afi?eze numele departamentelor ?i numele salaria?ilor care lucreaz? în ele. Se vor
--afi?a ?i departamentele care nu au salaria?i. (left outer join, 2 variante)

SELECT
  e.last_name,
  d.department_name
FROM
  departments d
left outer join
  employees e on (d.department_id = e.department_id);
  
  --SAU--
  
SELECT
  e.last_name,
  d.department_name
FROM
  employees e
right outer join
  departments d on (e.department_id = d.department_id);
  

  ---- 10. Se cer codurile departamentelor al c?ror nume con?ine ?irul “re” sau în care lucreaz?
-- angaja?i având codul job-ului “SA_REP”. Cum este ordonat rezultatul? 

SELECT
  d.department_id
FROM
  departments d
WHERE 
  lower(d.department_name) like ('%re%')
UNION
SELECT
  e.department_id
FROM
  employees e
WHERE
  upper(e.job_id) = 'SA_REP';

---- 11. Ce se întâmpl? dac? înlocuim UNION cu UNION ALL în comanda precedent??

SELECT
  d.department_id
FROM
  departments d
WHERE 
  lower(d.department_name) like ('%re%')
UNION ALL
SELECT
  e.department_id
FROM
  employees e
WHERE
  e.job_id = 'SA_REP';
  
---- 12. Sa se obtina codurile departamentelor in care nu lucreaza nimeni (nu este introdus
-- niciun salariat in tabelul employees). Se cer dou? solu?ii.

SELECT
  d.department_id
FROM
  departments d
minus
SELECT
  e.department_id
FROM
  employees e;

-- SAU --

SELECT
  d.department_id
FROM
  departments d
WHERE
 d.department_id not in (select
 nvl(e.department_id, 0)
 FROM
 employees e);
                          
---- 13. Se cer codurile departamentelor al c?ror nume con?ine ?irul “re” ?i în care lucreaz?
-- angaja?i având codul job-ului “HR_REP”

SELECT
  d.department_id
FROM
  departments d
WHERE
  lower(d.department_name) like ('%re%')
intersect
SELECT
  e.department_id
FROM
  employees e
WHERE
  upper(e.job_id) = 'HR_REP';
  
---- 14. S? se determine codul angaja?ilor, codul job-urilor ?i numele celor al c?ror salariu este
-- mai mare decât 3000 sau este egal cu media dintre salariul minim ?i cel maxim pentru
-- job-ul respectiv

SELECT
  e.employee_id,
  e.job_id,
  e.last_name
FROM
  employees e
  WHERE
  e.salary > 3000
  UNION
SELECT
  e.employee_id,
  e.job_id,
  e.last_name
FROM
  employees e
JOIN
  jobs j on (e.job_id = j.job_id)
WHERE
  e.salary = (j.min_salary + j.max_salary) / 2;
  
---- 15. Folosind subcereri, s? se afi?eze numele ?i data angaj?rii pentru salaria?ii care au
--- fost angaja?i dup? Gates

SELECT
  last_name,
  hire_date
FROM
  employees
WHERE hire_date > 
(select
     hire_date
 FROM employees
 WHERE lower(last_name) = 'gates');
                    
SELECT
  e.last_name,
  e.hire_date
FROM
  employees e
cross join
  employees g
WHERE
  e.hire_date > g.hire_date
  and
  lower(g.last_name) = 'gates';
  
---- 16. Folosind subcereri, scrie?i o cerere pentru a afi?a numele ?i salariul pentru to?i
-- colegii (din acela?i departament) lui Gates. Se va exclude Gates.

SELECT
  last_name,
  salary
FROM
  employees
WHERE
  department_id in (SELECT
                      department_id
                    FROM
                      employees
                    WHERE
                      lower(last_name) = 'gates')
  and
  lower(last_name) <> 'gates';
  
---- 17. Folosind subcereri, s? se afi?eze numele ?i salariul angaja?ilor condu?i direct de
-- pre?edintele companiei (acesta este considerat angajatul care nu are manager). 

SELECT
  last_name,
  salary
FROM
  employees
WHERE
  manager_id in (SELECT
                  employee_id
                FROM
                  employees
                WHERE
                  manager_id is null);
                  
---- 18. Scrieti o cerere pentru a afi?a numele, codul departamentului si salariul angajatilor
--- al caror num?r de departament si salariu coincid cu numarul departamentului si salariul
--- unui angajat care castiga comision. 

SELECT
  last_name,
  department_id,
  salary
FROM
  employees e
  WHERE
  department_id in (SELECT
                        department_id
                    FROM
                      employees ee
                    WHERE
                      commission_pct is not null
                      and
                      e.last_name <> ee.last_name)
  and
  salary in (SELECT
              salary
            FROM
              employees ee
            WHERE
              commission_pct is not null
              and
              e.last_name <> ee.last_name);
              

                                
--20--
select
  employee_id,
  salary,
  last_name
from
  employees e
where
  salary > (select
              (min_salary + max_salary) / 2
            from
              jobs
            where
              e.job_id = job_id)
  and
  department_id in (select
                      department_id
                    from
                      employees
                    where
                      lower(last_name) like ('%t%'));
                      
---- 20. Scrieti o cerere pentru a afisa angajatii care castiga mai mult decat oricare functionar
--- (job-ul con?ine ?irul “CLERK”). Sortati rezultatele dupa salariu, in ordine descrescatoare.
--- (ALL). Ce rezultat este returnat dac? se înlocuie?te “ALL” cu “ANY”?

SELECT
  last_name
FROM
  employees
WHERE
  salary > (select
              max(salary)
            from
              employees
            where
              lower(job_id) like ('%clerk%'));

SELECT
  last_name
FROM
  employees
WHERE
  salary > ALL(select
                salary
              from
                employees
              where
                lower(job_id) like ('%clerk%'));
                
SELECT
  last_name
FROM
  employees
WHERE
  salary >ANY(select
                salary
              from
                employees
              where
                lower(job_id) like ('%clerk%'));
                
---- 21. Scrie?i o cerere pentru a afi?a numele, numele departamentului ?i salariul angaja?ilor
--- care nu câ?tig? comision, dar al c?ror ?ef direct coincide cu ?eful unui angajat care
-- câ?tig? comision.

SELECT
  e.last_name,
  d.department_name,
  e.salary
FROM
  employees e
JOIN
  departments d on (e.department_id = d.department_id)
WHERE
  e.commission_pct is null
  and
  e.manager_id in (select
                    employee_id
                  from
                    employees
                  where
                    commission_pct is not null);
                    
---- 22. Sa se afiseze numele, departamentul, salariul ?i job-ul tuturor angajatilor al caror salariu
--- si comision coincid cu salariul si comisionul unui angajat din Oxford.

SELECT
  e.last_name,
  e.salary,
  d.department_name,
  j.job_title
FROM
  employees e
JOIN
  departments d on (e.department_id = d.department_id)
JOIN
  jobs j on (e.job_id = j.job_id)
WHERE
  (salary, nvl(commission_pct, -1))
  in (SELECT
        salary,
        nvl(commission_pct, -1)
      FROM
        employees
      WHERE
        department_id = (SELECT
                             department_id
                         FROM
                             departments
                         WHERE
                             location_id = (SELECT
                                               location_id
                                            FROM
                                               locations
                                            WHERE 
                                             lower(city) like ('oxford'))));
                                                                            
---- 23. S? se afi?eze numele angaja?ilor, codul departamentului ?i codul job-ului salaria?ilor al
--- c?ror departament se afl? în Toronto. 

SELECT
  last_name,
  department_id,
  job_id
FROM
  employees
WHERE
  department_id = (SELECT
                    department_id
                   FROM 
                    departments
                   WHERE
                    location_id = (select
                                    location_id
                                  from
                                    locations
                                  where
                                    lower(city) like ('toronto')));
  
  
  
  
  
  
 
 




