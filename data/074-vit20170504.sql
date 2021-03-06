start transaction;

call set_athlet_id ('vit');

insert into `workout` (`workout_date`, `workout_duration`, `athlet_id`)
  values
('20170504', '0:11', (select @athlet_id));

call set_workout_id ('vit', '20170504');

/* split */
insert into `workout_type` (`wtype`) value ('split');

insert into `exercise` (`description`, `weight_kg`, `reps`, `rest_time_sec`, `workout_id`)
  values
('Прес', 0, 25, 120, (select @workout_id)),
('Прес', 0, 25, 120, (select @workout_id)),
('Прес', 0, 25, 120, (select @workout_id)),
('Шраги', 33, 16, 120, (select @workout_id)),
('Шраги', 33, 16, 120, (select @workout_id));

set @workout_id = null;

/* без екіпірування */
insert into `style` (`id`) select e.id from exercise e
  join workout w on e.workout_id = w.id
  join athlet a on w.athlet_id = a.id
where a.nickname = 'vit'
  and w.workout_date = '20170504';

/* гантелі */
insert into `equipment` (`id`) select e.id from exercise e
  join workout w on e.workout_id = w.id
  join athlet a on w.athlet_id = a.id
where a.nickname = 'vit'
  and w.workout_date = '20170504';

call update_exercise_if_no_weight ('vit', '20170504');

commit;
