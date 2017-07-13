start transaction;

call set_athlet_id ('vit');

insert into `workout` (`workout_date`, `athlet_id`)
  values
('2016-11-28', (select @athlet_id));

call set_workout_id ('vit', '2016-11-28');

/* fullbody */
insert into `workout_type` (`wtype`) values ('fullbody');

insert into `exercise` (`description`, `weight_kg`, `reps`, `rest_time_sec`, `set_number`, `workout_id`)
  values
('Жим лежачи', 20.5, 10, 120, 1, (select @workout_id)),
('Жим лежачи', 20.5, 10, 120, 2, (select @workout_id)),
('Жим лежачи', 20.5, 10, 120, 3, (select @workout_id)),
('Присідання', 27, 8, 120, 1, (select @workout_id)),
('Присідання', 27, 8, 120, 2, (select @workout_id)),
('Присідання', 27, 8, 120, 3, (select @workout_id)),
('Станова тяга', 30, 10, 120, 1, (select @workout_id)),
('Станова тяга', 30, 10, 120, 2, (select @workout_id)),
('Станова тяга', 30, 10, 120, 3, (select @workout_id)),
('Тяга 1 рукою у нахилі', 21, 10, 120, 1, (select @workout_id)),
('Тяга 1 рукою у нахилі', 21, 10, 120, 2, (select @workout_id)),
('Тяга 1 рукою у нахилі', 21, 10, 120, 3, (select @workout_id)),
('Махи у сторони', 6.2, 10, 120, 1, (select @workout_id)),
('Махи у сторони', 6.2, 10, 120, 2, (select @workout_id)),
('Махи у сторони', 6.2, 10, 120, 3, (select @workout_id)),
('Концентрований підйом на біцепс', 9, 10, 120, 1, (select @workout_id)),
('Концентрований підйом на біцепс', 9, 10, 120, 2, (select @workout_id)),
('Концентрований підйом на біцепс', 9, 10, 120, 3, (select @workout_id)),
('Розведення рук лежачи', 8.2, 10, 120, 1, (select @workout_id)),
('Розведення рук лежачи', 8.2, 10, 120, 2, (select @workout_id)),
('Розведення рук лежачи', 8.2, 10, 120, 3, (select @workout_id)),
('Жим сидячи', 11, 10, 120, 1, (select @workout_id)),
('Жим сидячи', 11, 10, 120, 2, (select @workout_id)),
('Жим сидячи', 11, 10, 120, 3, (select @workout_id)),
('Пулл-овер стоячи', 13, 10, 120, 1, (select @workout_id)),
('Пулл-овер стоячи', 13, 9, 120, 2, (select @workout_id)),
('Пулл-овер стоячи', 13, 8, 0, 3, (select @workout_id));

set @workout_id = null;

/* без екіпірування */
insert into `style` (`id`) select e.id from exercise e
  join workout w on e.workout_id = w.id
  join athlet a on w.athlet_id = a.id
where a.nickname = 'vit' and w.workout_date = '2016-11-28';

/* гантелі */
insert into `equipment` (`id`) select e.id from exercise e
  join workout w on e.workout_id = w.id
  join athlet a on w.athlet_id = a.id
where a.nickname = 'vit' and w.workout_date = '2016-11-28';


/* call update_exercise_set_equipment_specific_set ('vit', '2016-11-28', 'гантель', 'Пулл-овер стоячи', 1); */
/* call update_exercise_set_equipment_specific_set ('vit', '2016-11-28', 'гантель', 'Пулл-овер стоячи', 2); */
/* call update_exercise_set_equipment_specific_set ('vit', '2016-11-28', 'гантель', 'Пулл-овер стоячи', 3); */
call update_exercise_set_equipment ('vit', '2016-11-28', 'гантель', 'Пулл-овер стоячи');

call calculate_tonnage ('vit', '2016-11-28');

set @athlet_id = null;

commit;
