start transaction;

call set_athlet_id ('vit');

insert into `workout` (`workout_date`, `start_time`, `finish_time`, `athlet_id`)
  values
('20170729', '2017-07-29 20:50', '2017-07-29 21:43', (select @athlet_id));

call set_workout_id ('vit', '20170729');

/* split */
insert into `workout_type` (`wtype`) value ('split');

insert into `exercise` (`description`, `weight_kg`, `reps`, `rest_time_sec`, `set_number`, `workout_id`)
  values
('Станова тяга', 33, 16, 180, 1, (select @workout_id)),
('Станова тяга', 33, 10, 180, 2, (select @workout_id)),
('Тяга 1 рукою у нахилі', 27, 14, 180, 1, (select @workout_id)),
('Тяга 1 рукою у нахилі', 27, 14, 180, 2, (select @workout_id)),
('Тяга 1 рукою у нахилі', 27, 14, 0, 3, (select @workout_id));

set @workout_id = null;

/* без екіпірування */
insert into `style` (`id`) select e.id from exercise e
  join workout w on e.workout_id = w.id
  join athlet a on w.athlet_id = a.id
where a.nickname = 'vit'
  and w.workout_date = '20170729';

/* гантелі */
insert into `equipment` (`id`) select e.id from exercise e
  join workout w on e.workout_id = w.id
  join athlet a on w.athlet_id = a.id
where a.nickname = 'vit'
  and w.workout_date = '20170729';

call calculate_workout_duration ('vit', '20170729');

call calculate_tonnage ('vit', '20170729');

set @athlet_id = null;

commit;
