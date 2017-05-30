start transaction;

call set_athlet_id ('vit');

insert into `workout` (`workout_date`, `start_time`, `finish_time`, `athlet_id`)
  values
('20170527', '22:08', '22:19', (select @athlet_id));

call set_workout_id ('vit', '20170527');

/* split */
insert into `workout_type` (`wtype`) value ('split');

insert into `exercise` (`description`, `weight_kg`, `reps`, `rest_time_sec`, `workout_id`)
  values
('Присідання', 21, 16, 120, (select @workout_id)),
('Присідання', 21, 16, 120, (select @workout_id)),
('Присідання', 21, 16, 120, (select @workout_id));

set @workout_id = null;

/* без екіпірування */
insert into `style` (`id`) select e.id from exercise e
  join workout w on e.workout_id = w.id
  join athlet a on w.athlet_id = a.id
where a.nickname = 'vit'
  and w.workout_date = '20170527';

/* гантелі */
insert into `equipment` (`id`) select e.id from exercise e
  join workout w on e.workout_id = w.id
  join athlet a on w.athlet_id = a.id
where a.nickname = 'vit'
  and w.workout_date = '20170527';

call calculate_workout_duration ('vit', '20170527');
call calculate_tonnage ('vit', '20170527');

set @athlet_id = null;

commit;
