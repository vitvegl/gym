start transaction;

call set_athlet_id ('vit');

insert into `workout` (`workout_date`, `workout_duration`, `athlet_id`)
  values
('2016-12-14', null, (select @athlet_id));

call set_workout_id ('vit', '2016-12-14');

/* split */
insert into `workout_type` (`wtype`) values ('split');

insert into `exercise` (`description`, `weight_kg`, `reps`, `rest_time_sec`, `workout_id`)
  values
('Жим лежачи', 21, 10, 120, (select @workout_id)),
('Жим лежачи', 21, 10, 120, (select @workout_id)),
('Жим лежачи', 21, 8, 120, (select @workout_id)),
('Французький жим лежачи', 9, 8, 90, (select @workout_id)),
('Французький жим лежачи', 9, 8, 90, (select @workout_id)),
('Французький жим лежачи', 9, 8, 90, (select @workout_id)),
('Французький жим лежачи', 9, 8, 90, (select @workout_id)),
('Французький жим лежачи', 9, 8, 90, (select @workout_id)),
('Пулл-овер стоячи', 13, 10, 120, (select @workout_id)),
('Пулл-овер стоячи', 13, 9, 120, (select @workout_id)),
('Пулл-овер стоячи', 13, 10, 120, (select @workout_id)),
('Пулл-овер стоячи', 13, 8, 120, (select @workout_id)),
('Розведення рук лежачи', 13, 10, 120, (select @workout_id)),
('Розведення рук лежачи', 13, 8, 120, (select @workout_id)),
('Розведення рук лежачи', 13, 8, 120, (select @workout_id)),
('Розведення рук лежачи', 13, 8, 120, (select @workout_id)),
('Віджимання від підлоги', 0, 7, 120, (select @workout_id)),
('Віджимання від підлоги', 0, 7, 120, (select @workout_id)),
('Віджимання від підлоги', 0, 7, 120, (select @workout_id)),
('Шраги', 25, 10, 120, (select @workout_id)),
('Шраги', 25, 10, 120, (select @workout_id)),
('Шраги', 25, 10, 120, (select @workout_id)),
('Шраги', 25, 10, 120, (select @workout_id));

set @workout_id = null;

create view exercise_id as select e.id from exercise e
  join workout w on e.workout_id = w.id
  join athlet a on w.athlet_id = a.id
where a.nickname = 'vit' and w.workout_date = '2016-12-14';

/* без екіпірування */
insert into `style` (`id`) select id from exercise_id;

/* гантелі */
insert into `equipment` (`id`) select id from exercise_id;

drop view exercise_id;

commit;
