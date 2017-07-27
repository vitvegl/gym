start transaction;

call set_athlet_id ('vit');

insert into `workout` (`workout_date`, `start_time`, `finish_time`, `athlet_id`)
  values
('20170721', '2017-07-21 19:13', '2017-07-21 20:52', (select @athlet_id));

call set_workout_id ('vit', '20170721');

/* split */
insert into `workout_type` (`wtype`) value ('split');

insert into `exercise` (`description`, `weight_kg`, `reps`, `rest_time_sec`, `set_number`, `workout_id`)
  values
('Присідання Пліє', 40, 20, 180, 1, (select @workout_id)),
('Присідання Пліє', 40, 20, 180, 2, (select @workout_id)),
('Жим лежачи', 15, 30, 180, 1, (select @workout_id)),
('Жим лежачи', 15, 24, 180, 2, (select @workout_id)),
('Махи у сторони', 9, 12, 120, 1, (select @workout_id)),
('Махи у сторони', 9, 12, 120, 2, (select @workout_id)),
('Махи у сторони', 9, 12, 180, 3, (select @workout_id)),
('Згинання рук стоячи', 15, 3, 180, 1, (select @workout_id)),
('Згинання рук стоячи', 15, 4, 180, 2, (select @workout_id)),
('Згинання рук стоячи', 15, 4, 180, 3, (select @workout_id)),
('Хаммер', 15, 6, 120, 1, (select @workout_id)),
('Хаммер', 15, 6, 120, 2, (select @workout_id)),
('Хаммер', 15, 5, 120, 3, (select @workout_id)),
('Пулл-овер стоячи', 25, 14, 120, 1, (select @workout_id)),
('Пулл-овер стоячи', 25, 13, 120, 2, (select @workout_id)),
('Пулл-овер стоячи', 25, 10, 180, 3, (select @workout_id)),
('Шраги', 27, 20, 120, 1, (select @workout_id)),
('Шраги', 27, 20, 0, 2, (select @workout_id));

set @workout_id = null;

/* без екіпірування */
insert into `style` (`id`) select e.id from exercise e
  join workout w on e.workout_id = w.id
  join athlet a on w.athlet_id = a.id
where a.nickname = 'vit'
  and w.workout_date = '20170721';

/* гантелі */
insert into `equipment` (`id`) select e.id from exercise e
  join workout w on e.workout_id = w.id
  join athlet a on w.athlet_id = a.id
where a.nickname = 'vit'
  and w.workout_date = '20170721';

call calculate_workout_duration ('vit', '20170721');

call update_exercise_set_equipment ('vit', '20170721', 'гантель', 'Присідання Пліє');
call update_exercise_set_equipment ('vit', '20170721', 'гантель', 'Пулл-овер стоячи');

call calculate_tonnage ('vit', '20170721');

set @athlet_id = null;

commit;
