ActiveAdmin.register DynamicField do
  filter :project

  index do
    column :input_name
    column :project
    default_actions
  end
end

