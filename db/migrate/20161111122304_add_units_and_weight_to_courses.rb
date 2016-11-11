class AddUnitsAndWeightToCourses < ActiveRecord::Migration
  def change
    add_column :courses, :units, :integer
    add_column :courses, :descendants, :integer
    add_column :courses, :course_type, :integer
  end
end
