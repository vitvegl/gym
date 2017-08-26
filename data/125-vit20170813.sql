start transaction;

call set_athlet_id ('vit');

insert into `workout` (`workout_date`, `start_time`, `finish_time`, `athlet_id`)
  values
('20170813', '2017-08-13 22:05', '2017-08-13 22:43', (select @athlet_id));

call set_workout_id ('vit', '20170813');

/* split */
insert into `workout_type` (`wtype`) value ('split');

insert into `exercise` (`description`, `weight_kg`, `reps`, `rest_time_sec`, `set_number`, `workout_id`)
  values
('Розведення рук лежачи', 15, 20, 180, 1, (select @workout_id)),
('Розведення рук лежачи', 15, 20, 180, 2, (select @workout_id)),
('Станова тяга', 33, 10, 120, 1, (select @workout_id)),
('Станова тяга', 33, 7, 120, 2, (select @workout_id)),
('Тяга 1 рукою у нахилі', 40, 6, 120, 1, (select @workout_id)),
('Тяга 1 рукою у нахилі', 40, 6, 120, 2, (select @workout_id)),
('Шраги', 33, 12, 120, 1, (select @workout_id)),
('Шраги', 33, 12, 120, 2, (select @workout_id)),
('Шраги', 33, 12, 0, 3, (select @workout_id));

set @workout_id = null;

/* без екіпірування */
insert into `style` (`id`) select e.id from exercise e
  join workout w on e.workout_id = w.id
  join athlet a on w.athlet_id = a.id
where a.nickname = 'vit'
  and w.workout_date = '20170813';

/* гантелі */
insert into `equipment` (`id`) select e.id from exercise e
  join workout w on e.workout_id = w.id
  join athlet a on w.athlet_id = a.id
where a.nickname = 'vit'
  and w.workout_date = '20170813';

call calculate_workout_duration ('vit', '20170813');

call calculate_tonnage ('vit', '20170813');

set @athlet_id = null;

commit;
