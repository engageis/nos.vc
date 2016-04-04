module ProjectsHelper

  def preview_mode?
    params[:preview] == 'true'
  end

  def show_edit_field
    can?(:edit, @project) && !preview_mode?
  end

end