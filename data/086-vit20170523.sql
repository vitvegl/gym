start transaction;

call set_athlet_id ('vit');

insert into `workout` (`workout_date`, `start_time`, `finish_time`, `athlet_id`)
  values
('20170523', '17:15', '17:56', (select @athlet_id));

call set_workout_id ('vit', '20170523');

/* split */
insert into `workout_type` (`wtype`) value ('split');

insert into `exercise` (`description`, `weight_kg`, `reps`, `rest_time_sec`, `workout_id`)
  values
('Жим сидячи', 15, 10, 90, (select @workout_id)),
('Жим сидячи', 15, 9, 120, (select @workout_id)),
('Жим сидячи', 15, 9, 60, (select @workout_id)),
('Жим сидячи', 15, 7, 60, (select @workout_id)),
('Махи у сторони', 7, 16, 90, (select @workout_id)),
('Махи у сторони', 7, 16, 90, (select @workout_id)),
('Махи у сторони', 7, 14, 90, (select @workout_id)),
('Махи у сторони', 7, 12, 90, (select @workout_id)),
('Махи вперед', 7, 10, 60, (select @workout_id)),
('Махи вперед', 7, 10, 90, (select @workout_id)),
('Махи вперед', 7, 10, 90, (select @workout_id)),
('Махи вперед', 7, 10, 90, (select @workout_id)),
('Шраги', 27, 20, 90, (select @workout_id)),
('Шраги', 27, 20, 90, (select @workout_id)),
('Шраги', 27, 20, 90, (select @workout_id));

set @workout_id = null;

/* без екіпірування */
insert into `style` (`id`) select e.id from exercise e
  join workout w on e.workout_id = w.id
  join athlet a on w.athlet_id = a.id
where a.nickname = 'vit'
  and w.workout_date = '20170523';

/* гантелі */
insert into `equipment` (`id`) select e.id from exercise e
  join workout w on e.workout_id = w.id
  join athlet a on w.athlet_id = a.id
where a.nickname = 'vit'
  and w.workout_date = '20170523';

call calculate_workout_duration ('vit', '20170523');
call calculate_tonnage ('vit', '20170523');

set @athlet_id = null;

commit;
