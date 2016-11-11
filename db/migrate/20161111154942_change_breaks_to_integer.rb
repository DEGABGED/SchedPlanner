class ChangeBreaksToInteger < ActiveRecord::Migration
  def change
    change_column :schedules, :breaks, :integer
  end
end
