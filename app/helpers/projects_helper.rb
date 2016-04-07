module ProjectsHelper

  def preview_mode?
    params[:preview] == 'true'
  end

  def show_edit_field
    can?(:edit, @project) && !preview_mode?
  end

  # For the 'past locations' section, generates a list
  # of span tas to be shown
  def generate_location_tags locations
    location_tags = locations.map do |location|
      content_tag :span, location, :class => 'past-location'
    end

    if location_tags.size == 1
      location_tags.first # return the only tag
    else
      # when there are multiple tags join them (the last one is different too)
      last_tag = location_tags.pop

      "#{location_tags.join(', ')} ou #{last_tag}"
    end
  end

end