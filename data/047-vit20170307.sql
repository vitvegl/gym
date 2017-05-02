start transaction;

call set_athlet_id ('vit');

insert into `workout` (`workout_date`, `workout_duration`, `athlet_id`)
  values
('20170307', '00:46', (select @athlet_id));

call set_workout_id ('vit', '20170307');

/* split */
insert into `workout_type` (`wtype`) value ('split');

insert into `exercise` (`description`, `weight_kg`, `reps`, `rest_time_sec`, `workout_id`)
  values
('Станова тяга', 33, 15, 120, (select @workout_id)),
('Станова тяга', 33, 15, 120, (select @workout_id)),
('Станова тяга', 33, 9, 120, (select @workout_id)),
('Пулл-овер стоячи', 19, 15, 120, (select @workout_id)),
('Пулл-овер стоячи', 19, 12, 120, (select @workout_id)),
('Пулл-овер стоячи', 19, 10, 120, (select @workout_id)),
('Тяга 1 рукою у нахилі', 23, 14, 120, (select @workout_id)),
('Тяга 1 рукою у нахилі', 23, 14, 120, (select @workout_id)),
('Віджимання від підлоги', 0, 10, 90, (select @workout_id)),
('Віджимання від підлоги', 0, 10, 90, (select @workout_id)),
('Віджимання від підлоги', 0, 10, 90, (select @workout_id));

set @workout_id = null;

create view exercise_id as select e.id from exercise e
  join workout w on e.workout_id = w.id
  join athlet a on w.athlet_id = a.id
where a.nickname = 'vit'
  and w.workout_date = '20170307';

/* без екіпірування */
insert into `style` (`id`) select id from exercise_id;

/* гантелі */
insert into `equipment` (`id`) select id from exercise_id;

call update_exercise_if_no_weight ('vit', '20170307');

drop view exercise_id;

commit;