start transaction;

call set_athlet_id ('vit');

insert into `workout` (`workout_date`, `start_time`, `finish_time`, `athlet_id`)
  values
('20170730', '2017-07-30 16:55', '2017-07-30 17:57', (select @athlet_id));

call set_workout_id ('vit', '20170730');

/* split */
insert into `workout_type` (`wtype`) value ('split');

insert into `exercise` (`description`, `weight_kg`, `reps`, `rest_time_sec`, `set_number`, `workout_id`)
  values
('Згинання рук стоячи', 9, 16, 150, 1, (select @workout_id)),
('Згинання рук стоячи', 9, 12, 180, 2, (select @workout_id)),
('Згинання рук стоячи', 9, 11, 180, 3, (select @workout_id)),
('Згинання рук стоячи', 9, 13, 180, 4, (select @workout_id)),
('Згинання рук стоячи', 9, 10, 120, 5, (select @workout_id)),
('Хаммер', 9, 7, 180, 1, (select @workout_id)),
('Хаммер', 9, 10, 180, 2, (select @workout_id)),
('Махи у сторони', 9, 12, 120, 1, (select @workout_id)),
('Махи у сторони', 9, 12, 120, 2, (select @workout_id)),
('Махи у сторони', 9, 12, 120, 3, (select @workout_id)),
('Махи у сторони', 9, 12, 180, 4, (select @workout_id)),
('Махи вперед', 9, 10, 90, 1, (select @workout_id)),
('Махи вперед', 9, 10, 90, 2, (select @workout_id)),
('Махи вперед', 9, 10, 180, 3, (select @workout_id)),
('Шраги', 27, 20, 120, 1, (select @workout_id)),
('Шраги', 27, 20, 120, 2, (select @workout_id)),
('Шраги', 27, 22, 0, 3, (select @workout_id));

set @workout_id = null;

/* без екіпірування */
insert into `style` (`id`) select e.id from exercise e
  join workout w on e.workout_id = w.id
  join athlet a on w.athlet_id = a.id
where a.nickname = 'vit'
  and w.workout_date = '20170730';

/* гантелі */
insert into `equipment` (`id`) select e.id from exercise e
  join workout w on e.workout_id = w.id
  join athlet a on w.athlet_id = a.id
where a.nickname = 'vit'
  and w.workout_date = '20170730';

call calculate_workout_duration ('vit', '20170730');

call calculate_tonnage ('vit', '20170730');

set @athlet_id = null;

commit;
