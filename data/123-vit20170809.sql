start transaction;

call set_athlet_id ('vit');

insert into `workout` (`workout_date`, `start_time`, `finish_time`, `athlet_id`)
  values
('20170809', '2017-08-09 19:44', '2017-08-09 20:14', (select @athlet_id));

call set_workout_id ('vit', '20170809');

/* split */
insert into `workout_type` (`wtype`) value ('split');

insert into `exercise` (`description`, `weight_kg`, `reps`, `rest_time_sec`, `set_number`, `workout_id`)
  values
('Жим стоячи', 15, 12, 90, 1, (select @workout_id)),
('Жим стоячи', 15, 12, 90, 2, (select @workout_id)),
('Жим стоячи', 15, 8, 120, 3, (select @workout_id)),
('Тяга 1 рукою у нахилі', 33, 8, 120, 1, (select @workout_id)),
('Тяга 1 рукою у нахилі', 33, 8, 120, 2, (select @workout_id)),
('Тяга 1 рукою у нахилі', 33, 8, 180, 3, (select @workout_id)),
('Шраги', 33, 12, 90, 1, (select @workout_id)),
('Шраги', 33, 12, 90, 2, (select @workout_id)),
('Шраги', 33, 12, 0, 3, (select @workout_id));

set @workout_id = null;

/* без екіпірування */
insert into `style` (`id`) select e.id from exercise e
  join workout w on e.workout_id = w.id
  join athlet a on w.athlet_id = a.id
where a.nickname = 'vit'
  and w.workout_date = '20170809';

/* гантелі */
insert into `equipment` (`id`) select e.id from exercise e
  join workout w on e.workout_id = w.id
  join athlet a on w.athlet_id = a.id
where a.nickname = 'vit'
  and w.workout_date = '20170809';

call calculate_workout_duration ('vit', '20170809');

call calculate_tonnage ('vit', '20170809');

set @athlet_id = null;

commit;
