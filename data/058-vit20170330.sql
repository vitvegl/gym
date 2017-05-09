start transaction;

call set_athlet_id ('vit');

insert into `workout` (`workout_date`, `workout_duration`, `athlet_id`)
  values
('20170330', '00:55', (select @athlet_id));

call set_workout_id ('vit', '20170330');

/* split */
insert into `workout_type` (`wtype`) value ('split');

insert into `exercise` (`description`, `weight_kg`, `reps`, `rest_time_sec`, `workout_id`)
  values
('Присідання', 33, 13, 120, (select @workout_id)),
('Присідання', 33, 12, 120, (select @workout_id)),
('Присідання', 33, 10, 120, (select @workout_id)),
('Жим сидячи', 15, 12, 120, (select @workout_id)),
('Жим сидячи', 15, 11, 120, (select @workout_id)),
('Жим сидячи', 15, 10, 120, (select @workout_id)),
('Жим сидячи', 15, 9, 120, (select @workout_id)),
('Статичні випади вперед', 15, 8, 120, (select @workout_id)),
('Статичні випади вперед', 15, 8, 120, (select @workout_id)),
('Статичні випади вперед', 15, 8, 120, (select @workout_id)),
('Махи у сторони', 7, 16, 90, (select @workout_id)),
('Махи у сторони', 7, 13, 90, (select @workout_id)),
('Махи у сторони', 7, 10, 90, (select @workout_id)),
('Махи вперед', 7, 10, 90, (select @workout_id)),
('Махи вперед', 7, 10, 90, (select @workout_id)),
('Махи вперед', 7, 10, 90, (select @workout_id)),
('Махи вперед', 7, 10, 90, (select @workout_id));

set @workout_id = null;

/* без екіпірування */
insert into `style` (`id`) select e.id from exercise e
  join workout w on e.workout_id = w.id
  join athlet a on w.athlet_id = a.id
where a.nickname = 'vit'
  and w.workout_date = '20170330';

/* гантелі */
insert into `equipment` (`id`) select e.id from exercise e
  join workout w on e.workout_id = w.id
  join athlet a on w.athlet_id = a.id
where a.nickname = 'vit'
  and w.workout_date = '20170330';

commit;
