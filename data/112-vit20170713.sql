start transaction;

call set_athlet_id ('vit');

insert into `workout` (`workout_date`, `start_time`, `finish_time`, `athlet_id`)
  values
('20170713', '2017-07-13 21:00', '2017-07-13 21:54', (select @athlet_id));

call set_workout_id ('vit', '20170713');

/* split */
insert into `workout_type` (`wtype`) value ('split');

insert into `exercise` (`description`, `weight_kg`, `reps`, `rest_time_sec`, `set_number`, `workout_id`)
  values
('Жим лежачи', 25, 10, 150, 1, (select @workout_id)),
('Жим лежачи', 25, 10, 240, 2, (select @workout_id)),
('Жим лежачи', 27, 5, 180, 3, (select @workout_id)),
('Розведення рук лежачи', 13, 20, 120, 1, (select @workout_id)),
('Розведення рук лежачи', 13, 20, 120, 2, (select @workout_id)),
('Розведення рук лежачи', 13, 16, 180, 3, (select @workout_id)),
('Жим Свенда лежачи', 23, 16, 120, 1, (select @workout_id)),
('Жим Свенда лежачи', 23, 10, 120, 2, (select @workout_id)),
('Шраги', 27, 20, 90, 1, (select @workout_id)),
('Шраги', 27, 20, 0, 2, (select @workout_id));

set @workout_id = null;

/* без екіпірування */
insert into `style` (`id`) select e.id from exercise e
  join workout w on e.workout_id = w.id
  join athlet a on w.athlet_id = a.id
where a.nickname = 'vit'
  and w.workout_date = '20170713';

/* гантелі */
insert into `equipment` (`id`) select e.id from exercise e
  join workout w on e.workout_id = w.id
  join athlet a on w.athlet_id = a.id
where a.nickname = 'vit'
  and w.workout_date = '20170713';

call calculate_workout_duration ('vit', '20170713');

call update_exercise_set_equipment ('vit', '20170713', 'гантель', 'Жим Свенда лежачи');

call calculate_tonnage ('vit', '20170713');

set @athlet_id = null;

commit;
