start transaction;

call set_athlet_id ('vit');

insert into `workout` (`workout_date`, `start_time`, `finish_time`, `athlet_id`)
  values
('20170904', '2017-09-04 22:30', '2017-09-04 23:12', (select @athlet_id));

call set_workout_id ('vit', '20170904');

/* split */
insert into `workout_type` (`wtype`) value ('split');

insert into `exercise` (`description`, `weight_kg`, `reps`, `rest_time_sec`, `set_number`, `workout_id`)
  values
('Жим стоячи', 9, 25, 90, 1, (select @workout_id)),
('Жим стоячи', 9, 25, 120, 2, (select @workout_id)),
('Жим стоячи', 9, 15, 120, 3, (select @workout_id)),
('Станова тяга', 21, 20, 120, 1, (select @workout_id)),
('Станова тяга', 21, 20, 120, 2, (select @workout_id)),
('Згинання рук стоячи', 9, 11, 120, 1, (select @workout_id)),
('Згинання рук стоячи', 9, 10, 120, 2, (select @workout_id)),
('Згинання рук стоячи', 9, 10, 120, 3, (select @workout_id)),
('Жим лежачи', 21, 16, 120, 1, (select @workout_id)),
('Жим лежачи', 21, 10, 120, 2, (select @workout_id)),
('Шраги', 27, 20, 90, 1, (select @workout_id)),
('Шраги', 27, 20, 90, 2, (select @workout_id)),
('Шраги', 27, 20, 90, 3, (select @workout_id)),
('Шраги', 27, 20, 120, 4, (select @workout_id)),
('Підйом на носки', 27, 15, 90, 1, (select @workout_id)),
('Підйом на носки', 27, 15, 90, 2, (select @workout_id)),
('Підйом на носки', 27, 15, 0, 3, (select @workout_id));

set @workout_id = null;

/* без екіпірування */
insert into `style` (`id`) select e.id from exercise e
  join workout w on e.workout_id = w.id
  join athlet a on w.athlet_id = a.id
where a.nickname = 'vit'
  and w.workout_date = '20170904';

/* гантелі */
insert into `equipment` (`id`) select e.id from exercise e
  join workout w on e.workout_id = w.id
  join athlet a on w.athlet_id = a.id
where a.nickname = 'vit'
  and w.workout_date = '20170904';

call calculate_workout_duration ('vit', '20170904');

call calculate_tonnage ('vit', '20170904');

set @athlet_id = null;

commit;
