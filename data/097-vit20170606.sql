start transaction;

call set_athlet_id ('vit');

insert into `workout` (`workout_date`, `start_time`, `finish_time`, `athlet_id`)
  values
('20170606', '2017-06-06 19:05', '2017-06-06 20:12', (select @athlet_id));

call set_workout_id ('vit', '20170606');

/* split */
insert into `workout_type` (`wtype`) value ('split');

insert into `exercise` (`description`, `weight_kg`, `reps`, `rest_time_sec`, `set_number`, `workout_id`)
  values
('Прес', 0, 20, 90, 1, (select @workout_id)),
('Прес', 0, 20, 90, 2, (select @workout_id)),
('Прес', 0, 20, 120, 3, (select @workout_id)),
('Жим лежачи', 15, 30, 120, 1, (select @workout_id)),
('Жим лежачи', 15, 25, 180, 2, (select @workout_id)),
('Французький жим лежачи', 9, 12, 60, 1, (select @workout_id)),
('Французький жим лежачи', 9, 12, 60, 2, (select @workout_id)),
('Французький жим лежачи', 9, 12, 180, 3, (select @workout_id)),
('Пулл-овер стоячи', 21, 14, 90, 1, (select @workout_id)),
('Пулл-овер стоячи', 21, 12, 90, 2, (select @workout_id)),
('Пулл-овер стоячи', 21, 11, 120, 3, (select @workout_id)),
('Віджимання у нахилі в положенні рук за спиною', 0, 10, 60, 1, (select @workout_id)),
('Віджимання у нахилі в положенні рук за спиною', 0, 10, 60, 2, (select @workout_id)),
('Віджимання у нахилі в положенні рук за спиною', 0, 10, 60, 3, (select @workout_id)),
('Віджимання у нахилі в положенні рук за спиною', 0, 10, 120, 4, (select @workout_id)),
('Згинання рук стоячи', 10.2, 15, 120, 1, (select @workout_id)),
('Згинання рук стоячи', 10.2, 12, 120, 2, (select @workout_id)),
('Згинання рук стоячи', 10.2, 10, 120, 3, (select @workout_id)),
('Хаммер', 9, 10, 90, 1, (select @workout_id)),
('Хаммер', 9, 10, 90, 2, (select @workout_id)),
('Хаммер', 9, 10, 0, 3, (select @workout_id));

set @workout_id = null;

/* без екіпірування */
insert into `style` (`id`) select e.id from exercise e
  join workout w on e.workout_id = w.id
  join athlet a on w.athlet_id = a.id
where a.nickname = 'vit'
  and w.workout_date = '20170606';

/* гантелі */
insert into `equipment` (`id`) select e.id from exercise e
  join workout w on e.workout_id = w.id
  join athlet a on w.athlet_id = a.id
where a.nickname = 'vit'
  and w.workout_date = '20170606';

call update_exercise_if_no_weight ('vit', '20170606');
call calculate_workout_duration ('vit', '20170606');
call calculate_tonnage ('vit', '20170606');

set @athlet_id = null;

commit;
