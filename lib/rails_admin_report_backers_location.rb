#require 'rails_admin/config/actions'
#require 'rails_admin/config/actions/base'

module RailsAdminReportBackersLocation
end

module RailsAdmin
  module Config
    module Actions
      class ReportBackersLocation < RailsAdmin::Config::Actions::Base
        RailsAdmin::Config::Actions.register(self)

        register_instance_option :member do
          true
        end


        register_instance_option :authorized? do
          bindings[:abstract_model].model_name == "Project" rescue false
        end

        register_instance_option :controller do
          Proc.new do
            redirect_to main_app.backers_location_report_path(params[:id])
          end
        end

        register_instance_option :link_icon do
          'icon-list-alt'
        end
      end
    end
  end
end


