class AddLeaderFieldsToProjects < ActiveRecord::Migration
  def change
    add_column :projects, :leader_bio, :text
    add_column :projects, :leader_id, :integer, :null => true, :reference => {:users => :id}
    add_index :projects, :leader_id
  end
end
