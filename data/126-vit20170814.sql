start transaction;

call set_athlet_id ('vit');

insert into `workout` (`workout_date`, `start_time`, `finish_time`, `athlet_id`)
  values
('20170814', '2017-08-14 18:38', '2017-08-14 19:25', (select @athlet_id));

call set_workout_id ('vit', '20170814');

/* split */
insert into `workout_type` (`wtype`) value ('split');

insert into `exercise` (`description`, `weight_kg`, `reps`, `rest_time_sec`, `set_number`, `workout_id`)
  values
('Жим стоячи', 15, 12, 90, 1, (select @workout_id)),
('Жим стоячи', 15, 12, 120, 2, (select @workout_id)),
('Жим стоячи', 15, 12, 120, 3, (select @workout_id)),
('Розведення рук лежачи', 15, 12, 120, 1, (select @workout_id)),
('Розведення рук лежачи', 15, 12, 120, 2, (select @workout_id)),
('Розведення рук лежачи', 15, 12, 120, 3, (select @workout_id)),
('Згинання рук стоячи', 13, 9, 120, 1, (select @workout_id)),
('Згинання рук стоячи', 13, 7, 120, 2, (select @workout_id)),
('Згинання рук стоячи', 13, 7, 120, 3, (select @workout_id)),
('Хаммер', 13, 6, 120, 1, (select @workout_id)),
('Хаммер', 9, 12, 90, 2, (select @workout_id)),
('Хаммер', 9, 10, 120, 3, (select @workout_id)),
('Махи у сторони', 7, 11, 60, 1, (select @workout_id)),
('Махи у сторони', 7, 12, 60, 2, (select @workout_id)),
('Махи у сторони', 7, 12, 60, 3, (select @workout_id)),
('Махи вперед', 9, 10, 90, 1, (select @workout_id)),
('Махи вперед', 9, 10, 120, 2, (select @workout_id)),
('Махи вперед', 9, 10, 0, 3, (select @workout_id));

set @workout_id = null;

/* без екіпірування */
insert into `style` (`id`) select e.id from exercise e
  join workout w on e.workout_id = w.id
  join athlet a on w.athlet_id = a.id
where a.nickname = 'vit'
  and w.workout_date = '20170814';

/* гантелі */
insert into `equipment` (`id`) select e.id from exercise e
  join workout w on e.workout_id = w.id
  join athlet a on w.athlet_id = a.id
where a.nickname = 'vit'
  and w.workout_date = '20170814';

call calculate_workout_duration ('vit', '20170814');

call calculate_tonnage ('vit', '20170814');

set @athlet_id = null;

commit;
