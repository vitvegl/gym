drop table if exists
  `workout_type`,
  `style`,
  `equipment`,
  `exercise`,
  `workout`,
  `athlet`;

drop procedure calculate_workout_duration;
drop procedure calculate_tonnage;
drop procedure set_athlet_id;
drop procedure set_workout_id;
drop procedure update_exercise_if_no_weight;
drop procedure update_exercise_set_equipment;
