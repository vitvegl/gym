start transaction;

call set_athlet_id ('vit');

insert into `workout` (`workout_date`, `start_time`, `finish_time`, `athlet_id`)
  values
('20170816', '2017-08-16 15:32', '2017-08-16 15:50', (select @athlet_id));

call set_workout_id ('vit', '20170816');

/* split */
insert into `workout_type` (`wtype`) value ('split');

insert into `exercise` (`description`, `weight_kg`, `reps`, `rest_time_sec`, `set_number`, `workout_id`)
  values
('Віджимання від підлоги', 0, 30, 120, 1, (select @workout_id)),
('Віджимання від підлоги', 0, 20, 120, 2, (select @workout_id)),
('Присідання', 0, 50, 120, 1, (select @workout_id)),
('Шраги', 27, 20, 90, 1, (select @workout_id)),
('Шраги', 27, 20, 90, 2, (select @workout_id)),
('Шраги', 27, 20, 120, 3, (select @workout_id)),
('Тяга 1 рукою у нахилі', 33, 10, 120, 1, (select @workout_id)),
('Тяга 1 рукою у нахилі', 33, 10, 0, 2, (select @workout_id));

set @workout_id = null;

/* без екіпірування */
insert into `style` (`id`) select e.id from exercise e
  join workout w on e.workout_id = w.id
  join athlet a on w.athlet_id = a.id
where a.nickname = 'vit'
  and w.workout_date = '20170816';

/* гантелі */
insert into `equipment` (`id`) select e.id from exercise e
  join workout w on e.workout_id = w.id
  join athlet a on w.athlet_id = a.id
where a.nickname = 'vit'
  and w.workout_date = '20170816';

call update_exercise_if_no_weight ('vit', '20170816');

call calculate_workout_duration ('vit', '20170816');

call calculate_tonnage ('vit', '20170816');

set @athlet_id = null;

commit;
