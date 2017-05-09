start transaction;

call set_athlet_id ('vit');

insert into `workout` (`workout_date`, `athlet_id`)
  values
('2016-11-23', (select @athlet_id));

call set_workout_id ('vit', '2016-11-23');

/* fullbody */
insert into `workout_type` (`wtype`) values ('fullbody');

insert into `exercise` (`description`, `weight_kg`, `reps`, `rest_time_sec`, `workout_id`)
  values
('Жим лежачи', 19.5, 10, 120, (select @workout_id)),
('Жим лежачи', 19.5, 10, 120, (select @workout_id)),
('Жим лежачи', 19.5, 11, 120, (select @workout_id)),
('Легкі присідання', 21, 8, 120, (select @workout_id)),
('Легкі присідання', 21, 8, 120, (select @workout_id)),
('Легкі присідання', 21, 8, 120, (select @workout_id)),
('Станова тяга', 30, 10, 120, (select @workout_id)),
('Станова тяга', 30, 10, 120, (select @workout_id)),
('Станова тяга', 30, 10, 120, (select @workout_id)),
('Тяга 1 рукою у нахилі', 21, 10, 120, (select @workout_id)),
('Тяга 1 рукою у нахилі', 21, 10, 120, (select @workout_id)),
('Тяга 1 рукою у нахилі', 21, 10, 120, (select @workout_id)),
('Махи у сторони', 6.2, 10, 120, (select @workout_id)),
('Махи у сторони', 6.2, 10, 120, (select @workout_id)),
('Махи у сторони', 6.2, 10, 120, (select @workout_id)),
('Концентрований підйом на біцепс', 9, 10, 120, (select @workout_id)),
('Концентрований підйом на біцепс', 9, 10, 120, (select @workout_id)),
('Концентрований підйом на біцепс', 9, 10, 120, (select @workout_id)),
('Згинання рук стоячи', 8.2, 8, 120, (select @workout_id)),
('Згинання рук стоячи', 8.2, 8, 120, (select @workout_id)),
('Згинання рук стоячи', 8.2, 7, 120, (select @workout_id)),
('Розведення рук лежачи', 7, 10, 120, (select @workout_id)),
('Розведення рук лежачи', 7, 10, 120, (select @workout_id)),
('Розведення рук лежачи', 7, 10, 120, (select @workout_id)),
('Жим сидячи', 11, 10, 120, (select @workout_id)),
('Жим сидячи', 11, 10, 120, (select @workout_id)),
('Жим сидячи', 11, 10, 120, (select @workout_id)),
('Пулл-овер стоячи', 13, 10, 120, (select @workout_id)),
('Пулл-овер стоячи', 13, 10, 120, (select @workout_id)),
('Пулл-овер стоячи', 13, 10, 120, (select @workout_id)),
('Махи вперед', 5, 10, 120, (select @workout_id)),
('Махи вперед', 5, 10, 120, (select @workout_id)),
('Махи вперед', 5, 8, 120, (select @workout_id)),
('Хаммер', 9, 8, 120, (select @workout_id)),
('Хаммер', 9, 7, 120, (select @workout_id)),
('Хаммер', 9, 7, 120, (select @workout_id)),
('Віджимання від підлоги', 0, 15, 120, (select @workout_id)),
('Віджимання від підлоги', 0, 11, 120, (select @workout_id)),
('Віджимання від підлоги', 0, 11, 120, (select @workout_id));

set @workout_id = null;

/* без екіпірування */
insert into `style` (`id`) select e.id from exercise e
  join workout w on e.workout_id = w.id
  join athlet a on w.athlet_id = a.id 
where a.nickname = 'vit' and w.workout_date = '2016-11-23';

/* гантелі */
insert into `equipment` (`id`) select e.id from exercise e
  join workout w on e.workout_id = w.id
  join athlet a on w.athlet_id = a.id 
where a.nickname = 'vit' and w.workout_date = '2016-11-23';

/* вправи із вагою тіла */
call update_exercise_if_no_weight ('vit', '2016-11-23');

commit;
