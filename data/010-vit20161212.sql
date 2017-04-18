start transaction;

call set_athlet_id ('vit');

insert into `workout` (`workout_date`, `workout_duration`, `athlet_id`)
  values
('2016-12-12', null, (select @athlet_id));

call set_workout_id ('vit', '2016-12-12');

/* split */
insert into `workout_type` (`type`) values ('split');

insert into `exercise` (`description`, `weight_kg`, `reps`, `rest_time_sec`, `workout_id`)
  values
('Станова тяга', 33, 9, 120, (select @workout_id)),
('Станова тяга', 33, 9, 120, (select @workout_id)),
('Станова тяга', 33, 9, 120, (select @workout_id)),
('Махи у сторони', 6.2, 10, 120, (select @workout_id)),
('Махи у сторони', 6.2, 10, 120, (select @workout_id)),
('Махи у сторони', 6.2, 10, 120, (select @workout_id)),
('Махи у сторони', 6.2, 10, 120, (select @workout_id)),
('Тяга 1 рукою у нахилі', 23, 10, 120, (select @workout_id)),
('Тяга 1 рукою у нахилі', 23, 10, 120, (select @workout_id)),
('Тяга 1 рукою у нахилі', 23, 10, 120, (select @workout_id)),
('Розведення рук лежачи', 11, 10, 120, (select @workout_id)),
('Розведення рук лежачи', 11, 10, 120, (select @workout_id)),
('Розведення рук лежачи', 11, 10, 120, (select @workout_id)),
('Розведення рук лежачи', 11, 10, 120, (select @workout_id)),
('Жим сидячи', 11, 10, 120, (select @workout_id)),
('Жим сидячи', 11, 10, 120, (select @workout_id)),
('Жим сидячи', 11, 10, 120, (select @workout_id)),
('Жим сидячи', 11, 8, 120, (select @workout_id)),
('Махи вперед', 5.5, 10, 120, (select @workout_id)),
('Махи вперед', 5.5, 10, 120, (select @workout_id)),
('Махи вперед', 5.5, 10, 120, (select @workout_id)),
('Махи вперед', 5.5, 10, 120, (select @workout_id)),
('Махи вперед', 5.5, 8, 120, (select @workout_id));

set @workout_id = null;

create view exercise_id as select e.id from exercise e
  join workout w on e.workout_id = w.id
  join athlet a on w.athlet_id = a.id
where a.nickname = 'vit' and w.workout_date = '2016-12-12';

/* без екіпірування */
insert into `style` (`id`) select id from exercise_id;

/* гантелі */
insert into `equipment` (`id`) select id from exercise_id;

drop view exercise_id;

commit;
