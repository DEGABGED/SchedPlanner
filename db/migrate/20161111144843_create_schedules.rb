class CreateSchedules < ActiveRecord::Migration
  def change
    create_table :schedules do |t|
      t.datetime :time_start
      t.datetime :time_end
      t.integer :mon_class
      t.integer :sat_class
      t.text :subjects
      t.integer :units

      t.timestamps null: false
    end
  end
end
