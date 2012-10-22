class AddTokenToRewards < ActiveRecord::Migration
  def change
    add_column :rewards, :private, :boolean, :default => false
    add_column :rewards, :token, :string
  end
end
