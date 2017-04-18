start transaction;

call set_athlet_id ('vit');

insert into `workout` (`workout_date`, `workout_duration`, `athlet_id`)
  values
('2016-12-30', '0:53', (select @athlet_id));

call set_workout_id ('vit', '2016-12-30');

/* split */
insert into `workout_type` (`type`) values ('split');

insert into `exercise` (`description`, `weight_kg`, `reps`, `rest_time_sec`, `workout_id`)
  values
('Присідання', 30, 10, 180, (select @workout_id)),
('Присідання', 30, 10, 180, (select @workout_id)),
('Присідання', 30, 10, 180, (select @workout_id)),
('Концентрований підйом на біцепс', 9, 10, 120, (select @workout_id)),
('Концентрований підйом на біцепс', 9, 9, 120, (select @workout_id)),
('Концентрований підйом на біцепс', 9, 8, 120, (select @workout_id)),
('Статичні випади вперед', 13, 8, 120, (select @workout_id)),
('Статичні випади вперед', 13, 6, 120, (select @workout_id)),
('Статичні випади вперед', 13, 6, 120, (select @workout_id)),
('Згинання рук стоячи', 9, 8, 120, (select @workout_id)),
('Згинання рук стоячи', 9, 6, 120, (select @workout_id)),
('Згинання рук стоячи', 9, 6, 120, (select @workout_id)),
('Згинання рук стоячи', 9, 4, 120, (select @workout_id));

set @workout_id = null;

create view exercise_id as select e.id from exercise e
  join workout w on e.workout_id = w.id
  join athlet a on w.athlet_id = a.id
where a.nickname = 'vit' and w.workout_date = '2016-12-30';

/* без екіпірування */
insert into `style` (`id`) select id from exercise_id;

/* гантелі */
insert into `equipment` (`id`) select id from exercise_id;

drop view exercise_id;

commit;
