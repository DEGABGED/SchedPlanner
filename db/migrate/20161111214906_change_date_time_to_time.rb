class ChangeDateTimeToTime < ActiveRecord::Migration
  def change
    change_column :schedules, :time_start, :time
    change_column :schedules, :time_end, :time
  end
end
