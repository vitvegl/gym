start transaction;

call set_athlet_id ('vit');

insert into `workout` (`workout_date`, `athlet_id`)
  values
('2016-12-02', (select @athlet_id));

call set_workout_id ('vit', '2016-12-02');

/* split */
insert into `workout_type` (`type`) values ('split');

insert into `exercise` (`description`, `weight_kg`, `reps`, `rest_time_sec`, `workout_id`)
  values
('Присідання', 27, 10, 120, (select @workout_id)),
('Присідання', 27, 10, 120, (select @workout_id)),
('Присідання', 27, 10, 120, (select @workout_id)),
('Концентрований підйом на біцепс', 9, 10, 120, (select @workout_id)),
('Концентрований підйом на біцепс', 9, 10, 120, (select @workout_id)),
('Концентрований підйом на біцепс', 9, 10, 120, (select @workout_id)),
('Статичні випади вперед', 9, 8, 90, (select @workout_id)),
('Статичні випади вперед', 9, 8, 90, (select @workout_id)),
('Статичні випади вперед', 9, 8, 90, (select @workout_id)),
('Хаммер', 9, 10, 120, (select @workout_id)),
('Хаммер', 9, 10, 120, (select @workout_id)),
('Хаммер', 9, 10, 120, (select @workout_id)),
('Згинання рук стоячи', 9, 10, 120, (select @workout_id)),
('Згинання рук стоячи', 9, 10, 120, (select @workout_id)),
('Згинання рук стоячи', 9, 10, 120, (select @workout_id));

set @workout_id = null;

create view exercise_id as select e.id from exercise e
  join workout w on e.workout_id = w.id
  join athlet a on w.athlet_id = a.id
where a.nickname = 'vit' and w.workout_date = '2016-12-02';

/* без екіпірування */
insert into `style` (`id`) select id from exercise_id;

/* гантелі */
insert into `equipment` (`id`) select id from exercise_id;

drop view exercise_id;

commit;