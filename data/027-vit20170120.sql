start transaction;

call set_athlet_id ('vit');

insert into `workout` (`workout_date`, `workout_duration`, `athlet_id`)
  values
('2017-01-20', '1:02', (select @athlet_id));

call set_workout_id ('vit', '2017-01-20');

/* split */
insert into `workout_type` (`wtype`) value ('split');

insert into `exercise` (`description`, `weight_kg`, `reps`, `rest_time_sec`, `workout_id`)
  values
('Присідання', 30, 12, 120, (select @workout_id)),
('Присідання', 30, 13, 120, (select @workout_id)),
('Присідання', 30, 12, 120, (select @workout_id)),
('Присідання', 30, 12, 120, (select @workout_id)),
('Концентрований підйом на біцепс сидячи', 9, 10, 120, (select @workout_id)),
('Концентрований підйом на біцепс сидячи', 9, 10, 120, (select @workout_id)),
('Концентрований підйом на біцепс сидячи', 9, 8, 120, (select @workout_id)),
('Статичні випади вперед', 15, 8, 120, (select @workout_id)),
('Статичні випади вперед', 15, 8, 120, (select @workout_id)),
('Статичні випади вперед', 15, 6, 120, (select @workout_id)),
('Хаммер', 11, 10, 120, (select @workout_id)),
('Хаммер', 11, 8, 120, (select @workout_id)),
('Хаммер', 11, 6, 120, (select @workout_id)),
('Згинання рук стоячи', 9, 8, 120, (select @workout_id)),
('Згинання рук стоячи', 9, 8, 120, (select @workout_id)),
('Згинання рук стоячи', 9, 5, 120, (select @workout_id));

set @workout_id = null;

create view exercise_id as select e.id from exercise e
  join workout w on e.workout_id = w.id
  join athlet a on w.athlet_id = a.id
where a.nickname = 'vit' and w.workout_date = '2017-01-20';

/* без екіпірування */
insert into `style` (`id`) select id from exercise_id;

/* гантелі */
insert into `equipment` (`id`) select id from exercise_id;

drop view exercise_id;

commit;
