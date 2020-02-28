---LAB2 EX 1 Scrie?i o cerere care are urm?torul rezultat pentru fiecare angajat:
--<prenume angajat> <nume angajat> castiga <salariu> lunar dar doreste <salariu de 3 ori
--mai mare>. Etichetati coloana “Salariu ideal”. Pentru concatenare, utiliza?i atât func?ia

CONCAT cât ?i operatorul “||”.
SELECT concat(first_name, last_name) || ' castiga ' || 
salary || 'lunar dar doreste' ||
salary*3 "Salariu ideal"
FROM employees;

--EX2 Scrie?i o cerere prin care s? se afi?eze prenumele salariatului cu prima litera majuscul? ?i
--toate celelalte litere mici, numele acestuia cu majuscule ?i lungimea numelui, pentru
--angaja?ii al c?ror nume începe cu J sau M sau care au a treia liter? din nume A. Rezultatul
--va fi ordonat descresc?tor dup? lungimea numelui. Se vor eticheta coloanele
--corespunz?tor. Se cer 2 solu?ii (cu operatorul LIKE ?i func?ia SUBSTR). 

SELECT INITCAP(first_name), UPPER(last_name), 
LENGTH(last_name) "Lungime nume"
FROM employees
WHERE last_name LIKE 'J%' OR last_name LIKE 'M%'
OR last_name LIKE '__a%'
--ORDER BY LENGTH (last_name) DESC;
ORDER BY "Lungime nume" DESC;
--ORDER BY 3 DESC;

--EX3 S? se afi?eze pentru angaja?ii cu prenumele „Steven”, codul, numele ?i codul
--departamentului în care lucreaz?. C?utarea trebuie s? nu fie case-sensitive, iar
--eventualele blank-uri care preced sau urmeaz? numelui trebuie ignorate

SELECT employee_id, last_name, department_id
FROM employees
WHERE INITCAP(TRIM(first_name)) LIKE 'Steven';

--EX4 S? se afi?eze pentru to?i angaja?ii al c?ror nume se termin? cu litera 'e', codul, numele,
--lungimea numelui ?i pozi?ia din nume în care apare prima data litera 'a'. Utiliza?i alias-uri
--corespunz?toare pentru coloane

SELECT employee_id, last_name, LENGTH(last_name),
INSTR(LOWER(last_name), 'a')
FROM employees
WHERE LOWER(TRIM(last_name)) LIKE '%e';

--EX5 S? se afi?eze detalii despre salaria?ii care au lucrat un num?r întreg de s?pt?mâni pân? la
--data curent?.
SELECT employee_id, last_name, ROUND(SYSDATE-HIRE_DATE) ZILE
FROM employees
WHERE  MOD(ROUND(SYSDATE-HIRE_DATE), 7) = 0;

--EX 6 S? se afi?eze codul salariatului, numele, salariul, salariul m?rit cu 15%, exprimat cu dou?
--zecimale ?i num?rul de sute al salariului nou rotunjit la 2 zecimale. Eticheta?i ultimele dou?
--coloane “Salariu nou”, respectiv “Numar sute”. Se vor lua în considerare salaria?ii al c?ror
--salariu nu este divizibil cu 1000.

SELECT employee_id, first_name, salary, 
ROUND(salary* 1.15, 2) "Salariu nou", 
ROUND(salary*1.15/100, 2) "Numar sute" 

FROM employees
WHERE MOD(salary, 1000)!=0;

--7 S? se listeze numele ?i data angaj?rii salaria?ilor care câ?tig? comision. S? se eticheteze
--coloanele „Nume angajat”, „Data angajarii”. Pentru a nu ob?ine alias-ul datei angaj?rii
--trunchiat, utiliza?i func?ia RPAD. 

SELECT last_name AS "Nume angajat" , 
RPAD(TO_CHAR(hire_date),20,' ')  "Data angajarii"
FROM employees
WHERE commission_pct IS NOT NULL;

--EX 8 S? se afi?eze data (numele lunii, ziua, anul, ora, minutul si secunda) de peste 30 zile. 

