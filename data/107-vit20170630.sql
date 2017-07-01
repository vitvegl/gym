start transaction;

call set_athlet_id ('vit');

insert into `workout` (`workout_date`, `start_time`, `finish_time`, `athlet_id`)
  values
('20170630', '2017-06-30 16:10', '2017-06-30 17:13', (select @athlet_id));

call set_workout_id ('vit', '20170630');

/* split */
insert into `workout_type` (`wtype`) value ('split');

insert into `exercise` (`description`, `weight_kg`, `reps`, `rest_time_sec`, `set_number`, `workout_id`)
  values
('Жим стоячи', 19, 6, 120, 1, (select @workout_id)),
('Жим стоячи', 17, 8, 180, 2, (select @workout_id)),
('Жим стоячи', 17, 8, 180, 3, (select @workout_id)),
('Станова тяга', 33, 16, 180, 1, (select @workout_id)),
('Станова тяга', 33, 12, 180, 2, (select @workout_id)),
('Тяга 1 рукою у нахилі', 27, 14, 180, 1, (select @workout_id)),
('Тяга 1 рукою у нахилі', 27, 14, 180, 2, (select @workout_id)),
('Згинання рук стоячи', 13, 8, 180, 1, (select @workout_id)),
('Згинання рук стоячи', 13, 8, 180, 2, (select @workout_id)),
('Згинання рук стоячи', 13, 7, 0, 3, (select @workout_id));

set @workout_id = null;

/* без екіпірування */
insert into `style` (`id`) select e.id from exercise e
  join workout w on e.workout_id = w.id
  join athlet a on w.athlet_id = a.id
where a.nickname = 'vit'
  and w.workout_date = '20170630';

/* гантелі */
insert into `equipment` (`id`) select e.id from exercise e
  join workout w on e.workout_id = w.id
  join athlet a on w.athlet_id = a.id
where a.nickname = 'vit'
  and w.workout_date = '20170630';

call calculate_workout_duration ('vit', '20170630');
call calculate_tonnage ('vit', '20170630');

set @athlet_id = null;

commit;
