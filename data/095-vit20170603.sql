start transaction;

call set_athlet_id ('vit');

insert into `workout` (`workout_date`, `start_time`, `finish_time`, `athlet_id`)
  values
('20170603', '2017-06-03 18:38', '2017-06-03 19:18', (select @athlet_id));

call set_workout_id ('vit', '20170603');

/* split */
insert into `workout_type` (`wtype`) value ('split');

insert into `exercise` (`description`, `weight_kg`, `reps`, `rest_time_sec`, `set_number`, `workout_id`)
  values
('Згинання рук стоячи', 10.2, 16, 120, 1, (select @workout_id)),
('Згинання рук стоячи', 10.2, 13, 120, 2, (select @workout_id)),
('Згинання рук стоячи', 10.2, 12, 120, 3, (select @workout_id)),
('Хаммер', 11, 9, 120, 1, (select @workout_id)),
('Хаммер', 11, 9, 120, 2, (select @workout_id)),
('Хаммер', 11, 10, 120, 3, (select @workout_id)),
('Хаммер', 11, 8, 120, 4, (select @workout_id)),
('Концентрований підйом на біцепс сидячи', 10.2, 8, 120, 1, (select @workout_id)),
('Концентрований підйом на біцепс сидячи', 10.2, 7, 120, 2, (select @workout_id)),
('Концентрований підйом на біцепс сидячи', 10.2, 6, 120, 3, (select @workout_id)),
('Шраги', 27, 20, 90, 1, (select @workout_id)),
('Шраги', 27, 20, 90, 2, (select @workout_id)),
('Шраги', 27, 25, 0, 3, (select @workout_id));

set @workout_id = null;

/* без екіпірування */
insert into `style` (`id`) select e.id from exercise e
  join workout w on e.workout_id = w.id
  join athlet a on w.athlet_id = a.id
where a.nickname = 'vit'
  and w.workout_date = '20170603';

/* гантелі */
insert into `equipment` (`id`) select e.id from exercise e
  join workout w on e.workout_id = w.id
  join athlet a on w.athlet_id = a.id
where a.nickname = 'vit'
  and w.workout_date = '20170603';

call calculate_workout_duration ('vit', '20170603');
call calculate_tonnage ('vit', '20170603');

set @athlet_id = null;

commit;
