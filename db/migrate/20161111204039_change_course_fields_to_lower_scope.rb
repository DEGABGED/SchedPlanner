class ChangeCourseFieldsToLowerScope < ActiveRecord::Migration
  def change
    change_column :courses, :timeslot, :integer
    rename_column :courses, :descendants, :location
    rename_column :courses, :demand, :day
    rename_column :courses, :subj_code, :code
    rename_column :courses, :course_type, :type
    rename_column :courses, :units, :user_weight
  end
end
