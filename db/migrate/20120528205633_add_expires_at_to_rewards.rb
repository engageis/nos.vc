class AddExpiresAtToRewards < ActiveRecord::Migration
  def change
    add_column :rewards, :expires_at, :datetime
  end
end
