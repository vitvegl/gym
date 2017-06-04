start transaction;

call set_athlet_id ('vit');

insert into `workout` (`workout_date`, `start_time`, `finish_time`, `athlet_id`)
  values
('20170602', '2017-06-02 16:13', '2017-06-02 17:13', (select @athlet_id));

call set_workout_id ('vit', '20170602');

/* split */
insert into `workout_type` (`wtype`) value ('split');

insert into `exercise` (`description`, `weight_kg`, `reps`, `rest_time_sec`, `set_number`, `workout_id`)
  values
('Станова тяга', 33, 14, 120, 1, (select @workout_id)),
('Станова тяга', 33, 14, 120, 2, (select @workout_id)),
('Тяга 1 рукою у нахилі', 33, 8, 120, 1, (select @workout_id)),
('Тяга 1 рукою у нахилі', 33, 8, 120, 2, (select @workout_id)),
('Жим сидячи', 15, 12, 90, 1, (select @workout_id)),
('Жим сидячи', 15, 10, 120, 2, (select @workout_id)),
('Жим сидячи', 15, 10, 120, 3, (select @workout_id)),
('Махи у сторони', 7, 16, 120, 1, (select @workout_id)),
('Махи у сторони', 7, 16, 120, 2, (select @workout_id)),
('Махи у сторони', 7, 13, 120, 3, (select @workout_id)),
('Махи вперед', 7, 11, 60, 1, (select @workout_id)),
('Махи вперед', 7, 11, 60, 2, (select @workout_id)),
('Махи вперед', 7, 11, 0, 3, (select @workout_id));

set @workout_id = null;

/* без екіпірування */
insert into `style` (`id`) select e.id from exercise e
  join workout w on e.workout_id = w.id
  join athlet a on w.athlet_id = a.id
where a.nickname = 'vit'
  and w.workout_date = '20170602';

/* гантелі */
insert into `equipment` (`id`) select e.id from exercise e
  join workout w on e.workout_id = w.id
  join athlet a on w.athlet_id = a.id
where a.nickname = 'vit'
  and w.workout_date = '20170602';

call calculate_workout_duration ('vit', '20170602');
call calculate_tonnage ('vit', '20170602');

set @athlet_id = null;

commit;
