class Schedule < ActiveRecord::Base
  serialize :subjects, Array
  #["math 17", "cs 30", etc.]

  def hasMonClass
    self.mon_class != 0
  end
  def hasSatClass
    self.sat_class != 0
  end

  def opt_sched
    # algorithm to determine the nice schedule
  end
end