SELECT TO_CHAR(SYSDATE+30, 'MON-DD-YYYY HH24:MI:SS')
FROM dual;

--EX 9 S? se afi?eze num?rul de zile r?mase pân? la sfâr?itul anului

SELECT  TO_DATE('01-JAN-2021')-SYSDATE "Days to go"
FROM DUAL;

--EX10 A) S? se afi?eze data de peste 12 ore

SELECT TO_CHAR(SYSDATE+1/2, 'MON-DD-YYYY HH24:MI:SS')
FROM dual;

--B) S? se afi?eze data de peste 5 minute

SELECT TO_CHAR(SYSDATE+5/(24*60), 'MON-DD-YYYY HH24:MI:SS')
FROM dual;

--11 S? se afi?eze numele ?i prenumele angajatului (într-o singur? coloan?), data angaj?rii ?i
--data negocierii salariului, care este prima zi de Luni dup? 6 luni de serviciu. Eticheta?i
--aceast? coloan? “Negociere”. 

SELECT last_name||' '||first_name "nume", hire_date,
ADD_MONTHS(hire_date, 6) 
NEXT_DAY(ADD_MONTHS(hire_date, 6), 'MONDAY') "NEGOCIERE"
FROM employees;

--12  Pentru fiecare angajat s? se afi?eze numele ?i num?rul de luni de la data angaj?rii.
--Eticheta?i coloana “Luni lucrate”. S? se ordoneze rezultatul dup? num?rul de luni lucrate.
--Se va rotunji num?rul de luni la cel mai apropiat num?r întreg. 

SELECT last_name, ROUND(MONTHS_BETWEEN(SYSDATE, hire_date)) "Luni lucrate"
FROM employees
ORDER BY MONTHS_BETWEEN(SYSDATE, hire_date);
--SAU 
SELECT last_name, ROUND(MONTHS_BETWEEN(SYSDATE, hire_date)) "Luni lucrate"
FROM employees
ORDER BY "Luni lucrate";

--13  S? se afi?eze numele, data angaj?rii ?i ziua s?pt?mânii în care a început lucrul fiecare
--salariat. Eticheta?i coloana “Zi”. Ordona?i rezultatul dup? ziua s?pt?mânii, începând cu
--Luni. 

SELECT last_name, hire_date, 
TO_CHAR(hire_date, 'day') "Ziua"
FROM employees
ORDER BY TO_CHAR(hire_date-1, 'd');


--14  S? se afi?eze numele angaja?ilor ?i comisionul. Dac? un angajat nu câ?tig? comision, s?
--se scrie “Fara comision”. Eticheta?i coloana “Comision”. 

SELECT last_name, NVL(TO_CHAR(commission_pct), 'fara comision')
FROM employees;

--15 S? se listeze numele, salariul ?i comisionul tuturor angaja?ilor al c?ror venit lunar
--dep??e?te 10000$.

SELECT last_name, salary, commission_pct
FROM employees
WHERE salary+salary*
NVL(commission_pct,0)>10000;

--16  S? se afi?eze numele, codul job-ului, salariul ?i o coloan? care s? arate salariul dup?
--m?rire. Se presupune c? pentru IT_PROG are loc o m?rire de 20%, pentru SA_REP
--cre?terea este de 25%, iar pentru SA_MAN are loc o m?rire de 35%. Pentru ceilal?i
--angaja?i nu se acord? m?rire. S? se denumeasc? coloana "Salariu renegociat". 

SELECT last_name, job_id, salary,
CASE job_id
WHEN 'IT_PROG' THEN salary*1.2
WHEN 'SA_REP' THEN salary*1.25
WHEN 'SA_MAN' THEN salary*1.35
ELSE salary
END "Salariu negociat"
FROM employees;

--JOIN
--17 S? se afi?eze numele salariatului, codul ?i numele departamentului pentru to?i angaja?ii.
--Obs: Numele sau alias-urile tabelelor sunt obligatorii în dreptul coloanelor care au acela?i
--nume în mai multe tabele. Altfel, nu sunt necesare dar este recomandat? utilizarea lor pentru
--o mai bun? claritate a cererii. 

