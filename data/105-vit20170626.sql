start transaction;

call set_athlet_id ('vit');

insert into `workout` (`workout_date`, `start_time`, `finish_time`, `athlet_id`)
  values
('20170626', '2017-06-26 14:47', '2017-06-26 16:16', (select @athlet_id));

call set_workout_id ('vit', '20170626');

/* split */
insert into `workout_type` (`wtype`) value ('split');

insert into `exercise` (`description`, `weight_kg`, `reps`, `rest_time_sec`, `set_number`, `workout_id`)
  values
('Присідання', 33, 10, 180, 1, (select @workout_id)),
('Присідання', 33, 10, 180, 2, (select @workout_id)),
('Пулл-овер стоячи', 21, 15, 180, 1, (select @workout_id)),
('Пулл-овер стоячи', 21, 18, 180, 2, (select @workout_id)),
('Пулл-овер стоячи', 21, 18, 180, 3, (select @workout_id)),
('Махи у сторони', 8.2, 13, 120, 1, (select @workout_id)),
('Махи у сторони', 8.2, 13, 120, 2, (select @workout_id)),
('Махи у сторони', 8.2, 10, 120, 3, (select @workout_id)),
('Махи вперед', 8.2, 10, 120, 1, (select @workout_id)),
('Махи вперед', 8.2, 10, 120, 2, (select @workout_id)),
('Махи вперед', 8.2, 10, 180, 3, (select @workout_id)),
('Згинання рук стоячи', 13, 10, 180, 1, (select @workout_id)),
('Згинання рук стоячи', 13, 7, 180, 2, (select @workout_id)),
('Згинання рук стоячи', 13, 7, 120, 3, (select @workout_id)),
('Хаммер', 9, 10, 120, 1, (select @workout_id)),
('Хаммер', 9, 10, 120, 2, (select @workout_id)),
('Хаммер', 9, 10, 0, 3, (select @workout_id));

set @workout_id = null;

/* без екіпірування */
insert into `style` (`id`) select e.id from exercise e
  join workout w on e.workout_id = w.id
  join athlet a on w.athlet_id = a.id
where a.nickname = 'vit'
  and w.workout_date = '20170626';

/* гантелі */
insert into `equipment` (`id`) select e.id from exercise e
  join workout w on e.workout_id = w.id
  join athlet a on w.athlet_id = a.id
where a.nickname = 'vit'
  and w.workout_date = '20170626';

call calculate_workout_duration ('vit', '20170626');

call update_exercise_set_equipment ('vit', '20170626', 'гантель', 'Пулл-овер стоячи', 1);
call update_exercise_set_equipment ('vit', '20170626', 'гантель', 'Пулл-овер стоячи', 2);
call update_exercise_set_equipment ('vit', '20170626', 'гантель', 'Пулл-овер стоячи', 3);

call calculate_tonnage ('vit', '20170626');

set @athlet_id = null;

commit;
