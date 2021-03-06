start transaction;

call set_athlet_id ('vit');

insert into `workout` (`workout_date`, `workout_duration`, `athlet_id`)
  values
('20170505', '00:44', (select @athlet_id));

call set_workout_id ('vit', '20170505');

/* split */
insert into `workout_type` (`wtype`) value ('split');

insert into `exercise` (`description`, `weight_kg`, `reps`, `rest_time_sec`, `workout_id`)
  values
('Жим лежачи', 25, 10, 120, (select @workout_id)),
('Жим лежачи', 25, 8, 120, (select @workout_id)),
('Жим лежачи', 27, 0, 120, (select @workout_id)),
('Шраги', 27, 20, 120, (select @workout_id)),
('Шраги', 27, 20, 120, (select @workout_id)),
('Шраги', 27, 20, 120, (select @workout_id)),
('Згинання рук стоячи', 9, 12, 120, (select @workout_id)),
('Згинання рук стоячи', 9, 12, 120, (select @workout_id)),
('Згинання рук стоячи', 9, 12, 120, (select @workout_id)),
('Хаммер', 9, 10, 120, (select @workout_id)),
('Хаммер', 9, 10, 120, (select @workout_id)),
('Хаммер', 9, 8, 120, (select @workout_id)),
('Станова тяга', 21, 16, 90, (select @workout_id)),
('Станова тяга', 21, 16, 90, (select @workout_id));

set @workout_id = null;

/* без екіпірування */
insert into `style` (`id`) select e.id from exercise e
  join workout w on e.workout_id = w.id
  join athlet a on w.athlet_id = a.id
where a.nickname = 'vit'
  and w.workout_date = '20170505';

/* гантелі */
insert into `equipment` (`id`) select e.id from exercise e
  join workout w on e.workout_id = w.id
  join athlet a on w.athlet_id = a.id
where a.nickname = 'vit'
  and w.workout_date = '20170505';

commit;
