start transaction;

call set_athlet_id ('vit');

insert into `workout` (`workout_date`, `athlet_id`)
  values
('2016-11-30', (select @athlet_id));

call set_workout_id ('vit', '2016-11-30');

/* split */
insert into `workout_type` (`type`) values ('split');

insert into `exercise` (`description`, `weight_kg`, `reps`, `rest_time_sec`, `workout_id`)
  values
('Жим лежачи', 20, 10, 120, (select @workout_id)),
('Жим лежачи', 20, 10, 120, (select @workout_id)),
('Жим лежачи', 20, 10, 120, (select @workout_id)),
('Французький жим лежачи', 7, 10, 90, (select @workout_id)),
('Французький жим лежачи', 7, 10, 90, (select @workout_id)),
('Французький жим лежачи', 7, 10, 90, (select @workout_id)),
('Пулл-овер стоячи', 13, 10, 120, (select @workout_id)),
('Пулл-овер стоячи', 13, 10, 120, (select @workout_id)),
('Пулл-овер стоячи', 13, 10, 120, (select @workout_id)),
('Віджимання від підлоги', 0, 10, 120, (select @workout_id)),
('Віджимання від підлоги', 0, 10, 120, (select @workout_id)),
('Віджимання від підлоги', 0, 10, 120, (select @workout_id));

set @workout_id = null;

create view exercise_id as select e.id from exercise e
  join workout w on e.workout_id = w.id
  join athlet a on w.athlet_id = a.id
where a.nickname = 'vit' and w.workout_date = '2016-11-30';

/* без екіпіровки */
insert into `style` (`id`) select id from exercise_id;

/* гантелі */
insert into `equipment` (`id`) select id from exercise_id;

drop view exercise_id;

commit;
