start transaction;

call set_athlet_id ('vit');

insert into `workout` (`workout_date`, `workout_duration`, `athlet_id`)
  values
('2016-12-12', null, (select @athlet_id));

call set_workout_id ('vit', '2016-12-12');

/* split */
insert into `workout_type` (`wtype`) values ('split');

insert into `exercise` (`description`, `weight_kg`, `reps`, `rest_time_sec`, `set_number`, `workout_id`)
  values
('Станова тяга', 33, 9, 120, 1, (select @workout_id)),
('Станова тяга', 33, 9, 120, 2, (select @workout_id)),
('Станова тяга', 33, 9, 120, 3, (select @workout_id)),
('Махи у сторони', 6.2, 10, 120, 1, (select @workout_id)),
('Махи у сторони', 6.2, 10, 120, 2, (select @workout_id)),
('Махи у сторони', 6.2, 10, 120, 3, (select @workout_id)),
('Махи у сторони', 6.2, 10, 120, 4, (select @workout_id)),
('Тяга 1 рукою у нахилі', 23, 10, 120, 1, (select @workout_id)),
('Тяга 1 рукою у нахилі', 23, 10, 120, 2, (select @workout_id)),
('Тяга 1 рукою у нахилі', 23, 10, 120, 3, (select @workout_id)),
('Розведення рук лежачи', 11, 10, 120, 1, (select @workout_id)),
('Розведення рук лежачи', 11, 10, 120, 2, (select @workout_id)),
('Розведення рук лежачи', 11, 10, 120, 3, (select @workout_id)),
('Розведення рук лежачи', 11, 10, 120, 4, (select @workout_id)),
('Жим сидячи', 11, 10, 120, 1, (select @workout_id)),
('Жим сидячи', 11, 10, 120, 2, (select @workout_id)),
('Жим сидячи', 11, 10, 120, 3, (select @workout_id)),
('Жим сидячи', 11, 8, 120, 4, (select @workout_id)),
('Махи вперед', 5.5, 10, 120, 1, (select @workout_id)),
('Махи вперед', 5.5, 10, 120, 2, (select @workout_id)),
('Махи вперед', 5.5, 10, 120, 3, (select @workout_id)),
('Махи вперед', 5.5, 10, 120, 4, (select @workout_id)),
('Махи вперед', 5.5, 8, 0, 5, (select @workout_id));

set @workout_id = null;

/* без екіпірування */
insert into `style` (`id`) select e.id from exercise e
  join workout w on e.workout_id = w.id
  join athlet a on w.athlet_id = a.id
where a.nickname = 'vit' and w.workout_date = '2016-12-12';

/* гантелі */
insert into `equipment` (`id`) select e.id from exercise e
  join workout w on e.workout_id = w.id
  join athlet a on w.athlet_id = a.id
where a.nickname = 'vit' and w.workout_date = '2016-12-12';

call calculate_tonnage ('vit', '2016-12-12');

set @athlet_id = null;

commit;
