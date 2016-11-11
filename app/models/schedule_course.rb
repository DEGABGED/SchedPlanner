class ScheduleCourse < ActiveRecord::Base
  belongs_to :schedule
  belongs_to :course
end
