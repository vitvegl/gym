start transaction;

call set_athlet_id ('vit');

insert into `workout` (`workout_date`, `workout_duration`, `athlet_id`)
  values
('2017-02-23', '0:50', (select @athlet_id));

call set_workout_id ('vit', '2017-02-23');

/* split */
insert into `workout_type` (`wtype`) value ('split');

insert into `exercise` (`description`, `weight_kg`, `reps`, `rest_time_sec`, `set_number`, `workout_id`)
  values
('Жим лежачи', 23, 12, 120, 1, (select @workout_id)),
('Жим лежачи', 23, 8, 120, 2, (select @workout_id)),
('Жим лежачи', 23, 7, 120, 3, (select @workout_id)),
('Пулл-овер стоячи', 19, 12, 120, 1, (select @workout_id)),
('Пулл-овер стоячи', 19, 10, 120, 2, (select @workout_id)),
('Пулл-овер стоячи', 19, 8, 120, 3, (select @workout_id)),
('Розведення рук лежачи', 13, 20, 120, 1, (select @workout_id)),
('Розведення рук лежачи', 13, 16, 120, 2, (select @workout_id)),
('Розведення рук лежачи', 13, 16, 120, 3, (select @workout_id)),
('Шраги', 23, 24, 120, 1, (select @workout_id)),
('Шраги', 23, 20, 120, 2, (select @workout_id)),
('Шраги', 23, 20, 120, 3, (select @workout_id)),
('Віджимання від підлоги', 0, 12, 90, 1, (select @workout_id)),
('Віджимання від підлоги', 0, 12, 90, 2, (select @workout_id)),
('Віджимання від підлоги', 0, 10, 0, 3, (select @workout_id));

set @workout_id = null;

/* без екіпірування */
insert into `style` (`id`) select e.id from exercise e
  join workout w on e.workout_id = w.id
  join athlet a on w.athlet_id = a.id
where a.nickname = 'vit' and w.workout_date = '2017-02-23';

/* гантелі */
insert into `equipment` (`id`) select e.id from exercise e
  join workout w on e.workout_id = w.id
  join athlet a on w.athlet_id = a.id
where a.nickname = 'vit' and w.workout_date = '2017-02-23';

call update_exercise_if_no_weight ('vit', '2017-02-23');

/* call update_exercise_set_equipment_specific_set ('vit', '2017-02-23', 'гантель', 'Пулл-овер стоячи', 1); */
/* call update_exercise_set_equipment_specific_set ('vit', '2017-02-23', 'гантель', 'Пулл-овер стоячи', 2); */
/* call update_exercise_set_equipment_specific_set ('vit', '2017-02-23', 'гантель', 'Пулл-овер стоячи', 3); */
call update_exercise_set_equipment ('vit', '2017-02-23', 'гантель', 'Пулл-овер стоячи');

call calculate_tonnage ('vit', '2017-02-23');

set @athlet_id = null;

commit;
