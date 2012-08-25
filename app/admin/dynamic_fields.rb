ActiveAdmin.register DynamicField do
  filter :project

  index do
    column :input_name
    column :required
    column :project
    default_actions
  end
end

