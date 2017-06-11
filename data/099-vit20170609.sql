start transaction;

call set_athlet_id ('vit');

insert into `workout` (`workout_date`, `start_time`, `finish_time`, `athlet_id`)
  values
('20170609', '2017-06-09 22:30', '2017-06-09 23:05', (select @athlet_id));

call set_workout_id ('vit', '20170609');

/* split */
insert into `workout_type` (`wtype`) value ('split');

insert into `exercise` (`description`, `weight_kg`, `reps`, `rest_time_sec`, `set_number`, `workout_id`)
  values
('Жим лежачи', 21, 18, 180, 1, (select @workout_id)),
('Жим лежачи', 21, 16, 180, 2, (select @workout_id)),
('Жим лежачи', 21, 14, 120, 3, (select @workout_id)),
('Розведення рук лежачи', 13, 16, 60, 1, (select @workout_id)),
('Розведення рук лежачи', 13, 16, 60, 2, (select @workout_id)),
('Розведення рук лежачи', 13, 16, 120, 3, (select @workout_id)),
('Згинання рук стоячи', 11, 13, 120, 1, (select @workout_id)),
('Згинання рук стоячи', 11, 10, 0, 2, (select @workout_id));

set @workout_id = null;

/* без екіпірування */
insert into `style` (`id`) select e.id from exercise e
  join workout w on e.workout_id = w.id
  join athlet a on w.athlet_id = a.id
where a.nickname = 'vit'
  and w.workout_date = '20170609';

/* гантелі */
insert into `equipment` (`id`) select e.id from exercise e
  join workout w on e.workout_id = w.id
  join athlet a on w.athlet_id = a.id
where a.nickname = 'vit'
  and w.workout_date = '20170609';

call calculate_workout_duration ('vit', '20170609');
call calculate_tonnage ('vit', '20170609');

set @athlet_id = null;

commit;
