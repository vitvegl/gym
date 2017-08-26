start transaction;

call set_athlet_id ('vit');

insert into `workout` (`workout_date`, `start_time`, `finish_time`, `athlet_id`)
  values
('20170819', '2017-08-19 14:03', '2017-08-19 14:31', (select @athlet_id));

call set_workout_id ('vit', '20170819');

/* split */
insert into `workout_type` (`wtype`) value ('split');

insert into `exercise` (`description`, `weight_kg`, `reps`, `rest_time_sec`, `set_number`, `workout_id`)
  values
('Розведення рук лежачи', 15, 16, 90, 1, (select @workout_id)),
('Розведення рук лежачи', 15, 16, 120, 2, (select @workout_id)),
('Віджимання від підлоги', 0, 27, 120, 1, (select @workout_id)),
('Віджимання від підлоги', 0, 22, 60, 2, (select @workout_id)),
('Присідання', 0, 50, 180, 1, (select @workout_id)),
('Присідання', 0, 30, 120, 2, (select @workout_id)),
('Махи вперед', 9, 10, 120, 1, (select @workout_id)),
('Махи вперед', 9, 10, 120, 2, (select @workout_id)),
('Махи вперед', 9, 10, 0, 3, (select @workout_id));

set @workout_id = null;

/* без екіпірування */
insert into `style` (`id`) select e.id from exercise e
  join workout w on e.workout_id = w.id
  join athlet a on w.athlet_id = a.id
where a.nickname = 'vit'
  and w.workout_date = '20170819';

/* гантелі */
insert into `equipment` (`id`) select e.id from exercise e
  join workout w on e.workout_id = w.id
  join athlet a on w.athlet_id = a.id
where a.nickname = 'vit'
  and w.workout_date = '20170819';

call update_exercise_if_no_weight ('vit', '20170819');

call calculate_workout_duration ('vit', '20170819');

call calculate_tonnage ('vit', '20170819');

set @athlet_id = null;

commit;
