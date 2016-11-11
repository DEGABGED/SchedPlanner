class AddTimeStringToCourses < ActiveRecord::Migration
  def change
    add_column :courses, :timeslot, :text
    remove_column :courses, :time_start
    remove_column :courses, :time_end
  end
end
