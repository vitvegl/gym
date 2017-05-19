start transaction;

call set_athlet_id ('vit');

insert into `workout` (`workout_date`, `workout_duration`, `athlet_id`)
  values
('20170514', '1:00', (select @athlet_id));

call set_workout_id ('vit', '20170514');

/* split */
insert into `workout_type` (`wtype`) value ('split');

insert into `exercise` (`description`, `weight_kg`, `reps`, `rest_time_sec`, `workout_id`)
  values
('Жим лежачи', 50, 9, 90, (select @workout_id)),
('Жим лежачи', 50, 8, 90, (select @workout_id)),
('Присідання', 50, 10, 90, (select @workout_id)),
('Присідання', 70, 4, 90, (select @workout_id)),
('Станова тяга', 50, 10, 90, (select @workout_id)),
('Станова тяга', 50, 10, 90, (select @workout_id)),
('Станова тяга', 70, 6, 1800, (select @workout_id)),
('Підтягування на турніку зворотнім хватом', 0, 5, 60, (select @workout_id)),
('Підтягування на турніку зворотнім хватом', 0, 5, 60, (select @workout_id)),
('Віджимання на брусах', 0, 7, 90, (select @workout_id)),
('Віджимання на брусах', 0, 7, 90, (select @workout_id)),
('Віджимання на брусах', 0, 4, 90, (select @workout_id));

set @workout_id = null;

/* без екіпірування */
insert into `style` (`id`) select e.id from exercise e
  join workout w on e.workout_id = w.id
  join athlet a on w.athlet_id = a.id
where a.nickname = 'vit'
  and w.workout_date = '20170514';

/* штанга */
insert into `equipment` (`id`, `equipment`) select e.id, 'штанга' from exercise e
  join workout w on e.workout_id = w.id
  join athlet a on w.athlet_id = a.id
where a.nickname = 'vit'
  and w.workout_date = '20170514';

call update_exercise_if_no_weight ('vit', '20170514');

commit;
