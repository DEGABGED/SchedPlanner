class Schedule < ActiveRecord::Base
  after_commit :opt_sched
  has_many :schedule_courses
  has_many :courses, through: :schedule_courses
  serialize :subjects, Array
  #["math 17", "cs 30", etc.]

  def hasMonClass
    self.mon_class != 0
  end
  def hasSatClass
    self.sat_class != 0
  end

  def generate_courses
    for i in 0...self.subjects.length
      Course.where('lower(name) = ?', self.subjects[i].downcase).find_each do |course|
        course.user_weight = i+1
        self.courses << course
      end
    end
  end

  def time_start_int
    t_start = Time.parse("7:00 AM")
    t_user = self.time_start
    delta_t = 5400
    ts_sec = t_start.hour*3600 + t_start.min*60 + t_start.sec
    tu_sec = t_user.hour*3600 + t_user.min*60 + t_user.sec
    t_diff = tu_sec - ts_sec
    return t_diff / delta_t
  end

  def time_end_int
    t_end = Time.parse("7:00 PM")
    t_user = self.time_end
    delta_t = 5400
    te_sec = t_end.hour*3600 + t_end.min*60 + t_end.sec
    tu_sec = t_user.hour*3600 + t_user.min*60 + t_user.sec
    t_diff = te_sec - tu_sec
    return 8 - (t_diff / delta_t)
  end

  def location_adj(i,j)
    matrix = [[0,2,1,2,3,3,4,3,4,5,4,5],
              [2,0,4,5,4,4,3,2,1,2,3,4],
              [1,4,0,1,1,1,2,2,3,4,3,3],
              [2,5,1,0,1,1,1,1,2,3,2,2],
              [3,4,1,1,0,1,1,1,2,3,2,2],
              [3,4,1,1,1,0,1,2,3,4,3,2],
              [4,3,2,1,1,1,0,1,2,3,2,1],
              [3,2,2,1,1,2,1,0,1,2,1,2],
              [4,1,3,2,2,3,2,1,0,1,2,2],
              [5,2,4,3,3,4,3,2,1,0,1,2],
              [4,3,3,2,2,3,2,1,2,1,0,1],
              [5,4,3,2,2,2,1,2,2,2,1,0]]
    return matrix[i][j]
  end

  def conflict_resol(c_last, s_arr)
    puts "confilct resol"
    s_arr.each do |c|
      if c.timeslot == c_last.timeslot then
        # check for equal days
        if same_day(c.day, c_last.day) then
          s_arr.delete(c)
        end
      end
    end
    puts "conflciut end"
  end

  def same_day(i,j)
    if i == 4 then
      return [1,2,4].include? j
    elsif j == 4 then
      return [1,2,4].include? i
    else
      return i == j
    end
  end
  # returns array of classes
  def sched_1
    s_arr = []
    Marshal.load(Marshal.dump(self.courses)).each do |m|
      s_arr.push(m)
    end
    s_des = Marshal.load(Marshal.dump(self.subjects))
    s_out = []
    earliest = s_arr.select {|c| c.user_weight == 1}.sort! {|a,b| a.timeslot <=> b.timeslot}.first

    # initial thing
    # warning blah blah
    s_out.push(earliest)
    s_des = s_des - s_des.select {|s| s.casecmp(earliest.name) == 0}
    s_arr.delete(earliest)


    # conflict resol
    # remove dsmae name
    s_arr = s_arr - s_arr.select {|v| v.name.casecmp(s_out.last.name) == 0}
    self.conflict_resol(s_out.last, s_arr)

    #checkers
    puts "sched _1", s_des
    puts "s_arr"
    s_arr.each do |s|
      puts s.name, s.timeslot, s.day
    end
    puts "s_out"
    s_out.each do |s|
      puts s.name, s.timeslot, s.day
    end

    # other classes loop
    while s_des.size != 0 and s_arr.size != 0 do
      # get adjacency of each course in s_arr
      s_arr.each do |c|
        c_0 = s_out.select {|v| same_day(v.day, c.day) and v.timeslot + 1 == c.timeslot}.first
        adjacency = location_adj(c.location, c_0 ? c_0.location : c.location)
        c.priority = c.user_weight + adjacency + c.timeslot
      end

      # get the one with the lowest p(c, c0)
      top = s_arr.select{|v| v}.sort! {|a,b| a.priority <=> b.priority }.first
      s_out.push(top)
      s_des = s_des - s_des.select {|s| s.casecmp(top.name) == 0}
      s_arr.delete(top)

      #conflict
      # remove dsmae name
      s_arr = s_arr - s_arr.select {|v| v.name.casecmp(s_out.last.name) == 0}
      self.conflict_resol(s_out.last, s_arr)

      # consecutivity next
      for i in (0..3) do
        subset = s_arr.select {|v| v.day == i}.map {|v| v.timeslot}
        if i == 1 or i == 2 then
          subset = subset + s_arr.select {|v| v.day == 4}.map {|v| v.timeslot}
        end

        puts "subset", subset

        #if subset.sort.each_cons(self.breaks).all? {|a,b| b == a+1} then
        #end
        subset.sort.each_cons(self.breaks).each do |ss|
          if ss.all? {|a,b| b == a+1} then
            # Remove classes before and after the consecutives
            sub_b = subset.select {|v| v.timeslot = ss.first.timeslot - 1}
            sub_a = subset.select {|v| v.timeslot = ss.last.timeslot + 1}
            s_arr = (s_arr - sub_b) - sub_a
          end
        end
      end
    end
    #checkers
    puts "sched _1", s_des
    puts "s_arr"
    s_arr.each do |s|
      puts s.name, s.timeslot, s.day
    end
    puts "s_out"
    s_out.each do |s|
      puts s.name, s.timeslot, s.day
    end
  end

  def sched_2
    s_arr = Marshal.load(Marshal.dump(self.courses))
  end

  def sched_3
    s_arr = Marshal.load(Marshal.dump(self.courses))
  end

  def opt_sched
    # algorithm to determine the nice schedule
    self.generate_courses
    # set the time start and end things

    # remove the unwanted classes
    self.courses.each do |course|
      if course.timeslot < self.time_start_int or course.timeslot > self.time_end_int then
        self.courses.delete(course.id)
      end
      if self.mon_class == 0 and course.day == 0 then
        self.courses.delete(course.id)
      end
      if self.sat_class == 0 and course.day == 5 then
        self.courses.delete(course.id)
      end
    end

    # Start processing each shit
    self.sched_1
  end
end
