class Course < ActiveRecord::Base
  before_save :default_values
  has_many :schedule_courses
  has_many :schedules, through: :schedule_courses
  def default_values
    self.user_weight = -1
  end
end
