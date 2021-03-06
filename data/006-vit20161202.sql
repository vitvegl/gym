start transaction;

call set_athlet_id ('vit');

insert into `workout` (`workout_date`, `athlet_id`)
  values
('2016-12-02', (select @athlet_id));

call set_workout_id ('vit', '2016-12-02');

/* split */
insert into `workout_type` (`wtype`) values ('split');

insert into `exercise` (`description`, `weight_kg`, `reps`, `rest_time_sec`, `set_number`, `workout_id`)
  values
('Присідання', 27, 10, 120, 1, (select @workout_id)),
('Присідання', 27, 10, 120, 2, (select @workout_id)),
('Присідання', 27, 10, 120, 3, (select @workout_id)),
('Концентрований підйом на біцепс', 9, 10, 120, 1, (select @workout_id)),
('Концентрований підйом на біцепс', 9, 10, 120, 2, (select @workout_id)),
('Концентрований підйом на біцепс', 9, 10, 120, 3, (select @workout_id)),
('Статичні випади вперед', 9, 8, 90, 1, (select @workout_id)),
('Статичні випади вперед', 9, 8, 90, 2, (select @workout_id)),
('Статичні випади вперед', 9, 8, 90, 3, (select @workout_id)),
('Хаммер', 9, 10, 120, 1, (select @workout_id)),
('Хаммер', 9, 10, 120, 2, (select @workout_id)),
('Хаммер', 9, 10, 120, 3, (select @workout_id)),
('Згинання рук стоячи', 9, 10, 120, 1, (select @workout_id)),
('Згинання рук стоячи', 9, 10, 120, 2, (select @workout_id)),
('Згинання рук стоячи', 9, 10, 0, 3, (select @workout_id));

set @workout_id = null;

/* без екіпірування */
insert into `style` (`id`) select e.id from exercise e
  join workout w on e.workout_id = w.id
  join athlet a on w.athlet_id = a.id
where a.nickname = 'vit' and w.workout_date = '2016-12-02';

/* гантелі */
insert into `equipment` (`id`) select e.id from exercise e
  join workout w on e.workout_id = w.id
  join athlet a on w.athlet_id = a.id
where a.nickname = 'vit' and w.workout_date = '2016-12-02';

call calculate_tonnage ('vit', '2016-12-02');

set @athlet_id = null;

commit;
