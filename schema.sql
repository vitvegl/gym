create table `athlet` (
  `id` int unsigned not null auto_increment,
  `nickname` varchar(30) unique not null,
  primary key (`id`)
);

create table `workout` (
  `id` int unsigned not null auto_increment,
  `workout_date` date unique not null,
  `start_time` datetime unique,
  `finish_time` datetime unique,
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
  `weight_kg` float unsigned not null,
  `reps` tinyint unsigned not null,
  `rest_time_sec` smallint unsigned not null,
  `set_number` tinyint unsigned,
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

create procedure calculate_workout_duration (nick varchar(30), wdate date)
comment "it needs to set '%Y-%m-%d %H:%M' time format"
begin
  update workout w
    join athlet a on w.athlet_id = a.id
  set workout_duration = timediff(w.finish_time, w.start_time)
  where a.nickname = nick
    and w.workout_date = wdate
    and w.workout_duration is null
    and w.finish_time is not null
    and w.start_time is not null;
end //

create procedure calculate_tonnage (nick varchar(30), wdate date)
begin
  declare total int unsigned;
  set total = (
    select sum(weight_kg * reps) from exercise e
      join workout w on e.workout_id = w.id
      join athlet a on w.athlet_id = a.id
    where a.nickname = nick
      and w.workout_date = wdate
  );
  update workout w
    join athlet a on w.athlet_id = a.id
  set tonnage = (select total)
  where a.nickname = nick
    and w.workout_date = wdate;
end //

create procedure set_athlet_id (nick varchar(30))
begin
set @athlet_id = (select id from athlet where nickname = nick);
end //

create procedure set_workout_id (nick varchar(30), wdate date)
begin
set @workout_id = (
  select w.id from workout w join athlet a
    on w.athlet_id = a.id
  where a.nickname = nick and w.workout_date = wdate
);
end //

create procedure update_exercise_if_no_weight (nick varchar(30), wdate date)
begin
update exercise e
  join equipment eq on eq.id = e.id
  join workout w on e.workout_id = w.id
  join athlet a on w.athlet_id = a.id
set eq.equipment = 'власна вага'
where a.nickname = nick
  and w.workout_date = wdate
  and e.weight_kg = 0;
end //

create procedure update_exercise_set_equipment (nick varchar(30), wdate date, workout_equipment enum('гантель', 'гантелі', 'штанга', 'гиря', 'гирі', 'тренажер'), exercise_description varchar(100), sequence_set_number tinyint unsigned)
begin
update exercise e
  join equipment eq on eq.id = e.id
  join workout w on e.workout_id = w.id
  join athlet a on w.athlet_id = a.id
set eq.equipment = workout_equipment
where a.nickname = nick
  and w.workout_date = wdate
  and e.description = exercise_description
  and e.set_number = sequence_set_number;
end //

create procedure update_exercise_set_style (nick varchar(30), wdate date, workout_equipment enum('штанга', 'гантель', 'гантелі', 'гиря', 'гирі', 'тренажер', 'власна вага'), workout_style_equipment enum('пояс', 'лямки', 'бинти', 'одяг', 'без екіпірування'), exercise_description varchar(100), sequence_set_number tinyint unsigned)
begin
update exercise e
  join equipment eq on eq.id = e.id
  join style s on s.id = e.id
  join workout w on e.workout_id = w.id
  join athlet a on w.athlet_id = a.id
set s.equipment = workout_style_equipment
where a.nickname = nick
  and w.workout_date = wdate
  and eq.equipment = workout_equipment
  and e.description = exercise_description
  and e.set_number = sequence_set_number;
end //

create procedure athlet_nickname_validation (nick varchar(30))
begin
if (char_length(nick) < 3) then
signal sqlstate '12345'
set message_text = 'nickname must be contains minimum 3 characters'; 
end if;
end //

create trigger trig_athlet_nickname_insert_chk before insert on athlet
for each row
begin
call athlet_nickname_validation (NEW.nickname);
end //

create trigger trig_athlet_nickname_update_chk before update on athlet
for each row
begin
call athlet_nickname_validation (NEW.nickname);
end //

create procedure workout_time_validation (stime datetime, ftime datetime)
begin
if ((stime is not null) and (ftime is not null)) then
  if (unix_timestamp(stime) > unix_timestamp(ftime)) then
  signal sqlstate '12346'
  set message_text = 'time range must be correct';
  end if;
end if;
end //

create trigger trig_workout_time_insert_chk before insert on workout
for each row
begin
call workout_time_validation (NEW.start_time, NEW.finish_time);
end //

create trigger trig_workout_time_update_chk before update on workout
for each row
begin
call workout_time_validation (NEW.start_time, NEW.finish_time);
end //

create procedure workout_duration_validation (duration time)
begin
if (duration is not null) then
  if ((time(duration) < time('00:03:00'))) then
  signal sqlstate '12347'
  set message_text = 'workout.workout_duration must be longer than 3 minutes';
  end if;
end if;
end //

create trigger trig_workout_duration_insert_chk before insert on workout
for each row
begin
call workout_duration_validation (NEW.workout_duration);
end //

create trigger trig_workout_duration_update_chk before update on workout
for each row
begin
call workout_duration_validation (NEW.workout_duration);
end //

create procedure workout_tonnage_validation (total int unsigned)
begin
if total = 0 then
signal sqlstate '12348'
set message_text = 'workout.tonnage must be > 0';
end if;
end //

create trigger trig_workout_tonnage_insert_chk before insert on workout
for each row
begin
call workout_tonnage_validation (NEW.tonnage);
end //

create trigger trig_workout_tonnage_update_chk before update on workout
for each row
begin
call workout_tonnage_validation (NEW.tonnage);
end //

create procedure exercise_description_validation (descr varchar(100))
begin
if (char_length(descr) < 3) then
signal sqlstate '12349'
set message_text = 'exercise.description must be contains minimum 3 characters';
end if;
end //

create trigger trig_exercise_description_insert_chk before insert on exercise
for each row
begin
call exercise_description_validation (NEW.description);
end //

create trigger trig_exercise_description_update_chk before update on exercise
for each row
begin
call exercise_description_validation (NEW.description);
end //

create procedure exercise_rest_time_validation (rtime smallint unsigned)
begin
if ((rtime != 0) and (rtime < 30)) then
signal sqlstate '12351'
set message_text = 'exercise.rest_time_sec must be integer and >= 30 seconds';
end if;
end //

create trigger trig_exercise_rest_time_insert_chk before insert on exercise
for each row
begin
call exercise_rest_time_validation (NEW.rest_time_sec);
end //

create trigger trig_exercise_rest_time_update_chk before update on exercise
for each row
begin
call exercise_rest_time_validation (NEW.rest_time_sec);
end //

create procedure exercise_set_number_validation (seq_number tinyint unsigned)
begin
if seq_number = 0 then
signal sqlstate '12352'
set message_text = 'exercise.set_number must be integer and > 0';
end if;
end //

create trigger trig_exercise_set_number_insert_chk before insert on exercise
for each row
begin
call exercise_set_number_validation (NEW.set_number);
end //

create trigger trig_exercise_set_number_update_chk before update on exercise
for each row
begin
call exercise_set_number_validation (NEW.set_number);
end //

delimiter ;
