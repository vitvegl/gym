require 'rails/all'

class Athlet < ActiveRecord::Base
  has_many :workouts
end

class Workout < ActiveRecord::Base
  belongs_to :athlet
  has_many :exercises
  has_one :type
end

class Type < ActiveRecord::Base
  belongs_to :workout
end

class Exercise < ActiveRecord::Base
  belongs_to :workout
  has_one :style
  has_one :equipment
end

class Style < ActiveRecord::Base
  belongs_to :exercise
end

class Equipment < ActiveRecord::Base
  belongs_to :exercise
end
