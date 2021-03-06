start transaction;

call set_athlet_id ('vit');

insert into `workout` (`workout_date`, `athlet_id`)
  values
('2016-12-05', (select @athlet_id));

call set_workout_id ('vit', '2016-12-05');

/* split */
insert into `workout_type` (`wtype`) values ('split');

insert into `exercise` (`description`, `weight_kg`, `reps`, `rest_time_sec`, `set_number`, `workout_id`)
  values
('Станова тяга', 30, 10, 120, 1, (select @workout_id)),
('Станова тяга', 30, 10, 120, 2, (select @workout_id)),
('Станова тяга', 30, 10, 120, 3, (select @workout_id)),
('Махи у сторони', 6.2, 10, 120, 1, (select @workout_id)),
('Махи у сторони', 6.2, 10, 120, 2, (select @workout_id)),
('Махи у сторони', 6.2, 10, 120, 3, (select @workout_id)),
('Тяга 1 рукою у нахилі', 21, 10, 120, 1, (select @workout_id)),
('Тяга 1 рукою у нахилі', 21, 10, 120, 2, (select @workout_id)),
('Тяга 1 рукою у нахилі', 21, 10, 120, 3, (select @workout_id)),
('Розведення рук лежачи', 8.5, 10, 120, 1, (select @workout_id)),
('Розведення рук лежачи', 8.5, 10, 120, 2, (select @workout_id)),
('Розведення рук лежачи', 8.5, 10, 120, 3, (select @workout_id)),
('Махи вперед', 6.5, 10, 120, 1, (select @workout_id)),
('Махи вперед', 6.5, 10, 120, 2, (select @workout_id)),
('Махи вперед', 6.5, 10, 120, 3, (select @workout_id)),
('Жим сидячи', 12.5, 10, 120, 1, (select @workout_id)),
('Жим сидячи', 12.5, 10, 120, 2, (select @workout_id)),
('Жим сидячи', 12.5, 10, 0, 3, (select @workout_id));

set @workout_id = null;

/* без екіпірування */
insert into `style` (`id`) select e.id from exercise e
  join workout w on e.workout_id = w.id
  join athlet a on w.athlet_id = a.id
where a.nickname = 'vit' and w.workout_date = '2016-12-05';

/* гантелі */
insert into `equipment` (`id`) select e.id from exercise e
  join workout w on e.workout_id = w.id
  join athlet a on w.athlet_id = a.id
where a.nickname = 'vit' and w.workout_date = '2016-12-05';

call calculate_tonnage ('vit', '2016-12-05');

set @athlet_id = null;

commit;
