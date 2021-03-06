start transaction;

call set_athlet_id ('vit');

insert into `workout` (`workout_date`, `workout_duration`, `athlet_id`)
  values
('20170327', null, (select @athlet_id));

call set_workout_id ('vit', '20170327');

/* split */
insert into `workout_type` (`wtype`) value ('split');

insert into `exercise` (`description`, `weight_kg`, `reps`, `rest_time_sec`, `workout_id`)
  values
('Жим лежачи', 25, 10, 120, (select @workout_id)),
('Жим лежачи', 25, 8, 120, (select @workout_id)),
('Жим лежачи', 25, 7, 120, (select @workout_id)),
('Концентрований підйом на біцепс сидячи', 9, 14, 120, (select @workout_id)),
('Концентрований підйом на біцепс сидячи', 9, 10, 120, (select @workout_id)),
('Концентрований підйом на біцепс сидячи', 9, 7, 120, (select @workout_id)),
('Розведення рук лежачи', 13, 20, 90, (select @workout_id)),
('Розведення рук лежачи', 13, 17, 90, (select @workout_id)),
('Розведення рук лежачи', 13, 16, 90, (select @workout_id)),
('Згинання рук стоячи', 9, 14, 30, (select @workout_id)),
('Згинання рук стоячи', 9, 8, 30, (select @workout_id)),
('Хаммер', 9, 7, 30, (select @workout_id)),
('Хаммер', 9, 6, 30, (select @workout_id)),
('Шраги', 25, 20, 90, (select @workout_id)),
('Шраги', 25, 20, 90, (select @workout_id)),
('Шраги', 25, 20, 90, (select @workout_id));

set @workout_id = null;

/* без екіпірування */
insert into `style` (`id`) select e.id from exercise e
  join workout w on e.workout_id = w.id
  join athlet a on w.athlet_id = a.id
where a.nickname = 'vit'
  and w.workout_date = '20170327';

/* гантелі */
insert into `equipment` (`id`) select e.id from exercise e
  join workout w on e.workout_id = w.id
  join athlet a on w.athlet_id = a.id
where a.nickname = 'vit'
  and w.workout_date = '20170327';

commit;
