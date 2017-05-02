start transaction;

call set_athlet_id ('vit');

insert into `workout` (`workout_date`, `workout_duration`, `athlet_id`)
  values
('20170404', '01:05', (select @athlet_id));

call set_workout_id ('vit', '20170404');

/* split */
insert into `workout_type` (`wtype`) value ('split');

insert into `exercise` (`description`, `weight_kg`, `reps`, `rest_time_sec`, `workout_id`)
  values
('Присідання', 33, 8, 120, (select @workout_id)),
('Присідання', 33, 8, 120, (select @workout_id)),
('Присідання', 33, 8, 120, (select @workout_id)),
('Присідання', 33, 6, 120, (select @workout_id)),
('Жим сидячи', 15, 12, 120, (select @workout_id)),
('Жим сидячи', 15, 11, 120, (select @workout_id)),
('Жим сидячи', 15, 12, 120, (select @workout_id)),
('Жим сидячи', 15, 11, 120, (select @workout_id)),
('Статичні випади вперед', 15, 8, 120, (select @workout_id)),
('Статичні випади вперед', 15, 8, 120, (select @workout_id)),
('Махи у сторони', 7, 16, 120, (select @workout_id)),
('Махи у сторони', 7, 15, 120, (select @workout_id)),
('Махи у сторони', 7, 12, 120, (select @workout_id)),
('Махи вперед', 7, 11, 90, (select @workout_id)),
('Махи вперед', 7, 10, 90, (select @workout_id)),
('Махи вперед', 7, 10, 90, (select @workout_id)),
('Махи вперед', 7, 10, 90, (select @workout_id));

set @workout_id = null;

create view exercise_id as select e.id from exercise e
  join workout w on e.workout_id = w.id
  join athlet a on w.athlet_id = a.id
where a.nickname = 'vit'
  and w.workout_date = '20170404';

/* без екіпірування */
insert into `style` (`id`) select id from exercise_id;

/* гантелі */
insert into `equipment` (`id`) select id from exercise_id;

drop view exercise_id;

commit;
