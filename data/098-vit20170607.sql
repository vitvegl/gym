start transaction;

call set_athlet_id ('vit');

insert into `workout` (`workout_date`, `start_time`, `finish_time`, `athlet_id`)
  values
('20170607', '2017-06-07 22:27', '2017-06-07 23:16', (select @athlet_id));

call set_workout_id ('vit', '20170607');

/* split */
insert into `workout_type` (`wtype`) value ('split');

insert into `exercise` (`description`, `weight_kg`, `reps`, `rest_time_sec`, `set_number`, `workout_id`)
  values
('Жим стоячи', 17, 8, 120, 1, (select @workout_id)),
('Жим стоячи', 17, 8, 120, 2, (select @workout_id)),
('Жим стоячи', 17, 8, 120, 3, (select @workout_id)),
('Жим стоячи', 17, 7, 120, 4, (select @workout_id)),
('Махи у сторони', 7, 16, 120, 1, (select @workout_id)),
('Махи у сторони', 7, 16, 120, 2, (select @workout_id)),
('Махи у сторони', 7, 16, 120, 3, (select @workout_id)),
('Махи вперед', 7, 11, 60, 1, (select @workout_id)),
('Махи вперед', 7, 11, 60, 2, (select @workout_id)),
('Махи вперед', 7, 11, 60, 3, (select @workout_id)),
('Махи вперед', 7, 11, 120, 4, (select @workout_id)),
('Жим лежачи', 7, 75, 120, 1, (select @workout_id)),
('Віджимання від підлоги', 0, 10, 60, 1, (select @workout_id)),
('Віджимання від підлоги', 0, 10, 60, 2, (select @workout_id)),
('Віджимання від підлоги', 0, 10, 60, 3, (select @workout_id)),
('Віджимання від підлоги', 0, 10, 0, 4, (select @workout_id));

set @workout_id = null;

/* без екіпірування */
insert into `style` (`id`) select e.id from exercise e
  join workout w on e.workout_id = w.id
  join athlet a on w.athlet_id = a.id
where a.nickname = 'vit'
  and w.workout_date = '20170607';

/* гантелі */
insert into `equipment` (`id`) select e.id from exercise e
  join workout w on e.workout_id = w.id
  join athlet a on w.athlet_id = a.id
where a.nickname = 'vit'
  and w.workout_date = '20170607';

call update_exercise_if_no_weight ('vit', '20170607');
call calculate_workout_duration ('vit', '20170607');
call calculate_tonnage ('vit', '20170607');

set @athlet_id = null;

commit;
