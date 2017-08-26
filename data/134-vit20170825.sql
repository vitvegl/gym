start transaction;

call set_athlet_id ('vit');

insert into `workout` (`workout_date`, `start_time`, `finish_time`, `athlet_id`)
  values
('20170825', '2017-08-25 20:15', '2017-08-25 21:17', (select @athlet_id));

call set_workout_id ('vit', '20170825');

/* fullbody */
insert into `workout_type` (`wtype`) value ('fullbody');

insert into `exercise` (`description`, `weight_kg`, `reps`, `rest_time_sec`, `set_number`, `workout_id`)
  values
('Жим стоячи', 15, 12, 90, 1, (select @workout_id)),
('Жим стоячи', 15, 12, 120, 2, (select @workout_id)),
('Жим стоячи', 15, 12, 120, 3, (select @workout_id)),
('Згинання рук стоячи', 15, 4, 120, 1, (select @workout_id)),
('Згинання рук стоячи', 15, 4, 120, 2, (select @workout_id)),
('Пулл-овер стоячи', 25, 16, 120, 1, (select @workout_id)),
('Пулл-овер стоячи', 25, 16, 120, 2, (select @workout_id)),
('Пулл-овер стоячи', 25, 12, 120, 3, (select @workout_id)),
('Розведення рук лежачи', 17, 12, 120, 1, (select @workout_id)),
('Розведення рук лежачи', 17, 12, 120, 2, (select @workout_id)),
('Розведення рук лежачи', 17, 11, 120, 3, (select @workout_id)),
('Станова тяга', 21, 20, 120, 1, (select @workout_id)),
('Станова тяга', 21, 20, 180, 2, (select @workout_id)),
('Махи у сторони', 7, 16, 120, 1, (select @workout_id)),
('Махи у сторони', 7, 16, 120, 2, (select @workout_id)),
('Махи вперед', 9, 10, 120, 1, (select @workout_id)),
('Махи вперед', 9, 10, 0, 2, (select @workout_id));

set @workout_id = null;

/* без екіпірування */
insert into `style` (`id`) select e.id from exercise e
  join workout w on e.workout_id = w.id
  join athlet a on w.athlet_id = a.id
where a.nickname = 'vit'
  and w.workout_date = '20170825';

/* гантелі */
insert into `equipment` (`id`) select e.id from exercise e
  join workout w on e.workout_id = w.id
  join athlet a on w.athlet_id = a.id
where a.nickname = 'vit'
  and w.workout_date = '20170825';

call calculate_workout_duration ('vit', '20170825');

call update_exercise_set_equipment ('vit', '20170825', 'гантель', 'Пулл-овер стоячи');

call calculate_tonnage ('vit', '20170825');

set @athlet_id = null;

commit;
