start transaction;

call set_athlet_id ('vit');

insert into `workout` (`workout_date`, `workout_duration`, `athlet_id`)
  values
('20170417', '1:09', (select @athlet_id));

call set_workout_id ('vit', '20170417');

/* split */
insert into `workout_type` (`wtype`) value ('split');

insert into `exercise` (`description`, `weight_kg`, `reps`, `rest_time_sec`, `workout_id`)
  values
('Присідання', 21, 14, 120, (select @workout_id)),
('Присідання', 21, 14, 120, (select @workout_id)),
('Присідання', 21, 14, 120, (select @workout_id)),
('Жим сидячи', 15, 13, 120, (select @workout_id)),
('Жим сидячи', 15, 10, 120, (select @workout_id)),
('Жим сидячи', 15, 9, 120, (select @workout_id)),
('Махи у сторони', 7, 16, 120, (select @workout_id)),
('Махи у сторони', 7, 15, 120, (select @workout_id)),
('Махи у сторони', 7, 13, 120, (select @workout_id)),
('Махи вперед', 7, 11, 90, (select @workout_id)),
('Махи вперед', 7, 10, 90, (select @workout_id)),
('Махи вперед', 7, 10, 90, (select @workout_id)),
('Махи вперед', 7, 10, 90, (select @workout_id));

set @workout_id = null;

create view exercise_id as select e.id from exercise e
  join workout w on e.workout_id = w.id
  join athlet a on w.athlet_id = a.id
where a.nickname = 'vit'
  and w.workout_date = '20170417';

/* без екіпірування */
insert into `style` (`id`) select id from exercise_id;

/* гантелі */
insert into `equipment` (`id`) select id from exercise_id;

drop view exercise_id;

commit;
