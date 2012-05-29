class AddLocationToProjects < ActiveRecord::Migration
  def change
    add_column :projects, :location, :text
  end
end
