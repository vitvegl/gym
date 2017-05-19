

call set_athlet_id ('vit');

insert into `workout` (`workout_date`, `start_time`, `finish_time`, `athlet_id`)
  values
('20170510', '05:50', '06:27', (select @athlet_id));

call calculate_workout_duration ('vit', '20170510');

call set_workout_id ('vit', '20170510');

/* split */
insert into `workout_type` (`wtype`) value ('split');

insert into `exercise` (`description`, `weight_kg`, `reps`, `rest_time_sec`, `workout_id`)
  values
('Присідання', 23, 10, 120, (select @workout_id)),
('Присідання', 23, 10, 120, (select @workout_id)),
('Присідання', 23, 10, 180, (select @workout_id)),
('Концентрований підйом на біцепс сидячи', 9, 15, 120, (select @workout_id)),
('Концентрований підйом на біцепс сидячи', 9, 11, 120, (select @workout_id)),
('Хаммер', 11, 8, 90, (select @workout_id)),
('Хаммер', 11, 8, 90, (select @workout_id)),
('Хаммер', 11, 6, 90, (select @workout_id)),
('Згинання рук стоячи', 11, 5, 90, (select @workout_id)),
('Згинання рук стоячи', 11, 4, 90, (select @workout_id));

set @workout_id = null;

/* без екіпірування */
insert into `style` (`id`) select e.id from exercise e
  join workout w on e.workout_id = w.id
  join athlet a on w.athlet_id = a.id
where a.nickname = 'vit'
  and w.workout_date = '20170510';

/* гантелі */
insert into `equipment` (`id`) select e.id from exercise e
  join workout w on e.workout_id = w.id
  join athlet a on w.athlet_id = a.id
where a.nickname = 'vit'
  and w.workout_date = '20170510';


