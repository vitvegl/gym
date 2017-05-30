start transaction;

call set_athlet_id ('vit');

insert into `workout` (`workout_date`, `start_time`, `finish_time`, `athlet_id`)
  values
('20170525', '14:28', '16:00', (select @athlet_id));

call set_workout_id ('vit', '20170525');

/* split */
insert into `workout_type` (`wtype`) value ('split');

insert into `exercise` (`description`, `weight_kg`, `reps`, `rest_time_sec`, `workout_id`)
  values
('Жим лежачи', 50, 10, 60, (select @workout_id)),
('Жим лежачи', 50, 8, 60, (select @workout_id)),
('Жим лежачи', 50, 6, 60, (select @workout_id)),
('Присідання', 50, 5, 60, (select @workout_id)),
('Присідання', 50, 5, 60, (select @workout_id)),
('Присідання', 70, 1, 60, (select @workout_id)),
('Станова тяга', 50, 10, 60, (select @workout_id)),
('Станова тяга', 50, 10, 60, (select @workout_id)),
('Станова тяга', 70, 6, 90, (select @workout_id)),
('Станова тяга', 70, 6, 90, (select @workout_id)),
('Станова тяга', 90, 3, 90, (select @workout_id)),
('Станова тяга', 100, 3, 90, (select @workout_id)),
('Станова тяга', 100, 2, 90, (select @workout_id)),
('Шраги', 75, 10, 90, (select @workout_id)),
('Шраги', 75, 10, 90, (select @workout_id)),
('Жим лежачи', 60, 1, 60, (select @workout_id)),
('Жим лежачи', 65, 0, 60, (select @workout_id)),
('Жим лежачи', 65, 0, 0, (select @workout_id));

set @workout_id = null;

/* без екіпірування */
insert into `style` (`id`) select e.id from exercise e
  join workout w on e.workout_id = w.id
  join athlet a on w.athlet_id = a.id
where a.nickname = 'vit'
  and w.workout_date = '20170525';

/* штанга */
insert into `equipment` (`id`, `equipment`) select e.id, 'штанга' from exercise e
  join workout w on e.workout_id = w.id
  join athlet a on w.athlet_id = a.id
where a.nickname = 'vit'
  and w.workout_date = '20170525';

call update_exercise_set_equipment ('vit', '20170525', 'тренажер', 'Шраги');
call calculate_workout_duration ('vit', '20170525');
call calculate_tonnage ('vit', '20170525');

set @athlet_id = null;

commit;
