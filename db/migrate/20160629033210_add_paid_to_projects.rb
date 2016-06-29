class AddPaidToProjects < ActiveRecord::Migration
  def change
    add_column :projects, :paid, :boolean
  end
end
