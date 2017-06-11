start transaction;

call set_athlet_id ('vit');

insert into `workout` (`workout_date`, `workout_duration`, `athlet_id`)
  values
('20170315', '01:14', (select @athlet_id));

call set_workout_id ('vit', '20170315');

/* split */
insert into `workout_type` (`wtype`) value ('split');

insert into `exercise` (`description`, `weight_kg`, `reps`, `rest_time_sec`, `set_number`, `workout_id`)
  values
('Станова тяга', 33, 16, 120, 1, (select @workout_id)),
('Станова тяга', 33, 15, 120, 2, (select @workout_id)),
('Станова тяга', 33, 15, 120, 3, (select @workout_id)),
('Пулл-овер стоячи', 19, 14, 120, 1, (select @workout_id)),
('Пулл-овер стоячи', 19, 12, 120, 2, (select @workout_id)),
('Пулл-овер стоячи', 19, 12, 120, 3, (select @workout_id)),
('Тяга 1 рукою у нахилі', 23, 14, 120, 1, (select @workout_id)),
('Тяга 1 рукою у нахилі', 23, 14, 120, 2, (select @workout_id)),
('Французький жим лежачи', 9, 12, 60, 1, (select @workout_id)),
('Французький жим лежачи', 9, 12, 60, 2, (select @workout_id)),
('Французький жим лежачи', 9, 12, 60, 3, (select @workout_id)),
('Віджимання від підлоги', 0, 10, 90, 1, (select @workout_id)),
('Віджимання від підлоги', 0, 7, 0, 2, (select @workout_id));

set @workout_id = null;

/* без екіпірування */
insert into `style` (`id`) select e.id from exercise e
  join workout w on e.workout_id = w.id
  join athlet a on w.athlet_id = a.id
where a.nickname = 'vit'
  and w.workout_date = '20170315';

/* гантелі */
insert into `equipment` (`id`) select e.id from exercise e
  join workout w on e.workout_id = w.id
  join athlet a on w.athlet_id = a.id
where a.nickname = 'vit'
  and w.workout_date = '20170315';

call update_exercise_if_no_weight ('vit', '20170315');

call update_exercise_set_equipment ('vit', '20170315', 'гантель', 'Пулл-овер стоячи', 1);
call update_exercise_set_equipment ('vit', '20170315', 'гантель', 'Пулл-овер стоячи', 2);
call update_exercise_set_equipment ('vit', '20170315', 'гантель', 'Пулл-овер стоячи', 3);

call calculate_tonnage ('vit', '20170315');

set @athlet_id = null;

commit;
