start transaction;

call set_athlet_id ('vit');

insert into `workout` (`workout_date`, `start_time`, `finish_time`, `athlet_id`)
  values
('20170905', '2017-09-05 16:00', '2017-09-05 17:12', (select @athlet_id));

call set_workout_id ('vit', '20170905');

/* fullbody */
insert into `workout_type` (`wtype`) value ('fullbody');

insert into `exercise` (`description`, `weight_kg`, `reps`, `rest_time_sec`, `set_number`, `workout_id`)
  values
('Жим лежачи', 25, 10, 180, 1, (select @workout_id)),
('Жим лежачи', 25, 8, 180, 2, (select @workout_id)),
('Розведення рук лежачи', 13, 20, 180, 1, (select @workout_id)),
('Розведення рук лежачи', 13, 20, 180, 2, (select @workout_id)),
('Розведення рук лежачи', 13, 15, 120, 3, (select @workout_id)),
('Тяга 1 рукою у нахилі', 33, 10, 120, 1, (select @workout_id)),
('Тяга 1 рукою у нахилі', 33, 10, 120, 2, (select @workout_id)),
('Шраги', 30, 17, 120, 1, (select @workout_id)),
('Шраги', 30, 17, 120, 2, (select @workout_id)),
('Шраги', 30, 17, 120, 3, (select @workout_id)),
('Підйом на носки', 27, 15, 120, 1, (select @workout_id)),
('Підйом на носки', 27, 15, 120, 2, (select @workout_id)),
('Підйом на носки', 27, 15, 120, 3, (select @workout_id)),
('Підйом на носки', 27, 15, 120, 4, (select @workout_id)),
('Пулл-овер стоячи', 27, 10, 120, 1, (select @workout_id)),
('Пулл-овер стоячи', 27, 8, 0, 2, (select @workout_id));

set @workout_id = null;

/* без екіпірування */
insert into `style` (`id`) select e.id from exercise e
  join workout w on e.workout_id = w.id
  join athlet a on w.athlet_id = a.id
where a.nickname = 'vit'
  and w.workout_date = '20170905';

/* гантелі */
insert into `equipment` (`id`) select e.id from exercise e
  join workout w on e.workout_id = w.id
  join athlet a on w.athlet_id = a.id
where a.nickname = 'vit'
  and w.workout_date = '20170905';

call calculate_workout_duration ('vit', '20170905');

call update_exercise_set_equipment ('vit', '20170905', 'гантель', 'Пулл-овер стоячи');

call calculate_tonnage ('vit', '20170905');

set @athlet_id = null;

commit;
