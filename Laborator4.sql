-----LABORATORUL 4-----
--- Func�ii grup �i clauzele GROUP BY, HAVING ---

-- 1. a) Functiile grup includ valorile NULL in calcule? NU
--    b) Care este deosebirea dintre clauzele WHERE �i HAVING?  WHERE-CONDITIE PE LINIE
--                                                              HAVING-COND PE GRUPURI


-- 2. S� se afi�eze cel mai mare salariu, cel mai mic salariu, suma �i media salariilor
--- tuturor angaja�ilor. Eticheta�i coloanele Maxim, Minim, Suma, respectiv Media. Sa se
--- rotunjeasca rezultatele.

SELECT 
    max(salary) "Maxim",
    min(salary) "Minim",
    sum(salary) "Suma", 
    round(avg(salary)) "Medie"
FROM employees;

-- 3. S� se afi�eze minimul, maximul, suma �i media salariilor pentru fiecare job. 

SELECT
  job_id,
  max(salary) "Maxim",
  min(salary) "Minim",
  sum(salary) "Suma",
  round(avg(salary)) "Medie"
FROM
  employees
GROUP BY
  job_id;
  
 --- 4. S� se afi�eze num�rul de angaja�i pentru fiecare job
 
 SELECT job_id, count(*) "Nr. angajati"
 FROM employees
 GROUP BY job_id;
 
 --- 5. S� se determine num�rul de angaja�i care sunt �efi. Etichetati coloana �Nr. manageri�. 
 
 SELECT
  count(distinct manager_id) "Nr manageri"
FROM 
  employees;

--- 6. S� se afi�eze diferen�a dintre cel mai mare si cel mai mic salariu. Etichetati coloana. 

SELECT
  max(salary) - min(salary) "DIFERENTA SAL"
FROM
  employees;
  
--- 7. Scrie�i o cerere pentru a se afi�a numele departamentului, loca�ia, num�rul de
-- angaja�i �i salariul mediu pentru angaja�ii din acel departament. Coloanele vor fi
-- etichetate corespunz�tor.

SELECT
  d.department_name,
  l.city,
  count(*) "Nr. Angajati",
  avg(e.salary) "Salariu Mediu"
FROM
  employees e
JOIN
  departments d on (e.department_id = d.department_id)
JOIN
  locations l on (d.location_id = l.location_id)
GROUP BY
  department_name,
  l.city;

-- 8. S� se afi�eze codul �i numele angaja�ilor care c�stiga mai mult dec�t salariul mediu
-- din firm�. Se va sorta rezultatul �n ordine descresc�toare a salariilor. 

SELECT
  employee_id,
  last_name
FROM
  employees
WHERE
  salary > (SELECT
              avg(salary)
            FROM
              employees)
ORDER BY
  salary DESC;
  
---  9. Pentru fiecare �ef, s� se afi�eze codul s�u �i salariul celui mai prost platit
-- subordonat. Se vor exclude cei pentru care codul managerului nu este cunoscut. De
--- asemenea, se vor exclude grupurile �n care salariul minim este mai mic de 1000$.
-- Sorta�i rezultatul �n ordine descresc�toare a salariilor. 

SELECT
  manager_id,
  min(salary)
FROM 
  employees
WHERE  
  manager_id IS NOT NULL 
GROUP BY
  manager_id
HAVING 
  min(salary) > 1000
ORDER BY 
  min(salary);
  
--  10. Pentru departamentele in care salariul maxim dep�e�te 3000$, s� se ob�in� codul,
-- numele acestor departamente �i salariul maxim pe departament.

SELECT 
  e.department_id,
  max(e.salary),
  d.department_name
FROM 
  employees e
JOIN 
  departments d on (e.department_id = d.department_id)
GROUP BY 
  e.department_id,
  d.department_name
HAVING 
  max(e.salary) > 3000;
  
--  11. Care este salariul mediu minim al job-urilor existente? Salariul mediu al unui job va fi
-- considerat drept media arirmetic� a salariilor celor care �l practic�.

SELECT 
  min(avg(salary))
FROM 
  employees
GROUP BY 
  job_id;
  
--  12. S� se afi�eze codul, numele departamentului �i suma salariilor pe departamente. 
  
SELECT
  d.department_id,
  d.department_name,
  nvl(sum(e.salary), 0)
FROM 
  employees e
