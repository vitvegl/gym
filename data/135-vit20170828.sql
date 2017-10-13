start transaction;

call set_athlet_id ('vit');

insert into `workout` (`workout_date`, `start_time`, `finish_time`, `athlet_id`)
  values
('20170828', '2017-08-28 19:54', '2017-08-28 20:52', (select @athlet_id));

call set_workout_id ('vit', '20170828');

/* split */
insert into `workout_type` (`wtype`) value ('split');

insert into `exercise` (`description`, `weight_kg`, `reps`, `rest_time_sec`, `set_number`, `workout_id`)
  values
('Жим лежачи', 21, 15, 180, 1, (select @workout_id)),
('Жим лежачи', 21, 15, 180, 2, (select @workout_id)),
('Жим лежачи', 21, 15, 120, 3, (select @workout_id)),
('Пулл-овер стоячи', 27, 8, 120, 1, (select @workout_id)),
('Пулл-овер стоячи', 27, 8, 120, 2, (select @workout_id)),
('Розведення рук лежачи', 13, 20, 120, 1, (select @workout_id)),
('Розведення рук лежачи', 13, 15, 120, 2, (select @workout_id)),
('Розведення рук лежачи', 13, 15, 120, 3, (select @workout_id)),
('Віджимання від підлоги', 0, 18, 120, 1, (select @workout_id)),
('Віджимання від підлоги', 0, 12, 120, 2, (select @workout_id)),
('Згинання рук стоячи', 13, 10, 180, 1, (select @workout_id)),
('Згинання рук стоячи', 13, 10, 180, 2, (select @workout_id)),
('Згинання рук стоячи', 13, 10, 120, 3, (select @workout_id)),
('Станова тяга', 21, 20, 120, 1, (select @workout_id)),
('Станова тяга', 21, 20, 120, 2, (select @workout_id)),
('Шраги', 27, 23, 120, 1, (select @workout_id)),
('Шраги', 27, 20, 0, 2, (select @workout_id));

set @workout_id = null;

/* без екіпірування */
insert into `style` (`id`) select e.id from exercise e
  join workout w on e.workout_id = w.id
  join athlet a on w.athlet_id = a.id
where a.nickname = 'vit'
  and w.workout_date = '20170828';

/* гантелі */
insert into `equipment` (`id`) select e.id from exercise e
  join workout w on e.workout_id = w.id
  join athlet a on w.athlet_id = a.id
where a.nickname = 'vit'
  and w.workout_date = '20170828';

call update_exercise_if_no_weight ('vit', '20170828');

call calculate_workout_duration ('vit', '20170828');

call update_exercise_set_equipment ('vit', '20170828', 'гантель', 'Пулл-овер стоячи');

call calculate_tonnage ('vit', '20170828');

set @athlet_id = null;

commit;
