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
  `equipment` enum('штанга', 'гантелі', 'гирі', 'тренажер', 'власна вага') default 'гантелі' not null,
  `description` varchar(100),
  primary key (`id`) using btree,
  constraint fk_equipment foreign key (`id`) references `exercise` (`id`) on delete restrict
);

delimiter //
create procedure calculate_tonnage (_id int unsigned)
begin
update workout
  set tonnage = (
    select sum(weight_kg * reps) from exercise
      where exercise.workout_id = _id
  )
where workout.id = _id;
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

delimiter ;
