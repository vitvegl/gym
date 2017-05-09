start transaction;

call set_athlet_id ('vit');

insert into `workout` (`workout_date`, `workout_duration`, `athlet_id`)
  values
('2017-01-11', '1:24', (select @athlet_id));

call set_workout_id ('vit', '2017-01-11');

/* split */
insert into `workout_type` (`wtype`) value ('split');

insert into `exercise` (`description`, `weight_kg`, `reps`, `rest_time_sec`, `workout_id`)
  values
('Жим лежачи', 22.5, 12, 120, (select @workout_id)),
('Жим лежачи', 22.5, 10, 120, (select @workout_id)),
('Жим лежачи', 22.5, 8, 120, (select @workout_id)),
('Жим лежачи', 22.5, 7, 120, (select @workout_id)),
('Французький жим лежачи', 9, 10, 90, (select @workout_id)),
('Французький жим лежачи', 9, 10, 90, (select @workout_id)),
('Французький жим лежачи', 9, 10, 90, (select @workout_id)),
('Французький жим лежачи', 9, 10, 90, (select @workout_id)),
('Французький жим лежачи', 9, 10, 90, (select @workout_id)),
('Пулл-овер стоячи', 15, 10, 120, (select @workout_id)),
('Пулл-овер стоячи', 15, 10, 120, (select @workout_id)),
('Пулл-овер стоячи', 15, 10, 120, (select @workout_id)),
('Пулл-овер стоячи', 15, 10, 120, (select @workout_id)),
('Розведення рук лежачи', 15, 10, 120, (select @workout_id)),
('Розведення рук лежачи', 15, 7, 120, (select @workout_id)),
('Віджимання від підлоги', 0, 8, 90, (select @workout_id)),
('Віджимання від підлоги', 0, 8, 90, (select @workout_id)),
('Віджимання від підлоги', 0, 7, 90, (select @workout_id)),
('Шраги', 21, 16, 120, (select @workout_id)),
('Шраги', 21, 16, 120, (select @workout_id)),
('Шраги', 21, 16, 120, (select @workout_id)),
('Присідання Пліє', 33, 16, 120, (select @workout_id)),
('Присідання Пліє', 33, 16, 120, (select @workout_id)),
('Присідання Пліє', 33, 16, 120, (select @workout_id));

set @workout_id = null;

/* без екіпірування */
insert into `style` (`id`) select e.id from exercise e
  join workout w on e.workout_id = w.id
  join athlet a on w.athlet_id = a.id
where a.nickname = 'vit' and w.workout_date = '2017-01-11';

/* гантелі */
insert into `equipment` (`id`) select e.id from exercise e
  join workout w on e.workout_id = w.id
  join athlet a on w.athlet_id = a.id
where a.nickname = 'vit' and w.workout_date = '2017-01-11';

/* вправи з вагою тіла */
call update_exercise_if_no_weight ('vit', '2017-01-11');

commit;
