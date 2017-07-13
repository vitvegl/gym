start transaction;

call set_athlet_id ('vit');

insert into `workout` (`workout_date`, `workout_duration`, `athlet_id`)
  values
('20170430', '1:50', (select @athlet_id));

call set_workout_id ('vit', '20170430');

/* split */
insert into `workout_type` (`wtype`) value ('split');

insert into `exercise` (`description`, `weight_kg`, `reps`, `rest_time_sec`, `set_number`, `workout_id`)
  values
('Жим лежачи', 50, 8, 120, 1, (select @workout_id)),
('Жим лежачи', 60, 1, 120, 2, (select @workout_id)),
('Станова тяга', 50, 10, 90, 1, (select @workout_id)),
('Станова тяга', 50, 10, 90, 2, (select @workout_id)),
('Станова тяга', 70, 6, 120, 3, (select @workout_id)),
('Станова тяга', 90, 3, 120, 4, (select @workout_id)),
('Станова тяга', 100, 2, 60, 5, (select @workout_id)),
('Станова тяга', 100, 1, 180, 6, (select @workout_id)),
('Армійський жим', 35, 6, 90, 1, (select @workout_id)),
('Армійський жим', 35, 6, 90, 2, (select @workout_id)),
('Присідання', 50, 10, 90, 1, (select @workout_id)),
('Присідання', 50, 10, 90, 2, (select @workout_id)),
('Тяга до підборіддя', 30, 10, 90, 1, (select @workout_id)),
('Тяга до підборіддя', 30, 10, 90, 2, (select @workout_id)),
('Шраги', 40, 20, 120, 1, (select @workout_id)),
('Шраги', 50, 20, 120, 2, (select @workout_id)),
('Пулл-овер стоячи', 12, 25, 120, 1, (select @workout_id)),
('Пулл-овер стоячи', 12, 21, 0, 2, (select @workout_id));

set @workout_id = null;

/* без екіпірування */
insert into `style` (`id`) select e.id from exercise e
  join workout w on e.workout_id = w.id
  join athlet a on w.athlet_id = a.id
where a.nickname = 'vit'
  and w.workout_date = '20170430';

/* штанга */
insert into `equipment` (`id`, `equipment`) select e.id, 'штанга' from exercise e
  join workout w on e.workout_id = w.id
  join athlet a on w.athlet_id = a.id
where a.nickname = 'vit'
  and w.workout_date = '20170430';

/* Пулл-овер з гантелею */
/* call update_exercise_set_equipment_specific_set ('vit', '20170430', 'гантель', 'Пулл-овер стоячи', 1); */
/* call update_exercise_set_equipment_specific_set ('vit', '20170430', 'гантель', 'Пулл-овер стоячи', 2); */
call update_exercise_set_equipment ('vit', '20170430', 'гантель', 'Пулл-овер стоячи');

call calculate_tonnage ('vit', '20170430');

set @athlet_id = null;

commit;
