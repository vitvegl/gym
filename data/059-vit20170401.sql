start transaction;

call set_athlet_id ('vit');

insert into `workout` (`workout_date`, `workout_duration`, `athlet_id`)
  values
('20170401', '0:30', (select @athlet_id));

call set_workout_id ('vit', '20170401');

/* split */
insert into `workout_type` (`wtype`) value ('split');

insert into `exercise` (`description`, `weight_kg`, `reps`, `rest_time_sec`, `workout_id`)
  values
('Станова тяга', 21, 16, 120, (select @workout_id)),
('Станова тяга', 21, 16, 120, (select @workout_id)),
('Станова тяга', 21, 16, 120, (select @workout_id)),
('Станова тяга', 21, 16, 120, (select @workout_id)),
('Станова тяга', 21, 16, 120, (select @workout_id)),
('Пулл-овер сидячи', 21, 12, 120, (select @workout_id)),
('Пулл-овер сидячи', 21, 12, 120, (select @workout_id)),
('Пулл-овер сидячи', 21, 11, 120, (select @workout_id)),
('Тяга 1 рукою у нахилі', 21, 16, 120, (select @workout_id)),
('Тяга 1 рукою у нахилі', 21, 16, 120, (select @workout_id)),
('Тяга 1 рукою у нахилі', 21, 16, 120, (select @workout_id)),
('Французький жим лежачи', 9, 16, 90, (select @workout_id)),
('Французький жим лежачи', 9, 16, 90, (select @workout_id)),
('Французький жим лежачи', 9, 13, 90, (select @workout_id)),
('Віджимання у нахилі в положенні рук за спиною', 0, 10, 90, (select @workout_id)),
('Віджимання у нахилі в положенні рук за спиною', 0, 10, 90, (select @workout_id)),
('Віджимання у нахилі в положенні рук за спиною', 0, 10, 90, (select @workout_id));

set @workout_id = null;

create view exercise_id as select e.id from exercise e
  join workout w on e.workout_id = w.id
  join athlet a on w.athlet_id = a.id
where a.nickname = 'vit'
  and w.workout_date = '20170401';

/* без екіпірування */
insert into `style` (`id`) select id from exercise_id;

/* гантелі */
insert into `equipment` (`id`) select id from exercise_id;

call update_exercise_if_no_weight ('vit', '20170401');

drop view exercise_id;

commit;