SELECT e.last_name, e.department_id, d.department_name 
FROM employees e, departments d WHERE e.department_id = d.department_id;

--18  S? se listeze titlurile job-urile care exist? în departamentul 30. 

SELECT DISTINCT e.job_id, j.job_id, j.job_title 
FROM jobs j, employees e 
WHERE e.job_id = j.job_id 
AND e.department_id = 30;

--19  S? se afi?eze numele angajatului, numele departamentului ?i locatia pentru to?i angaja?ii
--care câ?tig? comision.

SELECT e.last_name, d.department_name, l.city 
FROM employees e, departments d, locations l 
WHERE e.department_id = d.department_id 
AND d.location_id = l.location_id 
AND e.commission_pct IS NOT NULL;

--20  S? se afi?eze numele salariatului ?i numele departamentului pentru to?i salaria?ii care au
--litera A inclus? în nume. 

SELECT e.last_name, d.department_name 
FROM employees e, departments d 
WHERE e.department_id = d.department_id 
AND LOWER(e.last_name) LIKE ('%a%');

--21  S? se afi?eze numele, job-ul, codul ?i numele departamentului pentru to?i angaja?ii care
--lucreaz? în Oxford.

SELECT e.last_name, j.job_title, d.department_name 
FROM employees e, departments d, jobs j, locations l 
WHERE e.department_id = d.department_id 
AND e.job_id = j.job_id 
AND d.location_id = l.location_id 
AND l.city = 'Oxford';

--22  S? se afi?eze codul angajatului ?i numele acestuia, împreun? cu numele ?i codul ?efului
--s?u direct. Se vor eticheta coloanele Ang#, Angajat, Mgr#, Manager. 

SELECT e.employee_id Ang#, e.last_name Angajat, e.manager_id Mgr#, m.last_name Manager 
FROM employees e, employees m 
WHERE e.manager_id = m.employee_id;

--23 S? se modifice cererea precedenta pentru a afi?a to?i salaria?ii, inclusiv cei care nu au ?ef. 

SELECT e.employee_id Ang#, e.last_name Angajat, e.manager_id Mgr#, m.last_name Manager 
FROM employees e, employees m 
WHERE e.manager_id = m.employee_id(+);

--24 Crea?i o cerere care s? afi?eze numele angajatului, codul departamentului ?i to?i salaria?ii
--care lucreaz? în acela?i departament cu el. Se vor eticheta coloanele corespunz?tor. 

SELECT e.last_name, e.department_id, c.last_name "Colegul" 
FROM employees e, employees c 
WHERE e.department_id = c.department_id 
AND e.employee_id != c.employee_id 
ORDER BY 2 ASC, 1 ASC, 3 ASC;

--25 S? se listeze structura tabelului JOBS. Crea?i o cerere prin care s? se afi?eze numele,
--codul job-ului, titlul job-ului, numele departamentului ?i salariul angaja?ilor. 

SELECT e.last_name, e.job_id, e.salary, j.job_title, d.department_name 
FROM employees e, jobs j, departments d 
WHERE e.job_id = j.job_id 
AND e.department_id = d.department_id(+);

--26 S? se afi?eze numele ?i data angaj?rii pentru salaria?ii care au fost angaja?i dup? Gates. 

SELECT e.last_name, e.hire_date 
FROM employees e, employees g 
WHERE lower(g.last_name) = 'gates' 
AND e.hire_date > g.hire_date;

--27 S? se afi?eze numele salariatului ?i data angaj?rii împreun? cu numele ?i data angaj?rii
--?efului direct pentru salaria?ii care au fost angaja?i înaintea ?efilor lor. Se vor eticheta
--coloanele Angajat, Data_ang, Manager si Data_mgr. 

SELECT e.last_name Angajat, e.hire_date Data_ang, m.last_name Manager, m.hire_date Data_mgr 
FROM employees e, employees m 
WHERE e.manager_id = m.employee_id 
AND e.hire_date < m.hire_date;


