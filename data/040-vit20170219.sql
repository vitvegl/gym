start transaction;

call set_athlet_id ('vit');

insert into `workout` (`workout_date`, `workout_duration`, `athlet_id`)
  values
('2017-02-19', null, (select @athlet_id));

call set_workout_id ('vit', '2017-02-19');

/* split */
insert into `workout_type` (`wtype`) value ('split');

insert into `exercise` (`description`, `weight_kg`, `reps`, `rest_time_sec`, `workout_id`)
  values
('Жим лежачи', 40, 14, 120, (select @workout_id)),
('Жим лежачи', 40, 12, 120, (select @workout_id)),
('Жим лежачи', 40, 10, 120, (select @workout_id)),
('Жим лежачи', 40, 12, 120, (select @workout_id)),
('Жим лежачи', 50, 3, 120, (select @workout_id)),
('Присідання', 30, 16, 120, (select @workout_id)),
('Присідання', 40, 12, 120, (select @workout_id)),
('Присідання', 50, 14, 120, (select @workout_id));

set @workout_id = null;

create view exercise_id as select e.id from exercise e
  join workout w on e.workout_id = w.id
  join athlet a on w.athlet_id = a.id
where a.nickname = 'vit' and w.workout_date = '2017-02-19';

/* без екіпірування */
insert into `style` (`id`) select id from exercise_id;

/* штанга */
insert into `equipment` (`id`, `equipment`) select id, 'штанга' from exercise_id;

drop view exercise_id;

commit;
