start transaction;

call set_athlet_id ('vit');

insert into `workout` (`workout_date`, `start_time`, `finish_time`, `athlet_id`)
  values
('20170521', '2017-05-21 13:40', '2017-05-21 15:21', (select @athlet_id));

call set_workout_id ('vit', '20170521');

/* split */
insert into `workout_type` (`wtype`) value ('split');

insert into `exercise` (`description`, `weight_kg`, `reps`, `rest_time_sec`, `set_number`, `workout_id`)
  values
('Жим лежачи', 50, 9, 60, 1, (select @workout_id)),
('Жим лежачи', 50, 6, 60, 2, (select @workout_id)),
('Жим лежачи', 50, 6, 60, 3, (select @workout_id)),
('Махи вперед', 6, 10, 60, 1, (select @workout_id)),
('Махи вперед', 6, 10, 60, 2, (select @workout_id)),
('Махи вперед', 6, 10, 60, 3, (select @workout_id)),
('Махи у сторони', 6, 10, 60, 1, (select @workout_id)),
('Махи у сторони', 6, 10, 60, 2, (select @workout_id)),
('Махи у сторони', 6, 10, 60, 3, (select @workout_id)),
('Тяга у нахилі', 50, 10, 90, 1, (select @workout_id)),
('Тяга у нахилі', 50, 10, 90, 2, (select @workout_id)),
('Тяга у нахилі', 50, 10, 90, 3, (select @workout_id)),
('Жим стоячи із-за голови', 30, 10, 90, 1, (select @workout_id)),
('Жим стоячи із-за голови', 30, 8, 90, 2, (select @workout_id)),
('Жим стоячи із-за голови', 30, 8, 90, 3, (select @workout_id)),
('Станова тяга', 50, 16, 60, 1, (select @workout_id)),
('Станова тяга', 50, 17, 0, 2, (select @workout_id));

set @workout_id = null;

/* без екіпірування */
insert into `style` (`id`) select e.id from exercise e
  join workout w on e.workout_id = w.id
  join athlet a on w.athlet_id = a.id
where a.nickname = 'vit'
  and w.workout_date = '20170521';

/* штанга */
insert into `equipment` (`id`, `equipment`) select e.id, 'штанга' from exercise e
  join workout w on e.workout_id = w.id
  join athlet a on w.athlet_id = a.id
where a.nickname = 'vit'
  and w.workout_date = '20170521';

call update_exercise_set_equipment ('vit', '20170521', 'гантелі', 'Махи вперед', 1);
call update_exercise_set_equipment ('vit', '20170521', 'гантелі', 'Махи вперед', 2);
call update_exercise_set_equipment ('vit', '20170521', 'гантелі', 'Махи вперед', 3);

call update_exercise_set_equipment ('vit', '20170521', 'гантелі', 'Махи у сторони', 1);
call update_exercise_set_equipment ('vit', '20170521', 'гантелі', 'Махи у сторони', 2);
call update_exercise_set_equipment ('vit', '20170521', 'гантелі', 'Махи у сторони', 3);

call calculate_workout_duration ('vit', '20170521');
call calculate_tonnage ('vit', '20170521');

commit;
