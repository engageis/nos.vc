class AddWhenFieldsToProjects < ActiveRecord::Migration
  def change
    add_column :projects, :when_short, :string
    add_column :projects, :when_long, :string
  end
end
