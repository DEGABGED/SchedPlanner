class Course < ActiveRecord::Base
  has_many :schedule_courses
  has_many :schedules, through: :schedule_courses
  #has_and_belongs_to_many :schedules
  serialize :timeslot, Array
  #{:monday => {:day, :t_start, :t_end}}
  #[], numbers 0-47 for time slots

  # course_type is basically "priority"
  def isMajor
    self.course_type == 4
  end
  def isRequiredGE
    self.course_type == 3
  end
  def isGE
    self.course_type == 2
  end
  def isPENSTP
    self.course_type == 1
  end

  # return array in hash form backwards woops
  def timeslot_array
    time_start = 7*60
    time_end = time_start + 12*60
    time_inc = 90
    self.timeslot.each do |x|
      
    end
  end

  def min_to_mil(x)
    h = x / 60
    m = x % 60
    return h*100 + m
  end

  def mil_to_min(x)
    h = x / 100
    m = x % 100
    return h*60 + m
  end
end
