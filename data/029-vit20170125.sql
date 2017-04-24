start transaction;

call set_athlet_id ('vit');

insert into `workout` (`workout_date`, `workout_duration`, `athlet_id`)
  values
('2017-01-25', '0:46', (select @athlet_id));

call set_workout_id ('vit', '2017-01-25');

/* split */
insert into `workout_type` (`wtype`) value ('split');

insert into `exercise` (`description`, `weight_kg`, `reps`, `rest_time_sec`, `workout_id`)
  values
('Жим лежачи', 24.2, 8, 120, (select @workout_id)),
('Жим лежачи', 23, 12, 120, (select @workout_id)),
('Жим лежачи', 23, 8, 120, (select @workout_id)),
('Жим лежачи', 23, 4, 120, (select @workout_id)),
('Французький жим лежачи', 11, 10, 90, (select @workout_id)),
('Французький жим лежачи', 11, 10, 90, (select @workout_id)),
('Французький жим лежачи', 11, 10, 90, (select @workout_id)),
('Французький жим лежачи', 11, 10, 90, (select @workout_id)),
('Французький жим лежачи', 11, 10, 90, (select @workout_id)),
('Пулл-овер стоячи', 15, 16, 90, (select @workout_id)),
('Пулл-овер стоячи', 15, 14, 90, (select @workout_id)),
('Пулл-овер стоячи', 15, 16, 90, (select @workout_id)),
('Пулл-овер стоячи', 15, 11, 90, (select @workout_id)),
('Розведення рук лежачи', 15, 10, 120, (select @workout_id)),
('Розведення рук лежачи', 15, 7, 120, (select @workout_id)),
('Розведення рук лежачи', 15, 6, 120, (select @workout_id)),
('Шраги', 21, 20, 120, (select @workout_id)),
('Шраги', 21, 20, 120, (select @workout_id)),
('Шраги', 21, 20, 120, (select @workout_id));

set @workout_id = null;

create view exercise_id as select e.id from exercise e
  join workout w on e.workout_id = w.id
  join athlet a on w.athlet_id = a.id
where a.nickname = 'vit' and w.workout_date = '2017-01-25';

/* без екіпірування */
insert into `style` (`id`) select id from exercise_id;

/* гантелі */
insert into `equipment` (`id`) select id from exercise_id;

drop view exercise_id;

commit;
