start transaction;

call set_athlet_id ('vit');

insert into `workout` (`workout_date`, `workout_duration`, `athlet_id`)
  values
('2017-01-16', '0:55', (select @athlet_id));

call set_workout_id ('vit', '2017-01-16');

/* split */
insert into `workout_type` (`wtype`) value ('split');

insert into `exercise` (`description`, `weight_kg`, `reps`, `rest_time_sec`, `workout_id`)
  values
('Станова тяга', 33, 11, 120, (select @workout_id)),
('Станова тяга', 33, 10, 120, (select @workout_id)),
('Станова тяга', 33, 10, 120, (select @workout_id)),
('Махи у сторони', 7, 10, 120, (select @workout_id)),
('Махи у сторони', 7, 10, 120, (select @workout_id)),
('Махи у сторони', 7, 9, 120, (select @workout_id)),
('Махи у сторони', 7, 10, 120, (select @workout_id)),
('Махи у сторони', 7, 10, 120, (select @workout_id)),
('Тяга 1 рукою у нахилі', 23, 12, 120, (select @workout_id)),
('Тяга 1 рукою у нахилі', 23, 12, 120, (select @workout_id)),
('Тяга 1 рукою у нахилі', 23, 12, 120, (select @workout_id)),
('Жим сидячи', 13, 9, 120, (select @workout_id)),
('Жим сидячи', 13, 9, 120, (select @workout_id)),
('Жим сидячи', 13, 9, 120, (select @workout_id)),
('Махи вперед', 5.5, 10, 90, (select @workout_id)),
('Махи вперед', 5.5, 10, 90, (select @workout_id)),
('Махи вперед', 5.5, 9, 90, (select @workout_id)),
('Махи вперед', 5.5, 9, 90, (select @workout_id));

set @workout_id = null;

/* без екіпірування */
insert into `style` (`id`) select e.id from exercise e
  join workout w on e.workout_id = w.id
  join athlet a on w.athlet_id = a.id
where a.nickname = 'vit' and w.workout_date = '2017-01-16';

/* гантелі */
insert into `equipment` (`id`) select e.id from exercise e
  join workout w on e.workout_id = w.id
  join athlet a on w.athlet_id = a.id
where a.nickname = 'vit' and w.workout_date = '2017-01-16';

commit;
