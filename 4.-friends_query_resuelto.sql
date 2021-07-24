use amigos;
select * from friendships;
select * from users;

select concat_ws(' ',u.first_name, u.last_name) as Usuario, concat_ws(' ',u2.first_name,u2.last_name) as Amigos, f.user_id,f.friend_id
from users u
left join friendships f ON u.id = f.user_id
left join users as u2 ON u2.id = f.friend_id; /* Esto se guarda como una vista*/

CREATE 
    ALGORITHM = UNDEFINED 
    DEFINER = `root`@`localhost` 
    SQL SECURITY DEFINER
VIEW `v_amistad` AS
    SELECT 
        CONCAT_WS(' ', `u`.`first_name`, `u`.`last_name`) AS `Usuario`,
        CONCAT_WS(' ', `u2`.`first_name`, `u2`.`last_name`) AS `Amigos`,
        `f`.`user_id` AS `user_id`,
        `f`.`friend_id` AS `friend_id`
    FROM
        ((`users` `u`
        LEFT JOIN `friendships` `f` ON ((`u`.`id` = `f`.`user_id`)))
        LEFT JOIN `users` `u2` ON ((`u2`.`id` = `f`.`friend_id`)));

/*1.-Devuelva a todos los usuarios que son amigos de Kermit, asegúrese de que sus nombres se muestren en los resultados.*/
select * from v_amistad
where amigos like '%KERMIT%';

/*2.-Devuelve el recuento de todas las amistades.*/
select usuario, count(user_id) as N_amigos 
from v_amistad
group by (usuario)
order by N_amigos desc;

select usuario, count(*) as N_amigos 
from v_amistad
group by (usuario)
order by N_amigos desc;

select usuario,amigos, user_id, friend_id from v_amistad
where amigos like '%KERMIT%';


/*3.-Descubre quién tiene más amigos y devuelve el recuento de sus amigos.*/
SET sql_mode='STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';
/*DIFICIL*/
select usuario, amigos 
from v_amistad
where usuario = (select usuario from
(select usuario,max(n_amigos) from
(select usuario, count(user_id) n_amigos 
from v_amistad
group by (usuario) /*recuento*/
)maximo
)usrmax
);


/*FACIL*/
select usuario, count(user_id) as N_amigos 
from v_amistad
group by (usuario)
order by N_amigos desc
limit 2;

/*4.-Crea un nuevo usuario y hazlos amigos de Eli Byers, Kermit The Frog y Marky Mark.*/
select * from v_amistad;
INSERT INTO users (first_name,last_name,created_at)
VALUES ( 'Juan', 'Castillo',now());
select * from users;

INSERT INTO amigos.friendships (user_id,friend_id,created_at)
VALUES (6, 2,now());
INSERT INTO amigos.friendships (user_id,friend_id,created_at)
VALUES (6, 4,now());
INSERT INTO amigos.friendships (user_id,friend_id,created_at)
VALUES (6, 5,now());
select * from v_amistad;


/*5.-Devuelve a los amigos de Eli en orden alfabético.*/
select * from v_amistad
where user_id = 2
order by amigos ;

/*6.-Eliminar a Marky Mark de los amigos de Eli.*/
DELETE FROM amigos.friendships WHERE user_id=2 and friend_id = 5;

/*7.-Devuelve todas las amistades, mostrando solo el nombre y apellido de ambos amigos*/
select usuario, amigos from v_amistad


