start transaction;

call set_athlet_id ('vit');

insert into `workout` (`workout_date`, `workout_duration`, `athlet_id`)
  values
('20170430', '1:50', (select @athlet_id));

call set_workout_id ('vit', '20170430');

/* split */
insert into `workout_type` (`wtype`) value ('split');

insert into `exercise` (`description`, `weight_kg`, `reps`, `rest_time_sec`, `workout_id`)
  values
('Жим лежачи', 50, 8, 120, (select @workout_id)),
('Жим лежачи', 60, 1, 120, (select @workout_id)),
('Станова тяга', 50, 10, 90, (select @workout_id)),
('Станова тяга', 50, 10, 90, (select @workout_id)),
('Станова тяга', 70, 6, 120, (select @workout_id)),
('Станова тяга', 90, 3, 120, (select @workout_id)),
('Станова тяга', 100, 2, 60, (select @workout_id)),
('Станова тяга', 100, 1, 180, (select @workout_id)),
('Армійський жим', 35, 6, 90, (select @workout_id)),
('Армійський жим', 35, 6, 90, (select @workout_id)),
('Присідання', 50, 10, 90, (select @workout_id)),
('Присідання', 50, 10, 90, (select @workout_id)),
('Тяга до підборіддя', 30, 10, 90, (select @workout_id)),
('Тяга до підборіддя', 30, 10, 90, (select @workout_id)),
('Шраги', 40, 20, 120, (select @workout_id)),
('Шраги', 50, 20, 120, (select @workout_id)),
('Пулл-овер стоячи', 12, 25, 120, (select @workout_id)),
('Пулл-овер стоячи', 12, 21, 120, (select @workout_id));

set @workout_id = null;

create view exercise_id as select e.id from exercise e
  join workout w on e.workout_id = w.id
  join athlet a on w.athlet_id = a.id
where a.nickname = 'vit'
  and w.workout_date = '20170430';

/* без екіпірування */
insert into `style` (`id`) select id from exercise_id;

/* штанга */
insert into `equipment` (`id`, `equipment`) select id, 'штанга' from exercise_id;

/* Пулл-овер з гантелею */
call update_exercise_set_equipment ('vit', '20170430', 'гантель', 'Пулл-овер стоячи');

drop view exercise_id;

commit;