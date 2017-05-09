start transaction;

call set_athlet_id ('vit');

insert into `workout` (`workout_date`, `workout_duration`, `athlet_id`)
  values
('20170425', '0:39', (select @athlet_id));

call set_workout_id ('vit', '20170425');

/* split */
insert into `workout_type` (`wtype`) value ('split');

insert into `exercise` (`description`, `weight_kg`, `reps`, `rest_time_sec`, `workout_id`)
  values
('Присідання', 23, 10, 120, (select @workout_id)),
('Присідання', 23, 10, 120, (select @workout_id)),
('Присідання', 23, 10, 120, (select @workout_id)),
('Жим сидячи', 15, 13, 120, (select @workout_id)),
('Жим сидячи', 15, 11, 120, (select @workout_id)),
('Жим сидячи', 15, 10, 120, (select @workout_id)),
('Махи у сторони', 7, 16, 120, (select @workout_id)),
('Махи у сторони', 7, 16, 120, (select @workout_id)),
('Махи у сторони', 7, 13, 120, (select @workout_id)),
('Махи вперед', 7, 11, 90, (select @workout_id)),
('Махи вперед', 7, 11, 60, (select @workout_id)),
('Махи вперед', 7, 11, 60, (select @workout_id)),
('Махи вперед', 7, 11, 60, (select @workout_id)),
('Жим лежачи', 15, 30, 0, (select @workout_id));

set @workout_id = null;

/* без екіпірування */
insert into `style` (`id`) select e.id from exercise e
  join workout w on e.workout_id = w.id
  join athlet a on w.athlet_id = a.id
where a.nickname = 'vit'
  and w.workout_date = '20170425';

/* гантелі */
insert into `equipment` (`id`) select e.id from exercise e
  join workout w on e.workout_id = w.id
  join athlet a on w.athlet_id = a.id
where a.nickname = 'vit'
  and w.workout_date = '20170425';

commit;
