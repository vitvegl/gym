start transaction;

call set_athlet_id ('vit');

insert into `workout` (`workout_date`, `start_time`, `finish_time`, `athlet_id`)
  values
('20170727', '2017-07-27 21:57', '2017-07-27 22:54', (select @athlet_id));

call set_workout_id ('vit', '20170727');

/* split */
insert into `workout_type` (`wtype`) value ('split');

insert into `exercise` (`description`, `weight_kg`, `reps`, `rest_time_sec`, `set_number`, `workout_id`)
  values
('Жим лежачи', 21, 15, 180, 1, (select @workout_id)),
('Жим лежачи', 21, 14, 180, 2, (select @workout_id)),
('Жим лежачи', 21, 10, 180, 3, (select @workout_id)),
('Розведення рук лежачи', 13, 20, 180, 1, (select @workout_id)),
('Розведення рук лежачи', 13, 18, 180, 2, (select @workout_id)),
('Розведення рук лежачи', 13, 15, 180, 3, (select @workout_id)),
('Жим Свенда лежачи', 23, 14, 120, 1, (select @workout_id)),
('Жим Свенда лежачи', 23, 12, 120, 2, (select @workout_id)),
('Шраги', 27, 20, 120, 1, (select @workout_id)),
('Шраги', 27, 20, 120, 2, (select @workout_id)),
('Шраги', 27, 20, 0, 3, (select @workout_id));

set @workout_id = null;

/* без екіпірування */
insert into `style` (`id`) select e.id from exercise e
  join workout w on e.workout_id = w.id
  join athlet a on w.athlet_id = a.id
where a.nickname = 'vit'
  and w.workout_date = '20170727';

/* гантелі */
insert into `equipment` (`id`) select e.id from exercise e
  join workout w on e.workout_id = w.id
  join athlet a on w.athlet_id = a.id
where a.nickname = 'vit'
  and w.workout_date = '20170727';

call calculate_workout_duration ('vit', '20170727');

call update_exercise_set_equipment ('vit', '20170727', 'гантель', 'Жим Свенда лежачи');

call calculate_tonnage ('vit', '20170727');

set @athlet_id = null;

commit;
