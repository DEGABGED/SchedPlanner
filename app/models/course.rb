class Course < ActiveRecord::Base
  serialize :timeslot, Hash
  #{:monday => {:timestart, :time}}

  def isMajor
    self.course_type == 1
  end
  def isRequiredGE
    self.course_type == 2
  end
  def isGE
    self.course_type == 3
  end
  def isPENSTP
    self.course_type == 4
  end
end
