start transaction;

call set_athlet_id ('vit');

insert into `workout` (`workout_date`, `start_time`, `finish_time`, `athlet_id`)
  values
('20170817', '2017-08-17 21:53', '2017-08-17 22:24', (select @athlet_id));

call set_workout_id ('vit', '20170817');

/* split */
insert into `workout_type` (`wtype`) value ('split');

insert into `exercise` (`description`, `weight_kg`, `reps`, `rest_time_sec`, `set_number`, `workout_id`)
  values
('Станова тяга', 33, 14, 180, 1, (select @workout_id)),
('Станова тяга', 33, 11, 180, 2, (select @workout_id)),
('Згинання рук стоячи', 9, 16, 150, 1, (select @workout_id)),
('Згинання рук стоячи', 9, 14, 180, 2, (select @workout_id)),
('Згинання рук стоячи', 9, 15, 180, 3, (select @workout_id)),
('Пулл-овер стоячи', 25, 13, 120, 1, (select @workout_id)),
('Пулл-овер стоячи', 25, 12, 0, 2, (select @workout_id));

set @workout_id = null;

/* без екіпірування */
insert into `style` (`id`) select e.id from exercise e
  join workout w on e.workout_id = w.id
  join athlet a on w.athlet_id = a.id
where a.nickname = 'vit'
  and w.workout_date = '20170817';

/* гантелі */
insert into `equipment` (`id`) select e.id from exercise e
  join workout w on e.workout_id = w.id
  join athlet a on w.athlet_id = a.id
where a.nickname = 'vit'
  and w.workout_date = '20170817';

call calculate_workout_duration ('vit', '20170817');

call update_exercise_set_equipment ('vit', '20170817', 'гантель', 'Пулл-овер стоячи');

call calculate_tonnage ('vit', '20170817');

set @athlet_id = null;

commit;
