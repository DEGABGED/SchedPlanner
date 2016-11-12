class ChangeAdjacencyToPriority < ActiveRecord::Migration
  def change
    rename_column :courses, :adjacency, :priority
  end
end
