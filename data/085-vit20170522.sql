start transaction;

call set_athlet_id ('vit');

insert into `workout` (`workout_date`, `start_time`, `finish_time`, `athlet_id`)
  values
('20170522', '2017-05-22 23:03', '2017-05-22 23:30', (select @athlet_id));

call set_workout_id ('vit', '20170522');

/* split */
insert into `workout_type` (`wtype`) value ('split');

insert into `exercise` (`description`, `weight_kg`, `reps`, `rest_time_sec`, `workout_id`)
  values
('Станова тяга', 33, 12, 120, (select @workout_id)),
('Станова тяга', 33, 12, 120, (select @workout_id)),
('Станова тяга', 33, 12, 120, (select @workout_id)),
('Тяга 1 рукою у нахилі', 33, 8, 120, (select @workout_id)),
('Тяга 1 рукою у нахилі', 33, 8, 120, (select @workout_id));

set @workout_id = null;

/* без екіпірування */
insert into `style` (`id`) select e.id from exercise e
  join workout w on e.workout_id = w.id
  join athlet a on w.athlet_id = a.id
where a.nickname = 'vit'
  and w.workout_date = '20170522';

/* гантелі */
insert into `equipment` (`id`) select e.id from exercise e
  join workout w on e.workout_id = w.id
  join athlet a on w.athlet_id = a.id
where a.nickname = 'vit'
  and w.workout_date = '20170522';

call calculate_workout_duration ('vit', '20170522');
call calculate_tonnage ('vit', '20170522');

commit;
