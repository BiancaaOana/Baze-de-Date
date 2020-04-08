-----LABORATORUL 4-----
--- Funcþii grup ºi clauzele GROUP BY, HAVING ---

-- 1. a) Functiile grup includ valorile NULL in calcule? NU
--    b) Care este deosebirea dintre clauzele WHERE ºi HAVING?  WHERE-CONDITIE PE LINIE
--                                                              HAVING-COND PE GRUPURI


-- 2. Sã se afiºeze cel mai mare salariu, cel mai mic salariu, suma ºi media salariilor
--- tuturor angajaþilor. Etichetaþi coloanele Maxim, Minim, Suma, respectiv Media. Sa se
--- rotunjeasca rezultatele.

SELECT 
    max(salary) "Maxim",
    min(salary) "Minim",
    sum(salary) "Suma", 
    round(avg(salary)) "Medie"
FROM employees;

-- 3. Sã se afiºeze minimul, maximul, suma ºi media salariilor pentru fiecare job. 

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
  
 --- 4. Sã se afiºeze numãrul de angajaþi pentru fiecare job
 
 SELECT job_id, count(*) "Nr. angajati"
 FROM employees
 GROUP BY job_id;
 
 --- 5. Sã se determine numãrul de angajaþi care sunt ºefi. Etichetati coloana “Nr. manageri”. 
 
 SELECT
  count(distinct manager_id) "Nr manageri"
FROM 
  employees;

--- 6. Sã se afiºeze diferenþa dintre cel mai mare si cel mai mic salariu. Etichetati coloana. 

SELECT
  max(salary) - min(salary) "DIFERENTA SAL"
FROM
  employees;
  
--- 7. Scrieþi o cerere pentru a se afiºa numele departamentului, locaþia, numãrul de
-- angajaþi ºi salariul mediu pentru angajaþii din acel departament. Coloanele vor fi
-- etichetate corespunzãtor.

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

-- 8. Sã se afiºeze codul ºi numele angajaþilor care câstiga mai mult decât salariul mediu
-- din firmã. Se va sorta rezultatul în ordine descrescãtoare a salariilor. 

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
  
---  9. Pentru fiecare ºef, sã se afiºeze codul sãu ºi salariul celui mai prost platit
-- subordonat. Se vor exclude cei pentru care codul managerului nu este cunoscut. De
--- asemenea, se vor exclude grupurile în care salariul minim este mai mic de 1000$.
-- Sortaþi rezultatul în ordine descrescãtoare a salariilor. 

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
  
--  10. Pentru departamentele in care salariul maxim depãºeºte 3000$, sã se obþinã codul,
-- numele acestor departamente ºi salariul maxim pe departament.

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
-- considerat drept media arirmeticã a salariilor celor care îl practicã.

SELECT 
  min(avg(salary))
FROM 
  employees
GROUP BY 
  job_id;
  
--  12. Sã se afiºeze codul, numele departamentului ºi suma salariilor pe departamente. 
  
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
  
  
 -- 13. Sã se afiºeze maximul salariilor medii pe departamente.  
  
SELECT 
  max(round(avg(salary))) "Max SAL"
FROM 
  employees
GROUP BY 
  department_id;
  
  
--  14. Sã se obtina codul, titlul ºi salariul mediu al job-ului pentru care salariul mediu este
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

 
 
-- 15. Sã se afiºeze salariul mediu din firmã doar dacã acesta este mai mare decât 2500.
 -- (clauza HAVING fãrã GROUP BY)

 SELECT 
  avg(salary) "SAL MEDIU"
FROM 
  employees
HAVING  avg(salary) > 2500;
 
 
--- 16. Sã se afiºeze suma salariilor pe departamente ºi, în cadrul acestora, pe job-uri.

SELECT 
  e.department_id,
  e.job_id,
  sum(salary) "SUMA SALARII"
FROM 
  employees e
GROUP BY 
  e.department_id,
  e.job_id;
  


--- 17. Sã se afiºeze numele departamentului si cel mai mic salariu din departamentul
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
 
 
--- 19. Sa se afiseze salariatii care au fost angajati în aceeaºi zi a lunii în care cei mai multi
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
 
 
-- 20. Sã se obþinã numãrul departamentelor care au cel puþin 15 angajaþi.

SELECT 
  count(count(department_id)) "NR DEP" 
FROM 
  employees
GROUP BY 
  department_id
HAVING count(department_id) > 15;


-- 21. Sã se obþinã codul departamentelor ºi suma salariilor angajaþilor care lucreazã în
-- acestea, în ordine crescãtoare. Se considerã departamentele care au mai mult de 10
-- angajaþi ºi al cãror cod este diferit de 30. 

SELECT 
  department_id,
  sum(salary)
FROM 
  employees
GROUP BY
  department_id
having count(department_id) > 10 and department_id != 30;


