start transaction;

call set_athlet_id ('vit');

insert into `workout` (`workout_date`, `start_time`, `finish_time`, `athlet_id`)
  values
('20170511', '18:20', '19:14', (select @athlet_id));

call set_workout_id ('vit', '20170511');

/* split */
insert into `workout_type` (`wtype`) value ('split');

insert into `exercise` (`description`, `weight_kg`, `reps`, `rest_time_sec`, `workout_id`)
  values
('Станова тяга', 33, 12, 120, (select @workout_id)),
('Станова тяга', 33, 12, 120, (select @workout_id)),
('Станова тяга', 33, 12, 120, (select @workout_id)),
('Махи у сторони', 7, 16, 120, (select @workout_id)),
('Махи у сторони', 7, 12, 120, (select @workout_id)),
('Махи у сторони', 7, 12, 120, (select @workout_id)),
('Тяга 1 рукою у нахилі', 25, 10, 120, (select @workout_id)),
('Тяга 1 рукою у нахилі', 25, 10, 120, (select @workout_id)),
('Жим сидячи', 15, 11, 120, (select @workout_id)),
('Жим сидячи', 15, 8, 120, (select @workout_id)),
('Махи вперед', 7, 10, 90, (select @workout_id)),
('Махи вперед', 7, 10, 90, (select @workout_id)),
('Махи вперед', 7, 10, 90, (select @workout_id));

set @workout_id = null;

/* без екіпірування */
insert into `style` (`id`) select e.id from exercise e
  join workout w on e.workout_id = w.id
  join athlet a on w.athlet_id = a.id
where a.nickname = 'vit'
  and w.workout_date = '20170511';

/* гантелі */
insert into `equipment` (`id`) select e.id from exercise e
  join workout w on e.workout_id = w.id
  join athlet a on w.athlet_id = a.id
where a.nickname = 'vit'
  and w.workout_date = '20170511';

commit;
