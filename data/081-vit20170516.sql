start transaction;

call set_athlet_id ('vit');

insert into `workout` (`workout_date`, `start_time`, `finish_time`, `athlet_id`)
  values
('20170516', '22:27', '23:15', (select @athlet_id));

call set_workout_id ('vit', '20170516');

/* split */
insert into `workout_type` (`wtype`) value ('split');

insert into `exercise` (`description`, `weight_kg`, `reps`, `rest_time_sec`, `workout_id`)
  values
('Пулл-овер стоячи', 21, 20, 120, (select @workout_id)),
('Пулл-овер стоячи', 21, 16, 120, (select @workout_id)),
('Пулл-овер стоячи', 21, 14, 120, (select @workout_id)),
('Пулл-овер стоячи', 21, 12, 120, (select @workout_id)),
('Французький жим лежачи', 9, 12, 90, (select @workout_id)),
('Французький жим лежачи', 9, 12, 90, (select @workout_id)),
('Французький жим лежачи', 9, 12, 90, (select @workout_id)),
('Французький жим лежачи', 9, 12, 90, (select @workout_id)),
('Шраги', 27, 20, 120, (select @workout_id)),
('Шраги', 27, 20, 120, (select @workout_id)),
('Шраги', 27, 20, 120, (select @workout_id));

set @workout_id = null;

/* без екіпірування */
insert into `style` (`id`) select e.id from exercise e
  join workout w on e.workout_id = w.id
  join athlet a on w.athlet_id = a.id
where a.nickname = 'vit'
  and w.workout_date = '20170516';

/* гантелі */
insert into `equipment` (`id`) select e.id from exercise e
  join workout w on e.workout_id = w.id
  join athlet a on w.athlet_id = a.id
where a.nickname = 'vit'
  and w.workout_date = '20170516';

commit;
