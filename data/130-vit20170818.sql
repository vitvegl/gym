start transaction;

call set_athlet_id ('vit');

insert into `workout` (`workout_date`, `start_time`, `finish_time`, `athlet_id`)
  values
('20170818', '2017-08-18 19:10', '2017-08-18 19:35', (select @athlet_id));

call set_workout_id ('vit', '20170818');

/* split */
insert into `workout_type` (`wtype`) value ('split');

insert into `exercise` (`description`, `weight_kg`, `reps`, `rest_time_sec`, `set_number`, `workout_id`)
  values
('Жим лежачи', 21, 10, 120, 1, (select @workout_id)),
('Жим лежачи', 21, 10, 120, 2, (select @workout_id)),
('Жим лежачи', 23, 3, 120, 3, (select @workout_id)),
('Жим лежачи', 23, 3, 120, 4, (select @workout_id)),
('Жим лежачи', 25, 3, 120, 5, (select @workout_id)),
('Жим лежачи', 25, 3, 120, 6, (select @workout_id)),
('Жим лежачи', 27, 0, 60, 7, (select @workout_id)),
('Жим лежачи', 27, 0, 0, 8, (select @workout_id));

set @workout_id = null;

/* без екіпірування */
insert into `style` (`id`) select e.id from exercise e
  join workout w on e.workout_id = w.id
  join athlet a on w.athlet_id = a.id
where a.nickname = 'vit'
  and w.workout_date = '20170818';

/* гантелі */
insert into `equipment` (`id`) select e.id from exercise e
  join workout w on e.workout_id = w.id
  join athlet a on w.athlet_id = a.id
where a.nickname = 'vit'
  and w.workout_date = '20170818';

call calculate_workout_duration ('vit', '20170818');

call calculate_tonnage ('vit', '20170818');

set @athlet_id = null;

commit;
