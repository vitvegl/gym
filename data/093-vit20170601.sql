start transaction;

call set_athlet_id ('vit');

insert into `workout` (`workout_date`, `start_time`, `finish_time`, `athlet_id`)
  values
('20170601', '2017-06-01 23:31', '2017-06-01 23:40', (select @athlet_id));

call set_workout_id ('vit', '20170601');

/* split */
insert into `workout_type` (`wtype`) value ('split');

insert into `exercise` (`description`, `weight_kg`, `reps`, `rest_time_sec`, `set_number`, `workout_id`)
  values
('Присідання', 21, 16, 120, 1, (select @workout_id)),
('Присідання', 21, 16, 120, 2, (select @workout_id)),
('Присідання', 21, 16, 0, 3, (select @workout_id));

set @workout_id = null;

/* без екіпірування */
insert into `style` (`id`) select e.id from exercise e
  join workout w on e.workout_id = w.id
  join athlet a on w.athlet_id = a.id
where a.nickname = 'vit'
  and w.workout_date = '20170601';

/* гантелі */
insert into `equipment` (`id`) select e.id from exercise e
  join workout w on e.workout_id = w.id
  join athlet a on w.athlet_id = a.id
where a.nickname = 'vit'
  and w.workout_date = '20170601';

call calculate_workout_duration ('vit', '20170601');
call calculate_tonnage ('vit', '20170601');

set @athlet_id = null;

commit;
