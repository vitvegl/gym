start transaction;

call set_athlet_id ('vit');

insert into `workout` (`workout_date`, `workout_duration`, `athlet_id`)
  values
('20170319', '00:45', (select @athlet_id));

call set_workout_id ('vit', '20170319');

/* split */
insert into `workout_type` (`wtype`) value ('split');

insert into `exercise` (`description`, `weight_kg`, `reps`, `rest_time_sec`, `workout_id`)
  values
('Жим лежачи', 40, 10, 120, (select @workout_id)),
('Жим лежачи', 40, 10, 120, (select @workout_id)),
('Жим лежачи', 50, 8, 120, (select @workout_id)),
('Жим лежачи', 50, 7, 120, (select @workout_id)),
('Жим лежачи', 50, 4, 120, (select @workout_id)),
('Жим лежачи', 55, 1, 120, (select @workout_id)),
('Станова тяга', 50, 8, 90, (select @workout_id)),
('Станова тяга', 70, 6, 90, (select @workout_id)),
('Станова тяга', 80, 6, 120, (select @workout_id)),
('Станова тяга', 90, 5, 120, (select @workout_id)),
('Станова тяга', 100, 1, 120, (select @workout_id));

set @workout_id = null;

create view exercise_id as select e.id from exercise e
  join workout w on e.workout_id = w.id
  join athlet a on w.athlet_id = a.id
where a.nickname = 'vit'
  and w.workout_date = '20170319';

/* без екіпірування */
insert into `style` (`id`) select id from exercise_id;

/* штанга */
insert into `equipment` (`id`, `equipment`) select id, 'штанга' from exercise_id;

drop view exercise_id;

commit;
