/*
	1. Selezionare tutti gli insegnanti 
*/

select *
from teachers t;

/*
	2. Selezionare tutti i capi di ogni dipartimento
*/
select head_of_department 
from departments d;

/*
	3. Selezionare tutti i corsi di laurea magistrale 
*/

select *
from degrees d  
where `level` = 'magistrale';

/*
	4. Selezionare tutti gli studenti che hanno come nome Marco 
*/

select * 
from students s 
where `name` = 'Marco';

/*
	5. Selezionare tutti i corsi(insegnamenti) che valgono più o uguale a 12 crediti
*/

select * 
from courses c 
where cfu >= 12;

/*
	6. Selezionare tutti i corsi(insegnamenti)  che valgono più di 10 crediti oppure meno di 5 
*/

select * 
from courses c 
where cfu > 10 or cfu < 5;

/*
	7. Selezionare tutti i corsi(insegnamenti)  del primo semestre del primo anno di un qualsiasi corso di 
laurea 
*/
select * 
from courses c 
where period = 'I semestre' and `year` = 1;

/*
	8. Selezionare tutti i corsi(insegnamenti)  che non hanno un sito web 
 
*/
select * 
from courses c 
where website is null ; 


/*
	9. Selezionare tutti gli insegnanti che hanno un numero di telefono 
*/

select *
from teachers t 
where phone is not null ;

/*BONUS: 
10.  Selezionare tutti gli studenti il cui nome inizia per "E". 
*/
select *
from students s 
where name like 'E%';

/*
11.  Contare tutti gli insegnanti che iniziano con “E” (suggerimento: guardate l’operatore COUNT). 
*/
select count(*) as "Nome insegnanti che inizia con la E"
from teachers t 
where name like 'E%';

/*
12.  Contare tutti gli insegnanti che non hanno un numero di telefono.
*/
select count(*) as "Numero insegnanti che non ha numero di cellulare"
from teachers t 
where phone is null;

/*

1. Selezionare tutti gli studenti nati nel 1990 (160)
*/
select *
from students s 
where date_of_birth > '1990-01-01' and date_of_birth < '1990-12-31';

/* un altro modo per fare lo stesso esertcizio con la funazione year*/

select *
from students s 
where year(date_of_birth) = 1990;

/*
2. Selezionare tutti i corsi che valgono più di 10 crediti (479)
*/

select *
from courses c 
where cfu > 10;

/*
3. Selezionare tutti gli studenti che hanno più di 30 anni
*/
select *
from students s 
where year(date_of_birth) < 1994;

/*
4. Selezionare tutti i corsi del primo semestre del primo anno di un qualsiasi corso di
laurea (286)
*/
select * 
from courses c 
where period = 'I semestre' and `year` = 1;

/*
5. Selezionare tutti gli appelli d'esame che avvengono nel pomeriggio (dopo le 14) del
20/06/2020 (21)
*/
select *
from exams e 
where `date` = '2020-06-20' and `hour` > '14:00:00';

/*
6. Selezionare tutti i corsi di laurea magistrale (38)
*/
select *
from degrees d  
where `level` = 'magistrale';
/*
7. Da quanti dipartimenti è composta l'università? (12)
*/
select count(*) as "Numero totale dei dipartimenti" 
from departments d ;
/*
8. Quanti sono gli insegnanti che non hanno un numero di telefono? (50)
*/
select count(*) as "Insegnanti senza numero di telefono" 
from teachers t 
where phone is null;

/* Nuovi esercizi con GROUP BY
1. Contare quanti iscritti ci sono stati ogni anno
*/

select c.`year`, count(year) as 'Iscritti' 
from students s
inner join `degrees` d
on s.degree_id = d.id
inner join courses c 
on d.id = c.degree_id
group by c.`year`;

/*uguale ma con meno passaggi*/

select c.`year`, count(year) as 'Iscritti' 
from students s
inner join courses c 
on s.degree_id = c.degree_id
group by c.`year`;

/*
2. Contare gli insegnanti che hanno l'ufficio nello stesso edificio*/

select t.office_address, count(*) as 'Numero insegnanti' 
from teachers t 
group by office_address 

/*
3. Calcolare la media dei voti di ogni appello d'esame
*/
select avg(es.vote) as 'Media voti', c.period 
from exam_student es 
inner join exams e 
on es.exam_id = e.course_id
inner join courses c 
on e.course_id = c.id 
group by c.period;

/*
4. Contare quanti corsi di laurea ci sono per ogni dipartimento
*/

select count(d.name) as 'Numero corsi di laurea', d2.name 
from `degrees` d 
inner join departments d2 
on d.department_id = d2.id 
group by d2.name; 