select * from users;
select first_name, last_name from users;

select first_name, last_name from users 
where id = 2 or id = 3;

select * from users
where id > 2;


SELECT *
FROM users
WHERE id <= 3;

# selecciona nombres de usuario que comienzan por K
SELECT * 
FROM users
WHERE first_name LIKE "k%";

# selecciona nombres de usuario que terminan por e
SELECT * 
FROM users
WHERE first_name LIKE "%e";

SELECT *
FROM users
ORDER BY birthday DESC;

# Ordenamiento de resultados
SELECT *
FROM users
ORDER BY first_name;

SELECT *
FROM users
WHERE first_name LIKE "%e"
ORDER BY birthday DESC;

select first_name, length(first_name) from users
where first_name IN ('Allen','Kobe');

#INSERT INTO table_name (column_name1, column_name2) 
#VALUES('column1_value', 'column2_value');

insert INTO users (first_name, last_name, handle, birthday, created_at,creado) values ( 'Juan', 'Castillo', 'jpcastillo','1982-04-20',now(),now());
select * from users;

# UPDATE table_name SET column_name1 = 'some_value', column_name2='another_value' WHERE condition(s)
UPDATE users SET first_name = 'Juan Pablo', last_name = 'Castillo', updated_at = now()
where id = 7;

/*Borrar registro
*/DELETE FROM table_name WHERE condition(s)

DELETE FROM users WHERE id=8;

#Borrar columna
Alter table users
drop column creado;


