use lead_gen_business;

/*1. ¿Qué consulta ejecutaría para obtener los ingresos totales para marzo de 2012?*/
select * from billing;
/*todo marzo*/
select monthname(charged_datetime), sum(amount) from billing
where monthname(charged_datetime) = 'march';

/*2012*/
select monthname(charged_datetime), sum(amount) from billing
where charged_datetime like '2012-03-%';

/*2. ¿Qué consulta ejecutaría para obtener los ingresos totales recaudados del cliente con una identificación de 2?*/
select concat_ws(' ',c.first_name, c.last_name ), sum(amount)
from clients c
join billing b on c.client_id = b.client_id
where c.client_id = 2
;

/*3. ¿Qué consulta ejecutaría para obtener todos los sitios que posee client = 10?*/
select * from clients;
select s.domain_name as Web, c.client_id as Cliente, concat_ws(' ',c.first_name, c.last_name )
from clients c
join sites s on c.client_id = s.client_id
where c.client_id = 10;

/*4. ¿Qué consulta ejecutaría para obtener el número total de sitios creados por mes por año para el cliente con una identificación de 1? 
¿Qué pasa con el cliente = 20?*/
select c.client_id as Cliente, count(s.domain_name) as Web, concat_ws(' ',c.first_name, c.last_name ) as User, monthname(s.created_datetime) as Mes, year(s.created_datetime) as Año 
from clients c
left join sites s on c.client_id = s.client_id
where c.client_id = 1
group by monthname(s.created_datetime), year(s.created_datetime);

select c.client_id as Cliente, count(s.domain_name) as Web, concat_ws(' ',c.first_name, c.last_name ) as User, monthname(s.created_datetime) as Mes, year(s.created_datetime) as Año 
from clients c
left join sites s on c.client_id = s.client_id
where c.client_id = 20
group by(s.created_datetime);

/*5. ¿Qué consulta ejecutaría para obtener el número total de clientes potenciales (leads) generados para cada uno de los sitios 
entre el 1 de enero de 2011 y el 15 de febrero de 2011?*/
select s.domain_name, count(l.leads_id) as Leads, concat(monthname(l.registered_datetime),' ',day(l.registered_datetime),', ', year(l.registered_datetime))as Fecha
from sites s
left join leads l on s.site_id = l.site_id
where l.registered_datetime between '2011-01-01' and '2011-02-15'
group by(l.leads_id);


/*6. ¿Qué consulta ejecutaría para obtener una lista de nombres de clientes y el número total de clientes potenciales 
que hemos generado para cada uno de nuestros clientes entre el 1 de enero de 2011 y el 31 de diciembre de 2011?*/
select concat_ws(' ',c.first_name, c.last_name ) as User, count(l.leads_id) leads
from clients c
left join sites s on c.client_id = s.client_id
left join leads l on l.site_id = s.site_id
where l.registered_datetime between '2011-01-01' and '2011-12-31'
group by(c.client_id);

/*7. ¿Qué consulta ejecutaría para obtener una lista de nombres de clientes y el número total de clientes potenciales 
que hemos generado para cada cliente cada mes entre los meses 1 y 6 del año 2011?*/
select concat_ws(' ',c.first_name, c.last_name ) as User, count(l.leads_id) leads, monthname(l.registered_datetime)
from clients c
left join sites s on c.client_id = s.client_id
left join leads l on l.site_id = s.site_id
where month(l.registered_datetime) between '1' and '6' and year(l.registered_datetime) = 2011
group by c.client_id,l.leads_id
order by month(l.registered_datetime);

select concat_ws(' ',c.first_name, c.last_name ) as User, count(l.leads_id) leads, monthname(l.registered_datetime)
from clients c
left join sites s on c.client_id = s.client_id
left join leads l on l.site_id = s.site_id
where l.registered_datetime between '2011-01-01' and '2011-06-31'
group by c.client_id,l.leads_id
order by month(l.registered_datetime);

/*8. ¿Qué consulta ejecutaría para obtener una lista de nombres de clientes y el número total de clientes potenciales 
que hemos generado para cada uno de los sitios de nuestros clientes entre el 1 de enero de 2011 y el 31 de diciembre de 2011? 
Solicite esta consulta por ID de cliente. Presente una segunda consulta que muestre todos los clientes, 
los nombres del sitio y el número total de clientes potenciales generados en cada sitio en todo momento.*/
select concat_ws(' ',c.first_name, c.last_name ) as User, s.domain_name as web,count(l.leads_id) leads, concat(monthname(l.registered_datetime),' ',day(l.registered_datetime),', ', year(l.registered_datetime))as Fecha
from clients c
join sites s on c.client_id = s.client_id
join leads l on l.site_id = s.site_id
where l.registered_datetime between '2011-01-01' and '2011-12-31'
group by c.client_id, s.domain_name
order by c.client_id, month(l.registered_datetime);

/*EN TODO MOMENTO, incluye los que no generaron nada*/
select concat_ws(' ',c.first_name, c.last_name ) as User, s.domain_name as web,count(l.leads_id) leads, concat(monthname(l.registered_datetime),' ',day(l.registered_datetime),', ', year(l.registered_datetime))as Fecha
from clients c
left join sites s on c.client_id = s.client_id
left join leads l on l.site_id = s.site_id
group by c.client_id, s.domain_name
order by c.client_id, leads desc;


/*9. Escriba una sola consulta que recupere los ingresos totales recaudados de cada cliente para cada mes del año. 
Pídalo por ID de cliente.*/
select concat_ws(' ',c.first_name, c.last_name ) as User, sum(amount) as Ingresos,  monthname(b.charged_datetime) as mes, year(b.charged_datetime) as year
from billing b
join clients c on b.client_id = c.client_id
group by c.client_id, month(b.charged_datetime), year(b.charged_datetime)
order by c.client_id, year(b.charged_datetime),month(b.charged_datetime);

/*10. Escriba una sola consulta que recupere todos los sitios que posee cada cliente. 
Agrupe los resultados para que cada fila muestre un nuevo cliente. 
Se volverá más claro cuando agregue un nuevo campo llamado 'sitios' que tiene todos los sitios que posee el cliente. 
(SUGERENCIA: use GROUP_CONCAT)*/
/*Because the GROUP_CONCAT function is an aggregate function, to sort the values, 
you must use the ORDER BY clause inside the function, not in the ORDER BY in the SELECT statement.*/

select concat_ws(' ',c.first_name, c.last_name ) as User, group_concat(distinct s.domain_name order by s.domain_name desc separator ' / ') as Sitios 
from clients c
left join sites s on c.client_id = s.client_id
group by (c.client_id)
order by c.client_id;

/*GROUP_CONCAT(
    DISTINCT expression
    ORDER BY expression
    SEPARATOR sep
);
*/