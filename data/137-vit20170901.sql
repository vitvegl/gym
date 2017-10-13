start transaction;

call set_athlet_id ('vit');

insert into `workout` (`workout_date`, `start_time`, `finish_time`, `athlet_id`)
  values
('20170901', '2017-09-01 12:34', '2017-09-01 13:26', (select @athlet_id));

call set_workout_id ('vit', '20170901');

/* split */
insert into `workout_type` (`wtype`) value ('split');

insert into `exercise` (`description`, `weight_kg`, `reps`, `rest_time_sec`, `set_number`, `workout_id`)
  values
('Жим лежачи', 17, 23, 120, 1, (select @workout_id)),
('Жим лежачи', 17, 16, 120, 2, (select @workout_id)),
('Жим лежачи', 25, 4, 120, 3, (select @workout_id)),
('Розведення рук лежачи', 13, 18, 120, 1, (select @workout_id)),
('Розведення рук лежачи', 13, 16, 180, 2, (select @workout_id)),
('Присідання Пліє', 40, 20, 180, 1, (select @workout_id)),
('Присідання Пліє', 40, 20, 180, 2, (select @workout_id)),
('Присідання Пліє', 40, 20, 180, 3, (select @workout_id)),
('Згинання рук стоячи', 13, 10, 180, 1, (select @workout_id)),
('Згинання рук стоячи', 13, 9, 180, 2, (select @workout_id)),
('Згинання рук стоячи', 13, 9, 120, 3, (select @workout_id)),
('Шраги', 27, 20, 90, 1, (select @workout_id)),
('Шраги', 27, 20, 90, 2, (select @workout_id)),
('Шраги', 27, 20, 0, 3, (select @workout_id));

set @workout_id = null;

/* без екіпірування */
insert into `style` (`id`) select e.id from exercise e
  join workout w on e.workout_id = w.id
  join athlet a on w.athlet_id = a.id
where a.nickname = 'vit'
  and w.workout_date = '20170901';

/* гантелі */
insert into `equipment` (`id`) select e.id from exercise e
  join workout w on e.workout_id = w.id
  join athlet a on w.athlet_id = a.id
where a.nickname = 'vit'
  and w.workout_date = '20170901';

call calculate_workout_duration ('vit', '20170901');

call update_exercise_set_equipment ('vit', '20170901', 'гантель', 'Присідання Пліє');

call calculate_tonnage ('vit', '20170901');

set @athlet_id = null;

commit;
