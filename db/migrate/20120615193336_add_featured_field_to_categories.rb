class AddFeaturedFieldToCategories < ActiveRecord::Migration
  def self.up
    add_column :categories, :featured, :boolean, default: false
  end

  def self.down
    remove_column :categories, :featured
  end
end
