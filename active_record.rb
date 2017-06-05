require 'active_record'
require 'mysql2'
require 'native_enum'

class Athlet < ActiveRecord::Base
  self.table_name = "athlet"

  has_many :workouts

  validates :nickname, presence: true, uniqueness: true, length: { in: 3..30 }
end

class Workout < ActiveRecord::Base
  self.table_name = "workout"

  belongs_to :athlet
  has_many :exercises
  has_one :type

  validates :workout_date, presence: true, uniqueness: true

  validates :start_time, uniqueness: true
  validates :finish_time, uniqueness: true
  validate :workout_duration_is_valid?
  validates :tonnage, numericality: { greater_than: 0 }

=begin
  def workout_duration_is_valid?
    DateTime.parse(:start_time) < DateTime.parse(:finish_time) ? true : false
  end
=end

  def workout_duration_is_valid?
    self.start_time < self.finish_time ? true : false
  end
end

class WorkoutType < ActiveRecord::Base
  self.table_name = "workout_type"

  belongs_to :workout

  validates :wtype, presence: true
  validates_inclusion_of :wtype, :in => [ :split, :fullbody ]
end

class Exercise < ActiveRecord::Base
  self.table_name = "exercise"

  belongs_to :workout
  has_one :style
  has_one :equipment

  validates :description, presence: true, length: { minimum: 3, maximum: 100 }
  validates :weight_kg, presence: true, numericality: { greater_than_or_equal_to: 0 }
  validates :reps, presence: true, numericality: { greater_than_or_equal_to: 0, only_integer: true }
  validates :rest_time_sec, presence: true, numericality: { greater_than_or_equal_to: 30, only_integer: true }
  validates :set_number, numericality: { greater_than_or_equal_to: 1, only_integer: true }
end

class Style < ActiveRecord::Base
  self.table_name = "style"

  belongs_to :exercise

  validates :equipment, presence: true
  validates_inclusion_of :equipment, in: [ 'пояс', 'лямки', 'бинти', 'одяг', 'без екіпірування' ]
end

class Equipment < ActiveRecord::Base
  self.table_name = "equipment"

  belongs_to :exercise

  validates :equipment, presence: true
  validates_inclusion_of :equipment, in: [ 'штанга', 'гантель', 'гантелі', 'гиря', 'гирі', 'тренажер', 'власна вага' ]
  validates :description, length: { maximum: 100 }
end
