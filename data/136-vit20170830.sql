start transaction;

call set_athlet_id ('vit');

insert into `workout` (`workout_date`, `start_time`, `finish_time`, `athlet_id`)
  values
('20170830', '2017-08-30 14:38', '2017-08-30 15:29', (select @athlet_id));

call set_workout_id ('vit', '20170830');

/* split */
insert into `workout_type` (`wtype`) value ('split');

insert into `exercise` (`description`, `weight_kg`, `reps`, `rest_time_sec`, `set_number`, `workout_id`)
  values
('Жим стоячи', 13, 17, 120, 1, (select @workout_id)),
('Жим стоячи', 13, 17, 180, 2, (select @workout_id)),
('Жим стоячи', 13, 17, 180, 3, (select @workout_id)),
('Станова тяга', 33, 10, 120, 1, (select @workout_id)),
('Станова тяга', 33, 10, 180, 2, (select @workout_id)),
('Пулл-овер стоячи', 27, 10, 120, 1, (select @workout_id)),
('Пулл-овер стоячи', 27, 10, 120, 2, (select @workout_id)),
('Махи у сторони', 7, 16, 120, 1, (select @workout_id)),
('Махи у сторони', 7, 16, 120, 2, (select @workout_id)),
('Махи у сторони', 7, 16, 120, 3, (select @workout_id)),
('Махи вперед', 9, 10, 120, 1, (select @workout_id)),
('Махи вперед', 9, 10, 120, 2, (select @workout_id)),
('Махи вперед', 9, 10, 120, 3, (select @workout_id)),
('Тяга 1 рукою у нахилі', 33, 10, 120, 1, (select @workout_id)),
('Тяга 1 рукою у нахилі', 33, 10, 0, 2, (select @workout_id));

set @workout_id = null;

/* без екіпірування */
insert into `style` (`id`) select e.id from exercise e
  join workout w on e.workout_id = w.id
  join athlet a on w.athlet_id = a.id
where a.nickname = 'vit'
  and w.workout_date = '20170830';

/* гантелі */
insert into `equipment` (`id`) select e.id from exercise e
  join workout w on e.workout_id = w.id
  join athlet a on w.athlet_id = a.id
where a.nickname = 'vit'
  and w.workout_date = '20170830';

call calculate_workout_duration ('vit', '20170830');

call update_exercise_set_equipment ('vit', '20170830', 'гантель', 'Пулл-овер стоячи');

call calculate_tonnage ('vit', '20170830');

set @athlet_id = null;

commit;
