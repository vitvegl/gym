start transaction;

call set_athlet_id ('vit');

insert into `workout` (`workout_date`, `workout_duration`, `athlet_id`)
  values
('20170423', null, (select @athlet_id));

call set_workout_id ('vit', '20170423');

/* split */
insert into `workout_type` (`wtype`) value ('split');

insert into `exercise` (`description`, `weight_kg`, `reps`, `rest_time_sec`, `set_number`, `workout_id`)
  values
('Жим лежачи', 35, 10, 60, 1, (select @workout_id)),
('Жим лежачи', 35, 10, 60, 2, (select @workout_id)),
('Жим лежачи', 40, 8, 90, 3, (select @workout_id)),
('Жим лежачи', 50, 8, 120, 4, (select @workout_id)),
('Жим лежачи', 50, 8, 120, 5, (select @workout_id)),
('Жим лежачи', 56, 1, 120, 6, (select @workout_id)),
('Жим лежачи', 56, 1, 120, 7, (select @workout_id)),
('Жим лежачи', 60, 0, 120, 8, (select @workout_id)),
('Станова тяга', 50, 10, 90, 1, (select @workout_id)),
('Станова тяга', 75, 6, 120, 2, (select @workout_id)),
('Станова тяга', 85, 3, 120, 3, (select @workout_id)),
('Станова тяга', 101, 1, 120, 4, (select @workout_id)),
('Шраги', 32, 10, 0, 1, (select @workout_id));

set @workout_id = null;

/* без екіпірування */
insert into `style` (`id`) select e.id from exercise e
  join workout w on e.workout_id = w.id
  join athlet a on w.athlet_id = a.id
where a.nickname = 'vit'
  and w.workout_date = '20170423';

/* штанга */
insert into `equipment` (`id`, `equipment`) select e.id, 'штанга' from exercise e
  join workout w on e.workout_id = w.id
  join athlet a on w.athlet_id = a.id
where a.nickname = 'vit'
  and w.workout_date = '20170423';

/* Шраги з гирями */
call update_exercise_set_equipment_specific_set ('vit', '20170423', 'гирі', 'Шраги', 1);

commit;
