start transaction;

call set_athlet_id ('vit');

insert into `workout` (`workout_date`, `workout_duration`, `athlet_id`)
  values
('2017-03-05', '01:00', (select @athlet_id));

call set_workout_id ('vit', '2017-03-05');

/* split */
insert into `workout_type` (`wtype`) value ('split');

insert into `exercise` (`description`, `weight_kg`, `reps`, `rest_time_sec`, `set_number`, `workout_id`)
  values
('Присідання', 32, 15, 120, 1, (select @workout_id)),
('Присідання', 32, 15, 120, 2, (select @workout_id)),
('Присідання', 32, 15, 120, 3, (select @workout_id)),
('Концентрований підйом на біцепс сидячи', 8, 13, 120, 1, (select @workout_id)),
('Концентрований підйом на біцепс сидячи', 8, 10, 120, 2, (select @workout_id)),
('Концентрований підйом на біцепс сидячи', 8, 10, 120, 3, (select @workout_id)),
('Статичні випади вперед', 12, 8, 120, 1, (select @workout_id)),
('Статичні випади вперед', 12, 8, 120, 2, (select @workout_id)),
('Статичні випади вперед', 12, 8, 120, 3, (select @workout_id)),
('Хаммер', 8, 10, 120, 1, (select @workout_id)),
('Хаммер', 8, 10, 120, 2, (select @workout_id)),
('Згинання рук стоячи', 8, 14, 120, 1, (select @workout_id)),
('Згинання рук стоячи', 8, 12, 120, 2, (select @workout_id)),
('Згинання рук стоячи', 8, 10, 120, 3, (select @workout_id)),
('Станова тяга', 50, 6, 120, 1, (select @workout_id)),
('Станова тяга', 50, 6, 120, 2, (select @workout_id)),
('Станова тяга', 70, 3, 120, 3, (select @workout_id));

set @workout_id = null;

/* без екіпірування */
insert into `style` (`id`) select e.id from exercise e
  join workout w on e.workout_id = w.id
  join athlet a on w.athlet_id = a.id
where a.nickname = 'vit'
  and w.workout_date = '2017-03-05';

/* гантелі */
insert into `equipment` (`id`) select e.id from exercise e
  join workout w on e.workout_id = w.id
  join athlet a on w.athlet_id = a.id
where a.nickname = 'vit'
  and w.workout_date = '2017-03-05';

/* Присідання з гирями */
/* call update_exercise_set_equipment_specific_set ('vit', '2017-03-05', 'гирі', 'Присідання', 1); */
/* call update_exercise_set_equipment_specific_set ('vit', '2017-03-05', 'гирі', 'Присідання', 2); */
/* call update_exercise_set_equipment_specific_set ('vit', '2017-03-05', 'гирі', 'Присідання', 3); */
call update_exercise_set_equipment ('vit', '2017-03-05', 'гирі', 'Присідання');

/* Станова тяга зі штангою */
/* call update_exercise_set_equipment_specific_set ('vit', '2017-03-05', 'штанга', 'Станова тяга', 1); */
/* call update_exercise_set_equipment_specific_set ('vit', '2017-03-05', 'штанга', 'Станова тяга', 2); */
/* call update_exercise_set_equipment_specific_set ('vit', '2017-03-05', 'штанга', 'Станова тяга', 3); */
call update_exercise_set_equipment ('vit', '2017-03-05', 'штанга', 'Станова тяга');

commit;
