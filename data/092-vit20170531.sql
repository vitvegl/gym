start transaction;

call set_athlet_id ('vit');

insert into `workout` (`workout_date`, `start_time`, `finish_time`, `athlet_id`)
  values
('20170531', '2017-05-31 23:22', '2017-06-01 00:05', (select @athlet_id));

call set_workout_id ('vit', '20170531');

/* split */
insert into `workout_type` (`wtype`) value ('split');

insert into `exercise` (`description`, `weight_kg`, `reps`, `rest_time_sec`, `set_number`, `workout_id`)
  values
('Жим лежачи', 21, 16, 120, 1, (select @workout_id)),
('Жим лежачи', 21, 16, 120, 2, (select @workout_id)),
('Жим лежачи', 21, 12, 120, 3, (select @workout_id)),
('Французький жим лежачи', 9, 12, 60, 1, (select @workout_id)),
('Французький жим лежачи', 9, 12, 60, 2, (select @workout_id)),
('Французький жим лежачи', 9, 12, 60, 3, (select @workout_id)),
('Французький жим лежачи', 9, 12, 60, 4, (select @workout_id)),
('Пулл-овер стоячи', 21, 14, 90, 1, (select @workout_id)),
('Пулл-овер стоячи', 21, 12, 90, 2, (select @workout_id)),
('Пулл-овер стоячи', 21, 10, 90, 3, (select @workout_id)),
('Шраги', 27, 20, 90, 1, (select @workout_id)),
('Шраги', 27, 20, 90, 2, (select @workout_id)),
('Шраги', 27, 20, 90, 3, (select @workout_id)),
('Шраги', 27, 20, 0, 4, (select @workout_id));

set @workout_id = null;

/* без екіпірування */
insert into `style` (`id`) select e.id from exercise e
  join workout w on e.workout_id = w.id
  join athlet a on w.athlet_id = a.id
where a.nickname = 'vit'
  and w.workout_date = '20170531';

/* гантелі */
insert into `equipment` (`id`) select e.id from exercise e
  join workout w on e.workout_id = w.id
  join athlet a on w.athlet_id = a.id
where a.nickname = 'vit'
  and w.workout_date = '20170531';

call calculate_workout_duration ('vit', '20170531');

/* call update_exercise_set_equipment_specific_set ('vit', '20170531', 'гантель', 'Пулл-овер стоячи', 1); */
/* call update_exercise_set_equipment_specific_set ('vit', '20170531', 'гантель', 'Пулл-овер стоячи', 2); */
/* call update_exercise_set_equipment_specific_set ('vit', '20170531', 'гантель', 'Пулл-овер стоячи', 3); */
call update_exercise_set_equipment ('vit', '20170531', 'гантель', 'Пулл-овер стоячи');

call calculate_tonnage ('vit', '20170531');

set @athlet_id = null;

commit;
