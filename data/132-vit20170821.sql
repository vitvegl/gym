start transaction;

call set_athlet_id ('vit');

insert into `workout` (`workout_date`, `start_time`, `finish_time`, `athlet_id`)
  values
('20170821', '2017-08-21 19:23', '2017-08-21 19:59', (select @athlet_id));

call set_workout_id ('vit', '20170821');

/* fullbody */
insert into `workout_type` (`wtype`) value ('fullbody');

insert into `exercise` (`description`, `weight_kg`, `reps`, `rest_time_sec`, `set_number`, `workout_id`)
  values
('Жим лежачи', 25, 10, 180, 1, (select @workout_id)),
('Жим лежачи', 25, 8, 120, 2, (select @workout_id)),
('Присідання', 33, 10, 180, 1, (select @workout_id)),
('Присідання', 33, 10, 180, 2, (select @workout_id)),
('Станова тяга', 33, 10, 120, 1, (select @workout_id)),
('Станова тяга', 33, 10, 0, 2, (select @workout_id));

set @workout_id = null;

/* без екіпірування */
insert into `style` (`id`) select e.id from exercise e
  join workout w on e.workout_id = w.id
  join athlet a on w.athlet_id = a.id
where a.nickname = 'vit'
  and w.workout_date = '20170821';

/* гантелі */
insert into `equipment` (`id`) select e.id from exercise e
  join workout w on e.workout_id = w.id
  join athlet a on w.athlet_id = a.id
where a.nickname = 'vit'
  and w.workout_date = '20170821';

call calculate_workout_duration ('vit', '20170821');

call calculate_tonnage ('vit', '20170821');

set @athlet_id = null;

commit;
