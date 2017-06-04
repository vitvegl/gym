start transaction;

call set_athlet_id ('vit');

insert into `workout` (`workout_date`, `start_time`, `finish_time`, `athlet_id`)
  values
('20170604', '2017-06-04 15:00', '2017-06-04 15:43', (select @athlet_id));

call set_workout_id ('vit', '20170604');

/* split */
insert into `workout_type` (`wtype`) value ('split');

insert into `exercise` (`description`, `weight_kg`, `reps`, `rest_time_sec`, `set_number`, `workout_id`)
  values
('Жим лежачи', 50, 11, 120, 1, (select @workout_id)),
('Жим лежачи', 50, 9, 120, 2, (select @workout_id)),
('Жим лежачи', 50, 6, 120, 3, (select @workout_id)),
('Жим лежачи', 60, 0, 120, 4, (select @workout_id)),
('Присідання', 50, 10, 240, 1, (select @workout_id)),
('Станова тяга', 50, 10, 90, 1, (select @workout_id)),
('Станова тяга', 50, 10, 90, 2, (select @workout_id)),
('Станова тяга', 70, 6, 120, 3, (select @workout_id)),
('Станова тяга', 70, 6, 120, 4, (select @workout_id)),
('Станова тяга', 90, 3, 120, 5, (select @workout_id)),
('Станова тяга', 100, 6, 120, 6, (select @workout_id)),
('Станова тяга', 100, 6, 0, 7, (select @workout_id));

set @workout_id = null;

/* без екіпірування */
insert into `style` (`id`) select e.id from exercise e
  join workout w on e.workout_id = w.id
  join athlet a on w.athlet_id = a.id
where a.nickname = 'vit'
  and w.workout_date = '20170604';

/* штанга */
insert into `equipment` (`id`, `equipment`) select e.id, 'штанга' from exercise e
  join workout w on e.workout_id = w.id
  join athlet a on w.athlet_id = a.id
where a.nickname = 'vit'
  and w.workout_date = '20170604';


call update_exercise_set_style ('vit', '20170604', 'штанга', 'лямки', 'Станова тяга', 6);
call update_exercise_set_style ('vit', '20170604', 'штанга', 'лямки', 'Станова тяга', 7);

call calculate_workout_duration ('vit', '20170604');
call calculate_tonnage ('vit', '20170604');

set @athlet_id = null;

commit;
