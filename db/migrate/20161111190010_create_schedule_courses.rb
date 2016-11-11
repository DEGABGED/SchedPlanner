class CreateScheduleCourses < ActiveRecord::Migration
  def change
    create_table :schedule_courses do |t|
      t.belongs_to :schedule, index: :true
      t.belongs_to :course, index: :true

      t.timestamps null: false
    end
  end
end