RIGHT OUTER JOIN 
  departments d on (e.department_id = d.department_id)
GROUP BY 
  d.department_id,
  d.department_name;
  
  
 -- 13. S� se afi�eze maximul salariilor medii pe departamente.  
  
SELECT 
  max(round(avg(salary))) "Max SAL"
FROM 
  employees
GROUP BY 
  department_id;
  
  
--  14. S� se obtina codul, titlul �i salariul mediu al job-ului pentru care salariul mediu este
--minim.
 
SELECT 
  j.job_id,
  j.job_title,
  avg(e.salary) "SAL MEDIU"
FROM 
  employees e
JOIN   
  jobs j on (e.job_id = j.job_id)
GROUP BY
  j.job_id,
  j.job_title
having avg(e.salary) = (SELECT 
                          min(avg(salary))
                        FROM 
                          employees
                        GROUP BY
                          job_id);

 
 
-- 15. S� se afi�eze salariul mediu din firm� doar dac� acesta este mai mare dec�t 2500.
 -- (clauza HAVING f�r� GROUP BY)

 SELECT 
  avg(salary) "SAL MEDIU"
FROM 
  employees
HAVING  avg(salary) > 2500;
 
 
--- 16. S� se afi�eze suma salariilor pe departamente �i, �n cadrul acestora, pe job-uri.

SELECT 
  e.department_id,
  e.job_id,
  sum(salary) "SUMA SALARII"
FROM 
  employees e
GROUP BY 
  e.department_id,
  e.job_id;
  


--- 17. S� se afi�eze numele departamentului si cel mai mic salariu din departamentul
--- avand cel mai mare salariu mediu.

SELECT 
  d.department_name,
  min(e.salary)
FROM 
  employees e
JOIN
  departments d on (e.department_id = d.department_id)
GROUP BY
  d.department_name
HAVING avg(e.salary) = (SELECT 
                          max(avg(salary))
                        FROM 
                          employees
                        GROUP BY 
                          department_id);
 
 
--- 18. Sa se afiseze codul, numele departamentului si numarul de angajati care lucreaza
 -- in acel departament pentru:
 -- a) departamentele in care lucreaza mai putin de 4 angajati;
 -- b) departamentul care are numarul maxim de angajati.
 --A
 SELECT 
  d.department_name,
  d.department_id,
  count(e.employee_id)
FROM 
  employees e
RIGHT OUTER JOIN 
  departments d on (e.department_id = d.department_id)
GROUP BY 
  d.department_id,
  d.department_name
HAVING  count(e.employee_id) < 4;

--B
SELECT 
  d.department_name,
  d.department_id,
  count(e.employee_id)
FROM 
  employees e
RIGHT OUTER JOIN 
  departments d on (e.department_id = d.department_id)
GROUP BY 
  d.department_id,
  d.department_name
HAVING count(e.employee_id) = (SELECT 
                                max(count(employee_id))
                              FROM 
                                employees
                              GROUP BY 
                                department_id);
 
 
--- 19. Sa se afiseze salariatii care au fost angajati �n aceea�i zi a lunii �n care cei mai multi
-- dintre salariati au fost angajati.
SELECT 
  last_name
FROM 
  employees
WHERE
  to_char(hire_date, 'DD') = (SELECT 
                                to_char(hire_date, 'DD')
                              FROM 
                                employees
                              GROUP BY 
                                to_char(hire_date, 'DD')
                              HAVING  count(to_char(hire_date, 'DD')) = (SELECT 
                                                                          max(count(to_char(hire_date, 'DD')))
                                                                        FROM 
                                                                          employees
                                                                        GROUP BY 
                                                                          to_char(hire_date, 'DD')));
 
 
-- 20. S� se ob�in� num�rul departamentelor care au cel pu�in 15 angaja�i.

SELECT 
  count(count(department_id)) "NR DEP" 
FROM 
  employees
GROUP BY 
  department_id
HAVING count(department_id) > 15;


-- 21. S� se ob�in� codul departamentelor �i suma salariilor angaja�ilor care lucreaz� �n
-- acestea, �n ordine cresc�toare. Se consider� departamentele care au mai mult de 10
-- angaja�i �i al c�ror cod este diferit de 30. 

SELECT 
  department_id,
  sum(salary)
FROM 
  employees
GROUP BY
  department_id
having count(department_id) > 10 and department_id != 30;


