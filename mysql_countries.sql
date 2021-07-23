/*1.- ¿Qué consulta harías para obtener todos los países que hablan esloveno? 
Tu consulta debe devolver el nombre del país, el idioma y el porcentaje de idioma. 
*/#Tu consulta debe organizar el resultado por porcentaje de idioma en orden descendente. (1)

select countries.name, languages.language, languages.percentage 
from languages
JOIN countries ON languages.country_id = countries.id
where languages.language = 'Slovene'
order by languages.percentage desc;

select c.name as Pais, l.language as Idioma, l.percentage as Porcentaje 
from languages l
JOIN countries c ON l.country_id = c.id
where l.language = 'Slovene'
order by l.percentage desc;

/* 2. ¿Qué consulta ejecutarías para mostrar el número total de ciudades para cada país? 
Su consulta debe devolver el nombre del país y el número total de ciudades. 
Tu consulta debe organizar el resultado por el número de ciudades en orden descendente. (3)*/
select *   from cities;

select p.name as Pais, count(*) as ciudades
from cities ct
JOIN countries p ON ct.country_id = p.id
group by (p.name)
order by ciudades desc;

/*3. ¿Qué consulta harías para obtener todas las ciudades de México con una población de más de 500,000? 
Tu consulta debe organizar el resultado por población en orden descendente. (1)*/

select c.name as Ciudad, c.population as Poblacion
from countries p
join cities c ON p.id = c.country_id
where p.name = 'Mexico' and c.population > 500000
order by c.population desc;

/*4. ¿Qué consulta ejecutarías para obtener todos los idiomas en cada país con un porcentaje superior al 89%? 
Tu consulta debe organizar el resultado por porcentaje en orden descendente. (1)*/

select p.name as Pais, l.language as Lenguaje, l.percentage as Porcentaje
from languages l
join countries p
ON p.id = l.country_id
where l.percentage > 89
order by l.percentage desc , l.language asc;

/*5. ¿Qué consulta haría para obtener todos los países con un área de superficie inferior a 501
 y una población superior a 100,000? (2)*/

select p.name as Pais, p.surface_area as Area, p.population as Poblacion
from countries p
where p.surface_area < 501 and p.population > 100000;

/*6. ¿Qué consulta harías para obtener países con solo Monarquía Constitucional 
con un capital superior a 200 y una esperanza de vida superior a 75 años? (1)*/
select name as Pais, government_form as Gobierno, capital as Capital_financiero,life_expectancy as 'Expectativa de vida'
from countries
where government_form = 'Constitutional Monarchy' and capital > 200 and life_expectancy > 75;

/*7. ¿Qué consulta harías para obtener todas las ciudades de Argentina dentro del distrito de Buenos Aires y tener una población superior a 500,000? 
La consulta debe devolver el nombre del país, el nombre de la ciudad, el distrito y la población. (2)*/

select p.name as Pais, c.name as Ciudad, c.district as Distrito, c.population as Poblacion
from countries p
join cities c ON p.id = c.country_id
where p.name = 'Argentina' and c.district = 'Buenos Aires' and c.population > 500000
order by c.population desc;

/*8. ¿Qué consulta harías para resumir el número de países en cada región? 
La consulta debe mostrar el nombre de la región y el número de países. 
Además, la consulta debe organizar el resultado por el número de países en orden descendente. (2)*/
select p.region, count(*) as No_Paises
from countries p
group by (p.region)
order by no_paises desc;


SELECT @@sql_mode;
SET sql_mode='STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';



 