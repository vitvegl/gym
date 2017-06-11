start transaction;

call set_athlet_id ('vit');

insert into `workout` (`workout_date`, `workout_duration`, `athlet_id`)
  values
('2016-12-10', '1:01', (select @athlet_id));

call set_workout_id ('vit', '2016-12-10');

/* split */
insert into `workout_type` (`wtype`) values ('split');

insert into `exercise` (`description`, `weight_kg`, `reps`, `rest_time_sec`, `set_number`, `workout_id`)
  values
('Присідання', 30, 8, 120, 1, (select @workout_id)),
('Присідання', 30, 8, 120, 2, (select @workout_id)),
('Присідання', 30, 8, 120, 3, (select @workout_id)),
('Концентрований підйом на біцепс', 9, 9, 120, 1, (select @workout_id)),
('Концентрований підйом на біцепс', 9, 9, 120, 2, (select @workout_id)),
('Концентрований підйом на біцепс', 9, 8, 120, 3, (select @workout_id)),
('Концентрований підйом на біцепс', 9, 8, 120, 4, (select @workout_id)),
('Присідання', 0, 25, 120, 1, (select @workout_id)),
('Присідання', 0, 25, 120, 2, (select @workout_id)),
('Присідання', 0, 25, 120, 3, (select @workout_id)),
('Хаммер', 9, 9, 120, 1, (select @workout_id)),
('Хаммер', 9, 9, 120, 2, (select @workout_id)),
('Хаммер', 9, 9, 120, 3, (select @workout_id)),
('Хаммер', 9, 8, 120, 4, (select @workout_id)),
('Згинання рук стоячи', 8.5, 8, 120, 1, (select @workout_id)),
('Згинання рук стоячи', 8.5, 7, 120, 2, (select @workout_id)),
('Згинання рук стоячи', 8.5, 7, 120, 3, (select @workout_id)),
('Згинання рук стоячи', 8.5, 7, 0, 4, (select @workout_id));

set @workout_id = null;

/* без екіпірування */
insert into `style` (`id`) select e.id from exercise e
  join workout w on e.workout_id = w.id
  join athlet a on w.athlet_id = a.id
where a.nickname = 'vit' and w.workout_date = '2016-12-10';

/* гантелі */
insert into `equipment` (`id`) select e.id from exercise e
  join workout w on e.workout_id = w.id
  join athlet a on w.athlet_id = a.id
where a.nickname = 'vit' and w.workout_date = '2016-12-10';

/* вправи з вагою тіла */
call update_exercise_if_no_weight ('vit', '2016-12-10');

call calculate_tonnage ('vit', '2016-12-10');

set @athlet_id = null;

commit;
