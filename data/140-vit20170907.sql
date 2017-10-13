start transaction;

call set_athlet_id ('vit');

insert into `workout` (`workout_date`, `start_time`, `finish_time`, `athlet_id`)
  values
('20170907', '2017-09-07 22:11', '2017-09-07 23:14', (select @athlet_id));

call set_workout_id ('vit', '20170907');

/* split */
insert into `workout_type` (`wtype`) value ('split');

insert into `exercise` (`description`, `weight_kg`, `reps`, `rest_time_sec`, `set_number`, `workout_id`)
  values
('Станова тяга', 33, 10, 120, 1, (select @workout_id)),
('Станова тяга', 33, 10, 120, 2, (select @workout_id)),
('Станова тяга', 33, 10, 180, 3, (select @workout_id)),
('Згинання рук стоячи', 13, 10, 180, 1, (select @workout_id)),
('Згинання рук стоячи', 13, 10, 180, 2, (select @workout_id)),
('Згинання рук стоячи', 13, 8, 180, 3, (select @workout_id)),
('Підйом на носки', 33, 13, 90, 1, (select @workout_id)),
('Підйом на носки', 33, 13, 90, 2, (select @workout_id)),
('Підйом на носки', 33, 13, 120, 3, (select @workout_id)),
('Концентрований підйом на біцепс сидячи', 9, 16, 120, 1, (select @workout_id)),
('Концентрований підйом на біцепс сидячи', 9, 13, 180, 2, (select @workout_id)),
('Концентрований підйом на біцепс сидячи', 9, 12, 120, 3, (select @workout_id)),
('Присідання фронтальні', 50, 10, 120, 1, (select @workout_id)),
('Присідання фронтальні', 50, 10, 120, 2, (select @workout_id)),
('Присідання фронтальні', 50, 10, 120, 3, (select @workout_id)),
('Шраги', 30, 20, 90, 1, (select @workout_id)),
('Шраги', 30, 20, 0, 2, (select @workout_id));

set @workout_id = null;

/* без екіпірування */
insert into `style` (`id`) select e.id from exercise e
  join workout w on e.workout_id = w.id
  join athlet a on w.athlet_id = a.id
where a.nickname = 'vit'
  and w.workout_date = '20170907';

/* гантелі */
insert into `equipment` (`id`) select e.id from exercise e
  join workout w on e.workout_id = w.id
  join athlet a on w.athlet_id = a.id
where a.nickname = 'vit'
  and w.workout_date = '20170907';

call calculate_workout_duration ('vit', '20170907');

call update_exercise_set_equipment ('vit', '20170907', 'снаряд', 'Присідання фронтальні');

call calculate_tonnage ('vit', '20170907');

set @athlet_id = null;

commit;
