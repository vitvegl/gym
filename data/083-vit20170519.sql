start transaction;

call set_athlet_id ('vit');

insert into `workout` (`workout_date`, `start_time`, `finish_time`, `athlet_id`)
  values
('20170519', '22:36', '23:25', (select @athlet_id));

call set_workout_id ('vit', '20170519');

/* split */
insert into `workout_type` (`wtype`) value ('split');

insert into `exercise` (`description`, `weight_kg`, `reps`, `rest_time_sec`, `workout_id`)
  values
('Концентрований підйом на біцепс сидячи', 9, 15, 120, (select @workout_id)),
('Концентрований підйом на біцепс сидячи', 9, 12, 120, (select @workout_id)),
('Концентрований підйом на біцепс сидячи', 9, 12, 120, (select @workout_id)),
('Згинання рук стоячи', 9, 11, 120, (select @workout_id)),
('Згинання рук стоячи', 9, 11, 120, (select @workout_id)),
('Згинання рук стоячи', 9, 11, 120, (select @workout_id)),
('Згинання рук стоячи', 9, 10, 120, (select @workout_id)),
('Хаммер', 11, 7, 120, (select @workout_id)),
('Хаммер', 11, 6, 120, (select @workout_id)),
('Шраги', 27, 20, 120, (select @workout_id)),
('Шраги', 27, 20, 120, (select @workout_id)),
('Шраги', 27, 20, 120, (select @workout_id)),
('Шраги', 27, 20, 120, (select @workout_id)),
('Шраги', 27, 20, 120, (select @workout_id));

set @workout_id = null;

/* без екіпірування */
insert into `style` (`id`) select e.id from exercise e
  join workout w on e.workout_id = w.id
  join athlet a on w.athlet_id = a.id
where a.nickname = 'vit'
  and w.workout_date = '20170519';

/* гантелі */
insert into `equipment` (`id`) select e.id from exercise e
  join workout w on e.workout_id = w.id
  join athlet a on w.athlet_id = a.id
where a.nickname = 'vit'
  and w.workout_date = '20170519';

call calculate_workout_duration ('vit', '20170519');
call calculate_tonnage ('vit', '20170519');

commit;
