class AddBannerToCuratedPages < ActiveRecord::Migration
  def change
    add_column :curated_pages, :banner, :text
  end
end
