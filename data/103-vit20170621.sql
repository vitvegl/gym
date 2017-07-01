start transaction;

call set_athlet_id ('vit');

insert into `workout` (`workout_date`, `start_time`, `finish_time`, `athlet_id`)
  values
('20170621', '2017-06-21 15:10', '2017-06-21 16:10', (select @athlet_id));

call set_workout_id ('vit', '20170621');

/* split */
insert into `workout_type` (`wtype`) value ('split');

insert into `exercise` (`description`, `weight_kg`, `reps`, `rest_time_sec`, `set_number`, `workout_id`)
  values
('Жим стоячи', 19, 6, 180, 1, (select @workout_id)),
('Жим стоячи', 19, 6, 180, 2, (select @workout_id)),
('Жим стоячи', 19, 6, 180, 3, (select @workout_id)),
('Станова тяга', 33, 16, 180, 1, (select @workout_id)),
('Станова тяга', 33, 16, 180, 2, (select @workout_id)),
('Тяга 1 рукою у нахилі', 27, 10, 180, 1, (select @workout_id)),
('Тяга 1 рукою у нахилі', 27, 10, 120, 2, (select @workout_id)),
('Тяга 1 рукою у нахилі', 27, 10, 180, 3, (select @workout_id)),
('Згинання рук стоячи', 12.2, 11, 180, 1, (select @workout_id)),
('Згинання рук стоячи', 12.2, 11, 180, 2, (select @workout_id)),
('Згинання рук стоячи', 12.2, 9, 0, 3, (select @workout_id));

set @workout_id = null;

/* без екіпірування */
insert into `style` (`id`) select e.id from exercise e
  join workout w on e.workout_id = w.id
  join athlet a on w.athlet_id = a.id
where a.nickname = 'vit'
  and w.workout_date = '20170621';

/* гантелі */
insert into `equipment` (`id`) select e.id from exercise e
  join workout w on e.workout_id = w.id
  join athlet a on w.athlet_id = a.id
where a.nickname = 'vit'
  and w.workout_date = '20170621';

call calculate_workout_duration ('vit', '20170621');
call calculate_tonnage ('vit', '20170621');

set @athlet_id = null;

commit;
