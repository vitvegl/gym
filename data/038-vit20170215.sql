start transaction;

call set_athlet_id ('vit');

insert into `workout` (`workout_date`, `workout_duration`, `athlet_id`)
  values
('2017-02-15', null, (select @athlet_id));

call set_workout_id ('vit', '2017-02-15');

/* split */
insert into `workout_type` (`wtype`) value ('split');

insert into `exercise` (`description`, `weight_kg`, `reps`, `rest_time_sec`, `workout_id`)
  values
('Жим лежачи', 23, 14, 120, (select @workout_id)),
('Жим лежачи', 23, 10, 120, (select @workout_id)),
('Жим лежачи', 23, 8, 120, (select @workout_id)),
('Пулл-овер стоячи', 17, 16, 120, (select @workout_id)),
('Пулл-овер стоячи', 17, 15, 120, (select @workout_id)),
('Пулл-овер стоячи', 17, 13, 120, (select @workout_id)),
('Пулл-овер стоячи', 17, 12, 120, (select @workout_id)),
('Розведення рук лежачи', 13, 20, 90, (select @workout_id)),
('Розведення рук лежачи', 13, 16, 90, (select @workout_id)),
('Розведення рук лежачи', 13, 16, 90, (select @workout_id)),
('Шраги', 23, 20, 120, (select @workout_id)),
('Шраги', 23, 20, 120, (select @workout_id)),
('Шраги', 23, 20, 120, (select @workout_id)),
('Віджимання від підлоги', 0, 10, 90, (select @workout_id)),
('Віджимання від підлоги', 0, 10, 90, (select @workout_id)),
('Віджимання від підлоги', 0, 8, 90, (select @workout_id));

set @workout_id = null;

create view exercise_id as select e.id from exercise e
  join workout w on e.workout_id = w.id
  join athlet a on w.athlet_id = a.id
where a.nickname = 'vit' and w.workout_date = '2017-02-15';

/* без екіпірування */
insert into `style` (`id`) select id from exercise_id;

/* гантелі */
insert into `equipment` (`id`) select id from exercise_id;

call update_exercise_if_no_weight ('vit', '2017-02-15');

drop view exercise_id;

commit;