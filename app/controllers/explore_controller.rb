class ExploreController < ApplicationController

  def index
    @title = t('explore.title')
    @other_cities = Category.not_featured.with_projects.order(:name).all
    @featured_cities = Category.featured.order(:name).limit(5)
    @tags = Project.visible.not_expired.tag_counts.where('taggings_count > 0').pluck(:name)

    # Just to know if we should present the menu entries, the actual projects are fetched via AJAX
    @recommended = Project.visible.not_expired.recommended.limit(3)
    @expiring = Project.visible.expiring.limit(3)
    @recent = Project.visible.recent.not_expired.limit(3).order('created_at DESC')
    @successful = Project.visible.successful.limit(3)
  end

end
