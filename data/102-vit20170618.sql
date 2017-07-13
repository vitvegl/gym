start transaction;

call set_athlet_id ('vit');

insert into `workout` (`workout_date`, `start_time`, `finish_time`, `athlet_id`)
  values
('20170618', '2017-06-18 14:40', '2017-06-18 15:54', (select @athlet_id));

call set_workout_id ('vit', '20170618');

/* split */
insert into `workout_type` (`wtype`) value ('split');

insert into `exercise` (`description`, `weight_kg`, `reps`, `rest_time_sec`, `set_number`, `workout_id`)
  values
('Присідання', 33, 6, 120, 1, (select @workout_id)),
('Присідання', 33, 10, 120, 2, (select @workout_id)),
('Французький жим лежачи', 9, 12, 60, 1, (select @workout_id)),
('Французький жим лежачи', 9, 12, 60, 2, (select @workout_id)),
('Французький жим лежачи', 9, 12, 120, 3, (select @workout_id)),
('Пулл-овер стоячи', 21, 20, 120, 1, (select @workout_id)),
('Пулл-овер стоячи', 21, 14, 120, 2, (select @workout_id)),
('Пулл-овер стоячи', 21, 14, 120, 3, (select @workout_id)),
('Махи у сторони', 7, 16, 120, 1, (select @workout_id)),
('Махи у сторони', 7, 16, 120, 2, (select @workout_id)),
('Махи у сторони', 7, 16, 120, 3, (select @workout_id)),
('Махи вперед', 7, 11, 120, 1, (select @workout_id)),
('Махи вперед', 7, 11, 120, 1, (select @workout_id)),
('Махи вперед', 7, 11, 180, 1, (select @workout_id)),
('Згинання рук стоячи', 11, 13, 180, 1, (select @workout_id)),
('Згинання рук стоячи', 11, 11, 180, 2, (select @workout_id)),
('Згинання рук стоячи', 11, 10, 180, 3, (select @workout_id)),
('Хаммер', 9, 10, 90, 1, (select @workout_id)),
('Хаммер', 9, 10, 120, 2, (select @workout_id)),
('Хаммер', 9, 10, 0, 3, (select @workout_id));

set @workout_id = null;

/* без екіпірування */
insert into `style` (`id`) select e.id from exercise e
  join workout w on e.workout_id = w.id
  join athlet a on w.athlet_id = a.id
where a.nickname = 'vit'
  and w.workout_date = '20170618';

/* гантелі */
insert into `equipment` (`id`) select e.id from exercise e
  join workout w on e.workout_id = w.id
  join athlet a on w.athlet_id = a.id
where a.nickname = 'vit'
  and w.workout_date = '20170618';

call calculate_workout_duration ('vit', '20170618');

call update_exercise_set_equipment_specific_set ('vit', '20170618', 'гантель', 'Пулл-овер стоячи', 1);
call update_exercise_set_equipment_specific_set ('vit', '20170618', 'гантель', 'Пулл-овер стоячи', 2);
call update_exercise_set_equipment_specific_set ('vit', '20170618', 'гантель', 'Пулл-овер стоячи', 3);

call calculate_tonnage ('vit', '20170618');

set @athlet_id = null;

commit;
