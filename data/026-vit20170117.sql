start transaction;

call set_athlet_id ('vit');

insert into `workout` (`workout_date`, `workout_duration`, `athlet_id`)
  values
('2017-01-17', '1:15', (select @athlet_id));

call set_workout_id ('vit', '2017-01-17');

/* split */
insert into `workout_type` (`wtype`) value ('split');

insert into `exercise` (`description`, `weight_kg`, `reps`, `rest_time_sec`, `workout_id`)
  values
('Жим лежачи', 23, 12, 120, (select @workout_id)),
('Жим лежачи', 23, 10, 120, (select @workout_id)),
('Жим лежачи', 23, 7, 120, (select @workout_id)),
('Жим лежачи', 23, 5, 120, (select @workout_id)),
('Французький жим лежачи', 11, 10, 90, (select @workout_id)),
('Французький жим лежачи', 11, 10, 90, (select @workout_id)),
('Французький жим лежачи', 11, 10, 90, (select @workout_id)),
('Французький жим лежачи', 11, 10, 90, (select @workout_id)),
('Французький жим лежачи', 11, 10, 90, (select @workout_id)),
('Пулл-овер стоячи', 15, 10, 120, (select @workout_id)),
('Пулл-овер стоячи', 15, 10, 120, (select @workout_id)),
('Пулл-овер стоячи', 15, 10, 120, (select @workout_id)),
('Пулл-овер стоячи', 15, 10, 120, (select @workout_id)),
('Розведення рук лежачи', 15, 8, 120, (select @workout_id)),
('Розведення рук лежачи', 15, 8, 120, (select @workout_id)),
('Розведення рук лежачи', 15, 6, 120, (select @workout_id)),
('Шраги', 21, 16, 120, (select @workout_id)),
('Шраги', 21, 16, 120, (select @workout_id)),
('Шраги', 21, 16, 120, (select @workout_id)),
('Присідання Пліє', 33, 16, 120, (select @workout_id)),
('Присідання Пліє', 33, 16, 120, (select @workout_id)),
('Присідання Пліє', 33, 20, 120, (select @workout_id)),
('Віджимання від підлоги', 0, 10, 120, (select @workout_id)),
('Віджимання від підлоги', 0, 10, 120, (select @workout_id)),
('Віджимання від підлоги', 0, 9, 120, (select @workout_id));

set @workout_id = null;

create view exercise_id as select e.id from exercise e
  join workout w on e.workout_id = w.id
  join athlet a on w.athlet_id = a.id
where a.nickname = 'vit' and w.workout_date = '2017-01-17';

/* без екіпірування */
insert into `style` (`id`) select id from exercise_id;

/* гантелі */
insert into `equipment` (`id`) select id from exercise_id;

/* вправи з вагою тіла */
call update_exercise_if_no_weight ('vit', '2017-01-17');

drop view exercise_id;

commit;
