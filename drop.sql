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
drop procedure update_exercise_set_style;

drop procedure insert_into_workout;

/* drop procedure athlet_nickname_validation; */
drop procedure workout_date_validation;
/* drop procedure workout_start_time_validation; */
/* drop procedure workout_finish_time_validation; */

/* drop procedure insert_into_workout; */

/*
drop procedure athlet_nickname_validation;
drop procedure workout_time_validation;
/*
drop procedure workout_duration_validation;
drop procedure workout_tonnage_validation;
drop procedure exercise_description_validation;
drop procedure exercise_rest_time_validation;
drop procedure exercise_set_number_validation;
*/
