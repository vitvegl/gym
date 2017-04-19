require 'rails/all'

class Athlet < ActiveRecord::Base
  self.table_name = "athlet"

  has_many :workouts
end

class Workout < ActiveRecord::Base
  self.table_name = "workout"

  belongs_to :athlet
  has_many :exercises
  has_one :type
end

class WorkoutType < ActiveRecord::Base
  self.table_name = "workout_type"

  belongs_to :workout
end

class Exercise < ActiveRecord::Base
  self.table_name = "exercise"

  belongs_to :workout
  has_one :style
  has_one :equipment
end

class Style < ActiveRecord::Base
  self.table_name = "style"

  belongs_to :exercise
end

class Equipment < ActiveRecord::Base
  self.table_name = "equipment"

  belongs_to :exercise
end
