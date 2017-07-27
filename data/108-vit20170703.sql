start transaction;

call set_athlet_id ('vit');

insert into `workout` (`workout_date`, `start_time`, `finish_time`, `athlet_id`)
  values
('2017-07-03', '2017-07-03 16:01', '2017-07-03 17:32', (select @athlet_id));

call set_workout_id ('vit', '2017-07-03');

/* split */
insert into `workout_type` (`wtype`) value ('split');

insert into `exercise` (`description`, `weight_kg`, `reps`, `rest_time_sec`, `set_number`, `workout_id`)
  values
('Статичні випади вперед', 15, 16, 180, 1, (select @workout_id)),
('Статичні випади вперед', 15, 10, 180, 2, (select @workout_id)),
('Пулл-овер стоячи', 23, 18, 120, 1, (select @workout_id)),
('Пулл-овер стоячи', 23, 16, 120, 2, (select @workout_id)),
('Пулл-овер стоячи', 23, 15, 120, 3, (select @workout_id)),
('Жим Свенда лежачи', 23, 16, 120, 1, (select @workout_id)),
('Жим Свенда лежачи', 23, 16, 120, 2, (select @workout_id)),
('Жим Свенда лежачи', 23, 16, 180, 3, (select @workout_id)),
('Махи у сторони', 8.2, 13, 150, 1, (select @workout_id)),
('Махи у сторони', 8.2, 13, 120, 2, (select @workout_id)),
('Махи у сторони', 8.2, 11, 120, 3, (select @workout_id)),
('Махи вперед', 8.2, 11, 120, 1, (select @workout_id)),
('Махи вперед', 8.2, 11, 120, 2, (select @workout_id)),
('Махи вперед', 8.2, 11, 180, 3, (select @workout_id)),
('Згинання рук стоячи', 13, 9, 180, 1, (select @workout_id)),
('Згинання рук стоячи', 13, 8, 180, 2, (select @workout_id)),
('Хаммер', 9, 12, 120, 1, (select @workout_id)),
('Хаммер', 9, 13, 120, 2, (select @workout_id)),
('Хаммер', 9, 14, 0, 3, (select @workout_id));

set @workout_id = null;

/* без екіпірування */
insert into `style` (`id`) select e.id from exercise e
  join workout w on e.workout_id = w.id
  join athlet a on w.athlet_id = a.id
where a.nickname = 'vit'
  and w.workout_date = '20170703';

/* гантелі */
insert into `equipment` (`id`) select e.id from exercise e
  join workout w on e.workout_id = w.id
  join athlet a on w.athlet_id = a.id
where a.nickname = 'vit'
  and w.workout_date = '20170703';

call calculate_workout_duration ('vit', '20170703');

call update_exercise_set_equipment ('vit', '20170703', 'гантель', 'Пулл-овер стоячи');
call update_exercise_set_equipment ('vit', '20170703', 'гантель', 'Жим Свенда лежачи');

call calculate_tonnage ('vit', '20170703');

set @athlet_id = null;

commit;
