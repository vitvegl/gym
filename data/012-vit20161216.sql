start transaction;

call set_athlet_id ('vit');

insert into `workout` (`workout_date`, `workout_duration`, `athlet_id`)
  values
('2016-12-16', '0:57', (select @athlet_id));

call set_workout_id ('vit', '2016-12-16');

/* split */
insert into `workout_type` (`wtype`) values ('split');

insert into `exercise` (`description`, `weight_kg`, `reps`, `rest_time_sec`, `set_number`, `workout_id`)
  values
('Присідання', 30, 8, 120, 1, (select @workout_id)),
('Присідання', 30, 10, 120, 2, (select @workout_id)),
('Присідання', 30, 10, 120, 3, (select @workout_id)),
('Присідання', 30, 8, 120, 4, (select @workout_id)),
('Концентрований підйом на біцепс', 9, 10, 120, 1, (select @workout_id)),
('Концентрований підйом на біцепс', 9, 8, 120, 2, (select @workout_id)),
('Концентрований підйом на біцепс', 9, 7, 120, 3, (select @workout_id)),
('Присідання', 0, 15, 120, 1, (select @workout_id)),
('Присідання', 0, 15, 120, 2, (select @workout_id)),
('Присідання', 0, 15, 120, 3, (select @workout_id)),
('Хаммер', 9, 10, 120, 1, (select @workout_id)),
('Хаммер', 9, 10, 120, 2, (select @workout_id)),
('Хаммер', 9, 10, 120, 3, (select @workout_id)),
('Хаммер', 9, 8, 120, 4, (select @workout_id)),
('Згинання рук стоячи', 9, 5, 90, 1, (select @workout_id)),
('Згинання рук стоячи', 9, 5, 90, 2, (select @workout_id)),
('Згинання рук стоячи', 9, 5, 0, 3, (select @workout_id));

set @workout_id = null;

/* без екіпірування */
insert into `style` (`id`) select e.id from exercise e
  join workout w on e.workout_id = w.id
  join athlet a on w.athlet_id = a.id
where a.nickname = 'vit' and w.workout_date = '2016-12-16';

/* гантелі */
insert into `equipment` (`id`) select e.id from exercise e
  join workout w on e.workout_id = w.id
  join athlet a on w.athlet_id = a.id
where a.nickname = 'vit' and w.workout_date = '2016-12-16';

/* вправи з вагою тіла */
call update_exercise_if_no_weight ('vit', '2016-12-16');

call calculate_tonnage ('vit', '2016-12-16');

set @athlet_id = null;

commit;
