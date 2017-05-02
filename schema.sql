create table `athlet` (
  `id` int unsigned not null auto_increment,
  `nickname` varchar(30) not null,
  primary key (`id`)
);

create table `workout` (
  `id` int unsigned not null auto_increment,
  `workout_date` date unique not null,
  `workout_duration` time,
  `tonnage` int unsigned,
  `details` text,
  `athlet_id` int unsigned not null,
  primary key (`id`) using btree,
  constraint fk_workout foreign key (`athlet_id`) references `athlet` (`id`) on delete restrict
);

create table `workout_type` (
  `id` int unsigned not null auto_increment,
  `wtype` enum('split', 'fullbody') default 'split' not null,
  primary key (`id`) using btree,
  constraint fk_workout_type foreign key (`id`) references `workout` (`id`) on delete restrict
);

create table `exercise` (
  `id` int unsigned not null auto_increment,
  `description` varchar(100) not null,
  `weight_kg` smallint unsigned not null,
  `reps` tinyint unsigned not null,
  `rest_time_sec` smallint unsigned not null,
  `workout_id` int unsigned not null,
  primary key (`id`) using btree,
  constraint fk_exercise foreign key (`workout_id`) references `workout` (`id`) on delete restrict
);

create table `style` (
  `id` int unsigned not null auto_increment,
  `equipment` enum('пояс', 'лямки', 'бинти', 'одяг', 'без екіпірування') default 'без екіпірування' not null,
  primary key (`id`) using btree,
  constraint fk_style foreign key (`id`) references `exercise` (`id`) on delete restrict
);

create table `equipment` (
  `id` int unsigned not null auto_increment,
  `equipment` enum('штанга', 'гантель', 'гантелі', 'гиря', 'гирі', 'тренажер', 'власна вага') default 'гантелі' not null,
  `description` varchar(100),
  primary key (`id`) using btree,
  constraint fk_equipment foreign key (`id`) references `exercise` (`id`) on delete restrict
);

delimiter //
create procedure calculate_tonnage (nickname varchar(30), workout_date date)
begin
  declare tonnage int unsigned;
  set tonnage = (
    select sum(weight_kg * reps) from exercise e
      join workout w on e.workout_id = w.id
      join athlet a on w.athlet_id = a.id
    where a.nickname = nickname
      and w.workout_date = workout_date
  );
  update workout w
    join athlet a on w.athlet_id = a.id
  set tonnage = (select tonnage)
  where a.nickname = nickname
    and w.workout_date = workout_date;
end //

create procedure set_athlet_id (nickname varchar(30))
begin
set @athlet_id = (
  select id from athlet where nickname = nickname
);
end //

create procedure set_workout_id (nickname varchar(30), workout_date date)
begin
set @workout_id = (
  select w.id from workout w join athlet a
    on w.athlet_id = a.id
  where a.nickname = nickname and w.workout_date = workout_date
);
end //

create procedure update_exercise_if_no_weight (nickname varchar(30), workout_date date)
begin
update exercise e
  join equipment eq on eq.id = e.id
  join workout w on e.workout_id = w.id
  join athlet a on w.athlet_id = a.id
set eq.equipment = 'власна вага'
where a.nickname = nickname
  and w.workout_date = workout_date
  and e.weight_kg = 0;
end //

create procedure update_exercise_set_equipment(nickname varchar(30), workout_date date, workout_equipment enum('гантель', 'гантелі', 'штанга', 'гиря', 'гирі', 'тренажер'), description varchar(100))
begin
update exercise e
  join equipment eq on eq.id = e.id
  join workout w on e.workout_id = w.id
  join athlet a on w.athlet_id = a.id
set eq.equipment = workout_equipment
where a.nickname = nickname
  and w.workout_date = workout_date
  and e.description = description;
end //

delimiter ;
