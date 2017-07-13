start transaction;

call set_athlet_id ('vit');

insert into `workout` (`workout_date`, `workout_duration`, `athlet_id`)
  values
('2016-12-14', null, (select @athlet_id));

call set_workout_id ('vit', '2016-12-14');

/* split */
insert into `workout_type` (`wtype`) values ('split');

insert into `exercise` (`description`, `weight_kg`, `reps`, `rest_time_sec`, `set_number`, `workout_id`)
  values
('Жим лежачи', 21, 10, 120, 1, (select @workout_id)),
('Жим лежачи', 21, 10, 120, 2, (select @workout_id)),
('Жим лежачи', 21, 8, 120, 3, (select @workout_id)),
('Французький жим лежачи', 9, 8, 90, 1, (select @workout_id)),
('Французький жим лежачи', 9, 8, 90, 2, (select @workout_id)),
('Французький жим лежачи', 9, 8, 90, 3, (select @workout_id)),
('Французький жим лежачи', 9, 8, 90, 4, (select @workout_id)),
('Французький жим лежачи', 9, 8, 90, 5, (select @workout_id)),
('Пулл-овер стоячи', 13, 10, 120, 1, (select @workout_id)),
('Пулл-овер стоячи', 13, 9, 120, 2, (select @workout_id)),
('Пулл-овер стоячи', 13, 10, 120, 3, (select @workout_id)),
('Пулл-овер стоячи', 13, 8, 120, 4, (select @workout_id)),
('Розведення рук лежачи', 13, 10, 120, 1, (select @workout_id)),
('Розведення рук лежачи', 13, 8, 120, 2, (select @workout_id)),
('Розведення рук лежачи', 13, 8, 120, 3, (select @workout_id)),
('Розведення рук лежачи', 13, 8, 120, 4, (select @workout_id)),
('Віджимання від підлоги', 0, 7, 120, 1, (select @workout_id)),
('Віджимання від підлоги', 0, 7, 120, 2, (select @workout_id)),
('Віджимання від підлоги', 0, 7, 120, 3, (select @workout_id)),
('Шраги', 25, 10, 120, 1, (select @workout_id)),
('Шраги', 25, 10, 120, 2, (select @workout_id)),
('Шраги', 25, 10, 120, 3, (select @workout_id)),
('Шраги', 25, 10, 0, 4, (select @workout_id));

set @workout_id = null;

/* без екіпірування */
insert into `style` (`id`) select e.id from exercise e
  join workout w on e.workout_id = w.id
  join athlet a on w.athlet_id = a.id
where a.nickname = 'vit' and w.workout_date = '2016-12-14';

/* гантелі */
insert into `equipment` (`id`) select e.id from exercise e
  join workout w on e.workout_id = w.id
  join athlet a on w.athlet_id = a.id
where a.nickname = 'vit' and w.workout_date = '2016-12-14';

/* вправи з вагою тіла */
call update_exercise_if_no_weight ('vit', '2016-12-14');

/* call update_exercise_set_equipment_specific_set ('vit', '2016-12-14', 'гантель', 'Пулл-овер стоячи', 1); */
/* call update_exercise_set_equipment_specific_set ('vit', '2016-12-14', 'гантель', 'Пулл-овер стоячи', 2); */
/* call update_exercise_set_equipment_specific_set ('vit', '2016-12-14', 'гантель', 'Пулл-овер стоячи', 3); */
/* call update_exercise_set_equipment_specific_set ('vit', '2016-12-14', 'гантель', 'Пулл-овер стоячи', 4); */
call update_exercise_set_equipment ('vit', '2016-12-14', 'гантель', 'Пулл-овер стоячи');

call calculate_tonnage ('vit', '2016-12-14');

set @athlet_id = null;

commit;
