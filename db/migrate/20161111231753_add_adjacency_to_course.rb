class AddAdjacencyToCourse < ActiveRecord::Migration
  def change
    add_column :courses, :adjacency, :integer
  end
end
