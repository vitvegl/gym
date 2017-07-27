start transaction;

call set_athlet_id ('vit');

insert into `workout` (`workout_date`, `start_time`, `finish_time`, `athlet_id`)
  values
('20170711', '2017-07-11 18:40', '2017-07-11 19:32', (select @athlet_id));

call set_workout_id ('vit', '20170711');

/* split */
insert into `workout_type` (`wtype`) value ('split');

insert into `exercise` (`description`, `weight_kg`, `reps`, `rest_time_sec`, `set_number`, `workout_id`)
  values
('Присідання', 33, 10, 180, 1, (select @workout_id)),
('Присідання Пліє', 33, 20, 180, 1, (select @workout_id)),
('Присідання Пліє', 33, 20, 180, 2, (select @workout_id)),
('Тяга 1 рукою у нахилі', 27, 14, 180, 1, (select @workout_id)),
('Тяга 1 рукою у нахилі', 27, 14, 180, 2, (select @workout_id)),
('Пулл-овер стоячи', 23, 18, 120, 1, (select @workout_id)),
('Пулл-овер стоячи', 23, 14, 120, 2, (select @workout_id)),
('Пулл-овер стоячи', 23, 12, 180, 3, (select @workout_id)),
('Хаммер', 9, 12, 90, 1, (select @workout_id)),
('Хаммер', 9, 12, 90, 2, (select @workout_id)),
('Хаммер', 9, 12, 0, 3, (select @workout_id));

set @workout_id = null;

/* без екіпірування */
insert into `style` (`id`) select e.id from exercise e
  join workout w on e.workout_id = w.id
  join athlet a on w.athlet_id = a.id
where a.nickname = 'vit'
  and w.workout_date = '20170711';

/* гантелі */
insert into `equipment` (`id`) select e.id from exercise e
  join workout w on e.workout_id = w.id
  join athlet a on w.athlet_id = a.id
where a.nickname = 'vit'
  and w.workout_date = '20170711';

call update_exercise_if_no_weight ('vit', '20170711');

call calculate_workout_duration ('vit', '20170711');

call update_exercise_set_equipment ('vit', '20170711', 'гантель', 'Присідання Пліє');
call update_exercise_set_equipment ('vit', '20170711', 'гантель', 'Пулл-овер стоячи');

call calculate_tonnage ('vit', '20170711');

set @athlet_id = null;

commit;
