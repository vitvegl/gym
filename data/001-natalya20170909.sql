start transaction;

insert into `athlet` (`nickname`) values ('natalya');

call set_athlet_id ('natalya');

insert into `workout` (`workout_date`, `start_time`, `finish_time`, `athlet_id`)
  values
('20170909', '2017-09-09 21:33', '2017-09-09 22:16', (select @athlet_id));

call set_workout_id ('natalya', '20170909');

/* split */
insert into `workout_type` (`wtype`) value ('split');

insert into `exercise` (`description`, `weight_kg`, `reps`, `rest_time_sec`, `set_number`, `workout_id`)
  values
('Прес', 0, 10, 120, 1, (select @workout_id)),
('Прес', 0, 10, 90, 2, (select @workout_id)),
('Прес', 0, 10, 120, 3, (select @workout_id)),
('Жим лежачи', 7, 10, 120, 1, (select @workout_id)),
('Жим лежачи', 7, 10, 120, 2, (select @workout_id)),
('Жим лежачи', 7, 7, 120, 3, (select @workout_id)),
('Хаммер', 5, 21, 120, 1, (select @workout_id)),
('Хаммер', 5, 8, 120, 2, (select @workout_id)),
('Хаммер', 5, 7, 120, 3, (select @workout_id)),
('Концентрований підйом на біцепс', 5, 3, 120, 1, (select @workout_id)),
('Концентрований підйом на біцепс', 5, 3, 120, 2, (select @workout_id)),
('Статичні випади вперед', 5, 10, 0, 1, (select @workout_id));

set @workout_id = null;

/* без екіпірування */
insert into `style` (`id`) select e.id from exercise e
  join workout w on e.workout_id = w.id
  join athlet a on w.athlet_id = a.id
where a.nickname = 'natalya'
  and w.workout_date = '20170909';

/* гантелі */
insert into `equipment` (`id`) select e.id from exercise e
  join workout w on e.workout_id = w.id
  join athlet a on w.athlet_id = a.id
where a.nickname = 'natalya'
  and w.workout_date = '20170909';

call update_exercise_if_no_weight ('natalya', '20170909');

call calculate_workout_duration ('natalya', '20170909');

call calculate_tonnage ('natalya', '20170909');

set @athlet_id = null;

commit;
