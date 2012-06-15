class Category < ActiveRecord::Base
  has_many :projects
  validates_presence_of :name
  validates_uniqueness_of :name
  scope :featured, where(featured: true)
  scope :not_featured, where("featured IS NOT TRUE")
  def self.with_projects
    where("id IN (SELECT DISTINCT category_id FROM projects WHERE visible)")
  end
end
