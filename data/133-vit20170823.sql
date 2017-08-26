start transaction;

call set_athlet_id ('vit');

insert into `workout` (`workout_date`, `start_time`, `finish_time`, `athlet_id`)
  values
('20170823', '2017-08-23 20:35', '2017-08-23 21:29', (select @athlet_id));

call set_workout_id ('vit', '20170823');

/* fullbody */
insert into `workout_type` (`wtype`) value ('fullbody');

insert into `exercise` (`description`, `weight_kg`, `reps`, `rest_time_sec`, `set_number`, `workout_id`)
  values
('Жим лежачи', 21, 15, 180, 1, (select @workout_id)),
('Жим лежачи', 21, 15, 180, 2, (select @workout_id)),
('Жим лежачи', 21, 11, 180, 3, (select @workout_id)),
('Присідання Пліє', 40, 20, 180, 1, (select @workout_id)),
('Присідання Пліє', 40, 20, 180, 2, (select @workout_id)),
('Присідання Пліє', 40, 20, 180, 3, (select @workout_id)),
('Тяга 1 рукою у нахилі', 33, 10, 120, 1, (select @workout_id)),
('Тяга 1 рукою у нахилі', 33, 10, 120, 2, (select @workout_id)),
('Тяга 1 рукою у нахилі', 33, 10, 180, 3, (select @workout_id)),
('Шраги', 27, 20, 120, 1, (select @workout_id)),
('Шраги', 27, 20, 120, 2, (select @workout_id)),
('Шраги', 27, 20, 0, 3, (select @workout_id));

set @workout_id = null;

/* без екіпірування */
insert into `style` (`id`) select e.id from exercise e
  join workout w on e.workout_id = w.id
  join athlet a on w.athlet_id = a.id
where a.nickname = 'vit'
  and w.workout_date = '20170823';

/* гантелі */
insert into `equipment` (`id`) select e.id from exercise e
  join workout w on e.workout_id = w.id
  join athlet a on w.athlet_id = a.id
where a.nickname = 'vit'
  and w.workout_date = '20170823';

call calculate_workout_duration ('vit', '20170823');

call update_exercise_set_equipment ('vit', '20170823', 'гантель', 'Присідання Пліє');

call calculate_tonnage ('vit', '20170823');

set @athlet_id = null;

commit;
