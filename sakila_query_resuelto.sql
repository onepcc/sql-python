use sakila;

/*1. ¿Qué consulta ejecutarías para obtener todos los clientes dentro de city_id = 312? 
Su consulta debe devolver el nombre, apellido, correo electrónico y dirección del cliente.*/
select cd.city_id, cd.city, c.first_name, c.last_name, c.email, a.address
from customer c
join address a ON c.address_id = a.address_id
join city cd ON  a.city_id = cd.city_id
where cd.city_id = 312;

/*2. ¿Qué consulta harías para obtener todas las películas de comedia? 
Su consulta debe devolver el título de la película, la descripción, el año de estreno, la calificación, 
las características especiales y el género (categoría).*/
select f.film_id, f.title, f.description, f.release_year,f.rating, f.special_features, c.name
from category c
left join film_category fc
on c.category_id = fc.category_id
left join film f
on fc.film_id = f.film_id
where c.name = 'comedy';


/*3. ¿Qué consulta harías para obtener todas las películas unidas por actor_id = 5? 
Su consulta debe devolver la identificación del actor, el nombre del actor, 
el título de la película, la descripción y el año de lanzamiento.*/
select a.actor_id, concat_ws(' ',a.first_name,a.last_name) as Actor, f.title,f.description,f.release_year
from actor a
left join film_actor fa
on a.actor_id = fa.actor_id
left join film f
on fa.film_id = f.film_id
where a.actor_id = 5;

/*4. ¿Qué consulta ejecutaría para obtener todos los clientes en store_id = 1 y dentro de estas ciudades (1, 42, 312 y 459)? 
Su consulta debe devolver el nombre, apellido, correo electrónico y dirección del cliente.*/
select st.store_id, a.city_id, cs.first_name, cs.last_name, cs.email, a.address
from store st
left join customer cs
on st.store_id = cs.store_id
left join address a
on cs.address_id = a.address_id
where st.store_id = 1 and a.city_id in(1,42,312,459);

/*5. ¿Qué consulta realizarías para obtener todas las películas con una "calificación = G" y "característica especial = detrás de escena", 
unidas por actor_id = 15? Su consulta debe devolver el título de la película, la descripción, el año de lanzamiento,
 la calificación y la función especial. Sugerencia: puede usar la función LIKE para obtener la parte 'detrás de escena'.*/
select f.title,f.description,f.release_year,f.rating, f.special_features, concat_ws(' ',a.first_name,a.last_name) as Actor
from actor a
left join film_actor fa
on a.actor_id = fa.actor_id
left join film f
on fa.film_id = f.film_id
where f.rating = 'G' and f.special_features like '%behind the scene%' and a.actor_id = 15;
 

/*6. ¿Qué consulta harías para obtener todos los actores que se unieron en el film_id = 369? 
Su consulta debe devolver film_id, title, actor_id y actor_name.*/
select f.film_id,f.title,a.actor_id, concat_ws(' ',a.first_name,a.last_name) as Actor
from actor a
left join film_actor fa
on a.actor_id = fa.actor_id
left join film f
on fa.film_id = f.film_id
where f.film_id = '369';

/*7. ¿Qué consulta harías para obtener todas las películas dramáticas con una tarifa de alquiler de 2.99? 
Su consulta debe devolver el título de la película, la descripción, el año de estreno, la calificación, 
las características especiales y el género (categoría).*/
select f.film_id,f.title,f.description,f.release_year, f.rating, f.special_features, category.name ,f.rental_rate
from category
left join film_category on category.category_id = film_category.category_id
left join film f on f.film_id = film_category.film_id
where category.name = 'drama' and f.rental_rate = 2.99;

/*8. ¿Qué consulta harías para obtener todas las películas de acción a las que se une SANDRA KILMER? 
Su consulta debe devolver el título de la película, la descripción, el año de estreno, la calificación, 
las características especiales, el género (categoría) y el nombre y apellido del actor.*/

select a.actor_id,concat_ws(' ',a.first_name,a.last_name) as Actor, f.film_id,f.title, f.description,f.release_year,f.rating, f.special_features,cat.name
from actor a
left join film_actor fa
on a.actor_id = fa.actor_id
left join film f
on fa.film_id = f.film_id
left join film_category fc
on fc.film_id = f.film_id
left join category cat
on fc.category_id = cat.category_id
where concat_ws(' ',a.first_name,a.last_name) = 'SANDRA KILMER' and cat.name = 'action';