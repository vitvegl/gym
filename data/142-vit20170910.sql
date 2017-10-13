start transaction;

call set_athlet_id ('vit');

insert into `workout` (`workout_date`, `start_time`, `finish_time`, `athlet_id`)
  values
('20170910', '2017-09-10 18:08', '2017-09-10 18:28', (select @athlet_id));

call set_workout_id ('vit', '20170910');

/* split */
insert into `workout_type` (`wtype`) value ('split');

insert into `exercise` (`description`, `weight_kg`, `reps`, `rest_time_sec`, `set_number`, `workout_id`)
  values
('Прес', 0, 25, 120, 1, (select @workout_id)),
('Прес', 0, 25, 120, 2, (select @workout_id)),
('Прес', 0, 25, 180, 3, (select @workout_id)),
('Віджимання від підлоги', 0, 34, 180, 1, (select @workout_id)),
('Віджимання від підлоги', 0, 24, 120, 2, (select @workout_id)),
('Присідання', 0, 50, 0, 1, (select @workout_id));

set @workout_id = null;

/* без екіпірування */
insert into `style` (`id`) select e.id from exercise e
  join workout w on e.workout_id = w.id
  join athlet a on w.athlet_id = a.id
where a.nickname = 'vit'
  and w.workout_date = '20170910';

/* гантелі */
insert into `equipment` (`id`) select e.id from exercise e
  join workout w on e.workout_id = w.id
  join athlet a on w.athlet_id = a.id
where a.nickname = 'vit'
  and w.workout_date = '20170910';

call update_exercise_if_no_weight ('vit', '20170910');

call calculate_workout_duration ('vit', '20170910');

/* call calculate_tonnage ('vit', '20170910'); */
call set_zero_tonnage ('vit', '20170910');

set @athlet_id = null;

commit;
