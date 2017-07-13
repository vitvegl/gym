start transaction;

call set_athlet_id ('vit');

insert into `workout` (`workout_date`, `workout_duration`, `athlet_id`)
  values
('20170401', '0:30', (select @athlet_id));

call set_workout_id ('vit', '20170401');

/* split */
insert into `workout_type` (`wtype`) value ('split');

insert into `exercise` (`description`, `weight_kg`, `reps`, `rest_time_sec`, `set_number`, `workout_id`)
  values
('Станова тяга', 21, 16, 120, 1, (select @workout_id)),
('Станова тяга', 21, 16, 120, 2, (select @workout_id)),
('Станова тяга', 21, 16, 120, 3, (select @workout_id)),
('Станова тяга', 21, 16, 120, 4, (select @workout_id)),
('Станова тяга', 21, 16, 120, 5, (select @workout_id)),
('Пулл-овер сидячи', 21, 12, 120, 1, (select @workout_id)),
('Пулл-овер сидячи', 21, 12, 120, 2, (select @workout_id)),
('Пулл-овер сидячи', 21, 11, 120, 3, (select @workout_id)),
('Тяга 1 рукою у нахилі', 21, 16, 120, 1, (select @workout_id)),
('Тяга 1 рукою у нахилі', 21, 16, 120, 2, (select @workout_id)),
('Тяга 1 рукою у нахилі', 21, 16, 120, 3, (select @workout_id)),
('Французький жим лежачи', 9, 16, 90, 1, (select @workout_id)),
('Французький жим лежачи', 9, 16, 90, 2, (select @workout_id)),
('Французький жим лежачи', 9, 13, 90, 3, (select @workout_id)),
('Віджимання у нахилі в положенні рук за спиною', 0, 10, 90, 1, (select @workout_id)),
('Віджимання у нахилі в положенні рук за спиною', 0, 10, 90, 2, (select @workout_id)),
('Віджимання у нахилі в положенні рук за спиною', 0, 10, 90, 3, (select @workout_id));

set @workout_id = null;

/* без екіпірування */
insert into `style` (`id`) select e.id from exercise e
  join workout w on e.workout_id = w.id
  join athlet a on w.athlet_id = a.id
where a.nickname = 'vit'
  and w.workout_date = '20170401';

/* гантелі */
insert into `equipment` (`id`) select e.id from exercise e
  join workout w on e.workout_id = w.id
  join athlet a on w.athlet_id = a.id
where a.nickname = 'vit'
  and w.workout_date = '20170401';

call update_exercise_if_no_weight ('vit', '20170401');

/* call update_exercise_set_equipment_specific_set ('vit', '20170401', 'гантель', 'Пулл-овер сидячи', 1); */
/* call update_exercise_set_equipment_specific_set ('vit', '20170401', 'гантель', 'Пулл-овер сидячи', 2); */
/* call update_exercise_set_equipment_specific_set ('vit', '20170401', 'гантель', 'Пулл-овер сидячи', 3); */
call update_exercise_set_equipment ('vit', '20170401', 'гантель', 'Пулл-овер сидячи');

call calculate_tonnage ('vit', '20170401');

set @athlet_id = null;

commit;
