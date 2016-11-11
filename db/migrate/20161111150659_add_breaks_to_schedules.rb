class AddBreaksToSchedules < ActiveRecord::Migration
  def change
    add_column :schedules, :breaks, :text
  end
end
