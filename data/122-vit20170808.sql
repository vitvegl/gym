start transaction;

call set_athlet_id ('vit');

insert into `workout` (`workout_date`, `start_time`, `finish_time`, `athlet_id`)
  values
('20170808', '2017-08-08 15:17', '2017-08-08 16:21', (select @athlet_id));

call set_workout_id ('vit', '20170808');

/* split */
insert into `workout_type` (`wtype`) value ('split');

insert into `exercise` (`description`, `weight_kg`, `reps`, `rest_time_sec`, `set_number`, `workout_id`)
  values
('Жим лежачи', 21, 19, 180, 1, (select @workout_id)),
('Жим лежачи', 21, 14, 180, 2, (select @workout_id)),
('Жим лежачи', 21, 10, 240, 3, (select @workout_id)),
('Розведення рук лежачи', 13, 18, 180, 1, (select @workout_id)),
('Розведення рук лежачи', 15, 13, 120, 2, (select @workout_id)),
('Розведення рук лежачи', 15, 10, 180, 3, (select @workout_id)),
('Згинання рук стоячи', 15, 3, 120, 1, (select @workout_id)),
('Згинання рук стоячи', 15, 3, 120, 2, (select @workout_id)),
('Згинання рук стоячи', 15, 2, 120, 3, (select @workout_id)),
('Шраги', 27, 25, 120, 1, (select @workout_id)),
('Шраги', 27, 25, 120, 2, (select @workout_id)),
('Шраги', 27, 20, 0, 3, (select @workout_id));

set @workout_id = null;

/* без екіпірування */
insert into `style` (`id`) select e.id from exercise e
  join workout w on e.workout_id = w.id
  join athlet a on w.athlet_id = a.id
where a.nickname = 'vit'
  and w.workout_date = '20170808';

/* гантелі */
insert into `equipment` (`id`) select e.id from exercise e
  join workout w on e.workout_id = w.id
  join athlet a on w.athlet_id = a.id
where a.nickname = 'vit'
  and w.workout_date = '20170808';

call calculate_workout_duration ('vit', '20170808');

call calculate_tonnage ('vit', '20170808');

set @athlet_id = null;

commit;
