start transaction;

call set_athlet_id ('vit');

insert into `workout` (`workout_date`, `start_time`, `finish_time`, `athlet_id`)
  values
('20170524', '14:55', '15:36', (select @athlet_id));

call set_workout_id ('vit', '20170524');

/* split */
insert into `workout_type` (`wtype`) value ('split');

insert into `exercise` (`description`, `weight_kg`, `reps`, `rest_time_sec`, `workout_id`)
  values
('Жим лежачи', 21, 16, 120, (select @workout_id)),
('Жим лежачи', 21, 13, 120, (select @workout_id)),
('Жим лежачи', 21, 12, 120, (select @workout_id)),
('Згинання рук стоячи', 9, 16, 90, (select @workout_id)),
('Згинання рук стоячи', 9, 12, 90, (select @workout_id)),
('Згинання рук стоячи', 9, 12, 90, (select @workout_id)),
('Хаммер', 11, 7, 120, (select @workout_id)),
('Хаммер', 11, 8, 120, (select @workout_id)),
('Хаммер', 11, 8, 90, (select @workout_id)),
('Концентрований підйом на біцепс сидячи', 10.2, 8, 90, (select @workout_id)),
('Концентрований підйом на біцепс сидячи', 10.2, 7, 90, (select @workout_id)),
('Концентрований підйом на біцепс сидячи', 10.2, 7, 0, (select @workout_id));

set @workout_id = null;

/* без екіпірування */
insert into `style` (`id`) select e.id from exercise e
  join workout w on e.workout_id = w.id
  join athlet a on w.athlet_id = a.id
where a.nickname = 'vit'
  and w.workout_date = '20170524';

/* гантелі */
insert into `equipment` (`id`) select e.id from exercise e
  join workout w on e.workout_id = w.id
  join athlet a on w.athlet_id = a.id
where a.nickname = 'vit'
  and w.workout_date = '20170524';

call calculate_workout_duration ('vit', '20170524');
call calculate_tonnage ('vit', '20170524');

set @athlet_id = null;

commit;
