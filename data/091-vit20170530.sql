start transaction;

call set_athlet_id ('vit');

insert into `workout` (`workout_date`, `start_time`, `finish_time`, `athlet_id`)
  values
('20170530', '2017-05-30 23:42', '2017-05-31 00:21', (select @athlet_id));

call set_workout_id ('vit', '20170530');

/* split */
insert into `workout_type` (`wtype`) value ('split');

insert into `exercise` (`description`, `weight_kg`, `reps`, `rest_time_sec`, `set_number`, `workout_id`)
  values
('Жим лежачи', 15, 30, 120, 1, (select @workout_id)),
('Жим лежачи', 15, 27, 120, 2, (select @workout_id)),
('Згинання рук стоячи', 9, 16, 120, 1, (select @workout_id)),
('Згинання рук стоячи', 9, 13, 120, 2, (select @workout_id)),
('Згинання рук стоячи', 9, 12, 120, 3, (select @workout_id)),
('Хаммер', 11, 10, 120, 1, (select @workout_id)),
('Хаммер', 11, 10, 120, 2, (select @workout_id)),
('Хаммер', 11, 10, 120, 3, (select @workout_id)),
('Концентрований підйом на біцепс сидячи', 10.2, 7, 120, 1, (select @workout_id)),
('Концентрований підйом на біцепс сидячи', 10.2, 8, 120, 2, (select @workout_id)),
('Концентрований підйом на біцепс сидячи', 10.2, 7, 0, 3, (select @workout_id));

set @workout_id = null;

/* без екіпірування */
insert into `style` (`id`) select e.id from exercise e
  join workout w on e.workout_id = w.id
  join athlet a on w.athlet_id = a.id
where a.nickname = 'vit'
  and w.workout_date = '20170530';

/* гантелі */
insert into `equipment` (`id`) select e.id from exercise e
  join workout w on e.workout_id = w.id
  join athlet a on w.athlet_id = a.id
where a.nickname = 'vit'
  and w.workout_date = '20170530';

call calculate_workout_duration ('vit', '20170530');
call calculate_tonnage ('vit', '20170530');

set @athlet_id = null;

commit;
