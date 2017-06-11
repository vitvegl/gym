start transaction;

call set_athlet_id ('vit');

insert into `workout` (`workout_date`, `workout_duration`, `athlet_id`)
  values
('20170410', '01:13', (select @athlet_id));

call set_workout_id ('vit', '20170410');

/* split */
insert into `workout_type` (`wtype`) value ('split');

insert into `exercise` (`description`, `weight_kg`, `reps`, `rest_time_sec`, `set_number`, `workout_id`)
  values
('Присідання', 21, 13, 120, 1, (select @workout_id)),
('Присідання', 21, 14, 120, 2, (select @workout_id)),
('Присідання', 21, 13, 120, 3, (select @workout_id)),
('Жим сидячи', 15, 12, 120, 1, (select @workout_id)),
('Жим сидячи', 15, 10, 120, 2, (select @workout_id)),
('Жим сидячи', 15, 10, 120, 3, (select @workout_id)),
('Присідання Пліє', 36, 10, 120, 1, (select @workout_id)),
('Присідання Пліє', 36, 10, 120, 2, (select @workout_id)),
('Присідання Пліє', 36, 10, 120, 3, (select @workout_id)),
('Тяга до підборіддя', 9, 15, 90, 1, (select @workout_id)),
('Тяга до підборіддя', 9, 15, 90, 2, (select @workout_id)),
('Тяга до підборіддя', 9, 15, 90, 3, (select @workout_id)),
('Тяга до підборіддя', 9, 15, 90, 4, (select @workout_id)),
('Махи у сторони', 7, 16, 120, 1, (select @workout_id)),
('Махи у сторони', 7, 13, 120, 2, (select @workout_id)),
('Махи у сторони', 7, 12, 30, 3, (select @workout_id)),
('Махи вперед', 7, 10, 90, 1, (select @workout_id)),
('Махи вперед', 7, 10, 90, 2, (select @workout_id)),
('Махи вперед', 7, 10, 90, 3, (select @workout_id)),
('Махи вперед', 7, 10, 0, 4, (select @workout_id));

set @workout_id = null;

/* без екіпірування */
insert into `style` (`id`) select e.id from exercise e
  join workout w on e.workout_id = w.id
  join athlet a on w.athlet_id = a.id
where a.nickname = 'vit'
  and w.workout_date = '20170410';

/* гантелі */
insert into `equipment` (`id`) select e.id from exercise e
  join workout w on e.workout_id = w.id
  join athlet a on w.athlet_id = a.id
where a.nickname = 'vit'
  and w.workout_date = '20170410';

call update_exercise_set_equipment ('vit', '20170410', 'гантель', 'Присідання Пліє', 1);
call update_exercise_set_equipment ('vit', '20170410', 'гантель', 'Присідання Пліє', 2);
call update_exercise_set_equipment ('vit', '20170410', 'гантель', 'Присідання Пліє', 3);

call calculate_tonnage ('vit', '20170410');

set @athlet_id = null;

commit;
