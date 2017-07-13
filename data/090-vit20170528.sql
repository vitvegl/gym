start transaction;

call set_athlet_id ('vit');

insert into `workout` (`workout_date`, `start_time`, `finish_time`, `athlet_id`)
  values
('20170528', '2017-05-28 13:46', '2017-05-28 15:13', (select @athlet_id));

call set_workout_id ('vit', '20170528');

/* split */
insert into `workout_type` (`wtype`) value ('split');

insert into `exercise` (`description`, `weight_kg`, `reps`, `rest_time_sec`, `set_number`, `workout_id`)
  values
('Жим лежачи', 50, 9, 60, 1, (select @workout_id)),
('Жим лежачи', 50, 8, 60, 2, (select @workout_id)),
('Жим лежачи', 50, 6, 120, 3, (select @workout_id)),
('Жим лежачи', 60, 2, 90, 4, (select @workout_id)),
('Згинання рук сидячи', 30, 2, 120, 1, (select @workout_id)),
('Згинання рук сидячи', 20, 16, 120, 2, (select @workout_id)),
('Згинання рук сидячи', 30, 3, 120, 3, (select @workout_id)),
('Хаммер', 7, 15, 90, 1, (select @workout_id)),
('Хаммер', 7, 15, 90, 2, (select @workout_id)),
('Станова тяга', 50, 10, 60, 1, (select @workout_id)),
('Станова тяга', 50, 10, 60, 2, (select @workout_id)),
('Станова тяга', 70, 6, 90, 3, (select @workout_id)),
('Станова тяга', 70, 6, 90, 4, (select @workout_id)),
('Станова тяга', 90, 3, 120, 5, (select @workout_id)),
('Станова тяга', 100, 3, 120, 6, (select @workout_id)),
('Станова тяга', 100, 2, 0, 7, (select @workout_id));

set @workout_id = null;

/* без екіпірування */
insert into `style` (`id`) select e.id from exercise e
  join workout w on e.workout_id = w.id
  join athlet a on w.athlet_id = a.id
where a.nickname = 'vit'
  and w.workout_date = '20170528';

/* штанга */
insert into `equipment` (`id`, `equipment`) select e.id, 'штанга' from exercise e
  join workout w on e.workout_id = w.id
  join athlet a on w.athlet_id = a.id
where a.nickname = 'vit'
  and w.workout_date = '20170528';

/* лавка Скотта */

/* call update_exercise_set_equipment_specific_set ('vit', '20170528', 'тренажер', 'Згинання рук сидячи', 1); */
/* call update_exercise_set_equipment_specific_set ('vit', '20170528', 'тренажер', 'Згинання рук сидячи', 2); */
/* call update_exercise_set_equipment_specific_set ('vit', '20170528', 'тренажер', 'Згинання рук сидячи', 3); */

call update_exercise_set_equipment ('vit', '20170528', 'тренажер', 'Згинання рук сидячи');

call calculate_workout_duration ('vit', '20170528');
call calculate_tonnage ('vit', '20170528');

set @athlet_id = null;

commit;

