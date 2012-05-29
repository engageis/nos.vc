class AddMaximumBackersToProjects < ActiveRecord::Migration
  def change
    add_column :projects, :maximum_backers, :integer
  end
end
