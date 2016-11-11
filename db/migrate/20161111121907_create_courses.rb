class CreateCourses < ActiveRecord::Migration
  def change
    create_table :courses do |t|
      t.string :name
      t.datetime :time_start
      t.datetime :time_end
      t.integer :demand
      t.integer :subj_code

      t.timestamps null: false
    end
  end
end
