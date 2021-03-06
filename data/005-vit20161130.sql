start transaction;

call set_athlet_id ('vit');

insert into `workout` (`workout_date`, `athlet_id`)
  values
('2016-11-30', (select @athlet_id));

call set_workout_id ('vit', '2016-11-30');

/* split */
insert into `workout_type` (`wtype`) values ('split');

insert into `exercise` (`description`, `weight_kg`, `reps`, `rest_time_sec`, `set_number`, `workout_id`)
  values
('Жим лежачи', 20, 10, 120, 1, (select @workout_id)),
('Жим лежачи', 20, 10, 120, 2, (select @workout_id)),
('Жим лежачи', 20, 10, 120, 3, (select @workout_id)),
('Французький жим лежачи', 7, 10, 90, 1, (select @workout_id)),
('Французький жим лежачи', 7, 10, 90, 2, (select @workout_id)),
('Французький жим лежачи', 7, 10, 90, 3, (select @workout_id)),
('Пулл-овер стоячи', 13, 10, 120, 1, (select @workout_id)),
('Пулл-овер стоячи', 13, 10, 120, 2, (select @workout_id)),
('Пулл-овер стоячи', 13, 10, 120, 3, (select @workout_id)),
('Віджимання від підлоги', 0, 10, 120, 1, (select @workout_id)),
('Віджимання від підлоги', 0, 10, 120, 2, (select @workout_id)),
('Віджимання від підлоги', 0, 10, 0, 3, (select @workout_id));

set @workout_id = null;

/* без екіпіровки */
insert into `style` (`id`) select e.id from exercise e
  join workout w on e.workout_id = w.id
  join athlet a on w.athlet_id = a.id
where a.nickname = 'vit' and w.workout_date = '2016-11-30';

/* гантелі */
insert into `equipment` (`id`) select e.id from exercise e
  join workout w on e.workout_id = w.id
  join athlet a on w.athlet_id = a.id
where a.nickname = 'vit' and w.workout_date = '2016-11-30';

/* вправи з вагою тіла */
call update_exercise_if_no_weight ('vit', '2016-11-30');

/* call update_exercise_set_equipment_specific_set ('vit', '2016-11-30', 'гантель', 'Пулл-овер стоячи', 1); */
/* call update_exercise_set_equipment_specific_set ('vit', '2016-11-30', 'гантель', 'Пулл-овер стоячи', 2); */
/* call update_exercise_set_equipment_specific_set ('vit', '2016-11-30', 'гантель', 'Пулл-овер стоячи', 3); */
call update_exercise_set_equipment ('vit', '2016-11-30', 'гантель', 'Пулл-овер стоячи');

call calculate_tonnage ('vit', '2016-11-30');

set @athlet_id = null;

commit;
