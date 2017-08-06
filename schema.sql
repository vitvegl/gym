create table `athlet` (
  `id` int unsigned not null auto_increment,
  `nickname` varchar(30) unique not null,
  primary key (`id`)
);

create table `workout` (
  `id` int unsigned not null auto_increment,
  `workout_date` date not null,
  `start_time` datetime,
  `finish_time` datetime,
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
  `description` enum(
    'Армійський жим',
    'Віджимання від підлоги',
    'Віджимання на брусах',
    'Віджимання у нахилі в положенні рук за спиною',
    'Жим лежачи',
    'Жим лежачи паралельним хватом',
    'Жим Свенда лежачи',
    'Жим сидячи',
    'Жим стоячи',
    'Жим стоячи із-за голови',
    'Згинання рук сидячи',
    'Згинання рук стоячи',
    'Концентрований підйом на біцепс',
    'Концентрований підйом на біцепс сидячи',
    'Махи вперед',
    'Махи у сторони',
    'Підтягування на турніку зворотнім хватом',
    'Прес',
    'Присідання',
    'Присідання Пліє',
    'Пулл-овер лежачи',
    'Пулл-овер сидячи',
    'Пулл-овер стоячи',
    'Розведення рук лежачи',
    'Станова тяга',
    'Статичні випади вперед',
    'Тяга 1 рукою у нахилі',
    'Тяга до підборіддя',
    'Тяга у нахилі',
    'Утримування снаряду стоячи',
    'Французький жим лежачи',
    'Хаммер',
    'Шраги'
  ) not null,
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
  declare dumbbells_total_weight int unsigned;

  set total = (
    select sum(weight_kg * reps) from exercise e
      join equipment eq on eq.id = e.id
      join workout w on e.workout_id = w.id
      join athlet a on w.athlet_id = a.id
    where a.nickname = nick
      and w.workout_date = wdate
      and eq.equipment in ('штанга', 'гантель', 'гиря', 'тренажер')
  );

  if (total is null) then
    set total = (
      select sum(weight_kg * 2 * reps) from exercise e
        join workout w on e.workout_id = w.id
        join athlet a on w.athlet_id = a.id
      where a.nickname = nick
        and w.workout_date = wdate
    );
  elseif (total > 0) then
    set dumbbells_total_weight = (
      select sum(weight_kg * 2 * reps) from exercise e
        join equipment eq on eq.id = e.id
        join workout w on e.workout_id = w.id
        join athlet a on w.athlet_id = a.id
      where a.nickname = nick
        and w.workout_date = wdate
        and eq.equipment in ('гантелі', 'гирі')
    );
    if dumbbells_total_weight > 0 then
      set total = total + dumbbells_total_weight;
    end if;
  end if;

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

create procedure update_exercise_set_equipment (nick varchar(30), wdate date, workout_equipment enum('гантель', 'гантелі', 'штанга', 'гиря', 'гирі', 'тренажер'), exercise_description varchar(100))
begin
update exercise e
  join equipment eq on eq.id = e.id
  join workout w on e.workout_id = w.id
  join athlet a on w.athlet_id = a.id
set eq.equipment = workout_equipment
where a.nickname = nick
  and w.workout_date = wdate
  and e.description = exercise_description;
end //

create procedure update_exercise_set_equipment_specific_set (nick varchar(30), wdate date, workout_equipment enum('гантель', 'гантелі', 'штанга', 'гиря', 'гирі', 'тренажер'), exercise_description varchar(100), sequence_set_number tinyint unsigned)
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

create procedure update_exercise_set_style (nick varchar(30), wdate date, workout_equipment enum('штанга', 'гантель', 'гантелі', 'гиря', 'гирі', 'тренажер', 'власна вага'), workout_style_equipment enum('пояс', 'лямки', 'бинти', 'одяг', 'без екіпірування'), exercise_description varchar(100))
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
  and e.description = exercise_description;
end //

create procedure update_exercise_set_style_specific_set (nick varchar(30), wdate date, workout_equipment enum('штанга', 'гантель', 'гантелі', 'гиря', 'гирі', 'тренажер', 'власна вага'), workout_style_equipment enum('пояс', 'лямки', 'бинти', 'одяг', 'без екіпірування'), exercise_description varchar(100), sequence_set_number tinyint unsigned)
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

create trigger trig_athlet_nickname_insert_chk before insert on athlet
for each row
begin
  if char_length(new.nickname) < 3 then
    signal sqlstate '45000'
    set message_text = 'athlet.nickname must be contains minimum 3 characters';
  end if;
end //

create trigger trig_athlet_nickname_update_chk before update on athlet
for each row
begin
  if char_length(new.nickname) < 3 then
    signal sqlstate '45000'
    set message_text = 'athlet.nickname must be contains minimum 3 characters';
  end if;
end //

create trigger trig_workout_time_insert_chk before insert on workout
for each row
begin
  if ((new.start_time is not null) and (new.finish_time is not null)) then
    if (unix_timestamp(new.start_time) > unix_timestamp(new.finish_time)) then
      signal sqlstate '45002'
      set message_text = 'time range must be correct';
    end if;
  end if;
end //

create trigger trig_workout_time_update_chk before update on workout
for each row
begin
  if ((new.start_time is not null) and (new.finish_time is not null)) then
    if (unix_timestamp(new.start_time) > unix_timestamp(new.finish_time)) then
      signal sqlstate '45002'
      set message_text = 'time range must be correct';
    end if;
  end if;
end //

create procedure insert_into_workout (nick varchar(30), wid int unsigned, wdate date, stime datetime, ftime datetime, duration time, tonn int unsigned, wdetails text, aid int unsigned)
begin
  declare exit handler for sqlstate '45003' rollback;
  if not exists (
    select w.workout_date from workout w
      join athlet a on w.athlet_id = a.id
    where w.workout_date = wdate
      and a.nickname = nick
  ) then
      insert into `workout` (
        `id`,
        `workout_date`,
        `start_time`,
        `finish_time`,
        `workout_duration`,
        `tonnage`,
        `details`,
        `athlet_id`
      )
        values
      (
        wid,
        wdate,
        stime,
        ftime,
        duration,
        tonn,
        wdetails,
        aid
      );
  else
    signal sqlstate '45003'
    set message_text = 'workout.workout_date must be unique for athlet';
  end if;
end //

create procedure workout_date_validation (nick varchar(30), wdate date)
begin
  declare exit handler for sqlstate '45004' rollback;
  if exists (
    select w.workout_date from workout w
      join athlet a on w.athlet_id = a.id
    where w.workout_date = wdate
      and a.nickname = nick
  ) then
      signal sqlstate '45004'
      set message_text = 'workout.workout_date must be unique for athlet';
  end if;
end //

create trigger trig_workout_duration_insert_chk before insert on workout
for each row
begin
  if new.workout_duration is not null then
    if ((new.start_time is not null) and (new.finish_time is not null)) then
      if (new.workout_duration != timediff(new.finish_time, new.start_time)) then
        signal sqlstate '45005'
        set message_text = 'workout.workout_duration is not correct, use calculate_workout_duration()';
      elseif ((new.start_time is null) or (new.finish_time is null)) then
        if (time(new.workout_duration) < time('00:03:00')) then
          signal sqlstate '45006'
          set message_text = 'workout.workout_duration must be longer than 3 minutes';
        end if;
      end if;
    end if;
  end if;
end //

create trigger trig_workout_duration_update_chk before update on workout
for each row
begin
  if new.workout_duration is not null then
    if ((new.start_time is not null) and (new.finish_time is not null)) then
      if (new.workout_duration != timediff(new.finish_time, new.start_time)) then
        signal sqlstate '45005'
        set message_text = 'workout.workout_duration is not correct, use calculate_workout_duration()';
      elseif ((new.start_time is null) or (new.finish_time is null)) then
        if (time(new.workout_duration) < time('00:03:00')) then
          signal sqlstate '45006'
          set message_text = 'workout.workout_duration must be longer than 3 minutes';
        end if;
      end if;
    end if;
  end if;
end //

create trigger trig_workout_tonnage_insert_chk before insert on workout
for each row
begin
  if new.tonnage = 0 then
    signal sqlstate '45007'
    set message_text = 'workout.tonnage must be > 0';
  end if;
end //

create trigger trig_workout_tonnage_update_chk before update on workout
for each row
begin
  if new.tonnage = 0 then
    signal sqlstate '45007'
    set message_text = 'workout.tonnage must be > 0';
  end if;
end //

create trigger trig_exercise_description_insert_chk before insert on exercise
for each row
begin
  if (char_length(new.description) < 3) then
    signal sqlstate '45008'
    set message_text = 'exercise.description must be contains minimum 3 characters';
  end if;
end //

create trigger trig_exercise_description_update_chk before update on exercise
for each row
begin
  if (char_length(new.description) < 3) then
    signal sqlstate '45008'
    set message_text = 'exercise.description must be contains minimum 3 characters';
  end if;
end //

create trigger trig_exercise_rest_time_insert_chk before insert on exercise
for each row
begin
  if ((new.rest_time_sec != 0) and (new.rest_time_sec < 30)) then
    signal sqlstate '45009'
    set message_text = 'exercise.rest_time_sec must be integer and >= 30 seconds';
  end if;
end //

create trigger trig_exercise_rest_time_update_chk before update on exercise
for each row
begin
  if ((new.rest_time_sec != 0) and (new.rest_time_sec < 30)) then
    signal sqlstate '45009'
    set message_text = 'exercise.rest_time_sec must be integer and >= 30 seconds';
  end if;
end //

create trigger trig_exercise_set_number_insert_chk before insert on exercise
for each row
begin
  if new.set_number = 0 then
    signal sqlstate '45010'
    set message_text = 'exercise.set_number must be integer and > 0';
  end if;
end //

create trigger trig_exercise_set_number_update_chk before update on exercise
for each row
begin
  if new.set_number = 0 then
    signal sqlstate '45010'
    set message_text = 'exercise.set_number must be integer and > 0';
  end if;
end //

delimiter ;
