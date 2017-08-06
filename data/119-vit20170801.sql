start transaction;

call set_athlet_id ('vit');

insert into `workout` (`workout_date`, `start_time`, `finish_time`, `athlet_id`)
  values
('20170801', '2017-08-01 19:05', '2017-08-01 19:56', (select @athlet_id));

call set_workout_id ('vit', '20170801');

/* split */
insert into `workout_type` (`wtype`) value ('split');

insert into `exercise` (`description`, `weight_kg`, `reps`, `rest_time_sec`, `set_number`, `workout_id`)
  values
('Розведення рук лежачи', 13, 16, 0, 1, (select @workout_id)),
('Жим лежачи', 13, 16, 30, 1, (select @workout_id)),
('Розведення рук лежачи', 13, 20, 0, 2, (select @workout_id)),
('Жим лежачи', 13, 0, 180, 2, (select @workout_id)),
('Присідання Пліє', 40, 20, 180, 1, (select @workout_id)),
('Присідання Пліє', 40, 20, 180, 2, (select @workout_id)),
('Присідання Пліє', 40, 20, 180, 3, (select @workout_id)),
('Пулл-овер стоячи', 25, 14, 180, 1, (select @workout_id)),
('Пулл-овер стоячи', 25, 12, 180, 2, (select @workout_id)),
('Пулл-овер стоячи', 25, 10, 0, 3, (select @workout_id));

set @workout_id = null;

/* без екіпірування */
insert into `style` (`id`) select e.id from exercise e
  join workout w on e.workout_id = w.id
  join athlet a on w.athlet_id = a.id
where a.nickname = 'vit'
  and w.workout_date = '20170801';

/* гантелі */
insert into `equipment` (`id`) select e.id from exercise e
  join workout w on e.workout_id = w.id
  join athlet a on w.athlet_id = a.id
where a.nickname = 'vit'
  and w.workout_date = '20170801';

call calculate_workout_duration ('vit', '20170801');

call update_exercise_set_equipment ('vit', '20170801', 'гантель', 'Присідання Пліє');
call update_exercise_set_equipment ('vit', '20170801', 'гантель', 'Пулл-овер стоячи');

call calculate_tonnage ('vit', '20170801');

set @athlet_id = null;

commit;
