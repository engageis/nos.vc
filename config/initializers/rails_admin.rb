# Encoding: utf-8
# RailsAdmin config file. Generated on March 29, 2013 15:54
# See github.com/sferik/rails_admin for more informations

require Rails.root.join('lib', 'rails_admin_report_backers_financial.rb')

RailsAdmin.config do |config|

  config.authenticate_with do
    require_admin
  end

  ################  Global configuration  ################

  # Set the admin name here (optional second array element will appear in red). For example:
  config.main_app_name = ['Nós.vc', 'Admin']
  # or for a more dynamic name:
  # config.main_app_name = Proc.new { |controller| [Rails.application.engine_name.titleize, controller.params['action'].titleize] }

  config.current_user_method { current_user }

  # If you want to track changes on your models:
  # config.audit_with :history, 'User'

  # Or with a PaperTrail: (you need to install it first)
  # config.audit_with :paper_trail, 'User'

  # Display empty fields in show views:
  # config.compact_show_view = false

  # Number of default rows per-page:
  # config.default_items_per_page = 20

  # Exclude specific models (keep the others):
  config.excluded_models = ['DynamicValue', 'Notification', 'OauthProvider', 'ProjectTotal', 'ProjectsCuratedPage', 'State', 'StaticContent', 'Statistics', 'UserTotal']

  # Include specific models (exclude the others):
  # config.included_models = ['Backer', 'Category', 'Configuration', 'CuratedPage', 'DynamicField', 'DynamicValue', 'InstitutionalVideo', 'Notification', 'OauthProvider', 'PaymentDetail', 'PaymentLog', 'Project', 'ProjectTotal', 'ProjectsCuratedPage', 'Reward', 'State', 'StaticContent', 'Statistics', 'Update', 'User', 'UserTotal']

  config.actions do
    # root actions
    dashboard # mandatory
    # collection actions
    index # mandatory
    new
    export
    history_index
    bulk_delete
    # member actions
    show
    edit
    delete
    history_show
    show_in_app

    # Set the custom action here
    report_backers_financial
  end

  config.model "Project" do
    field :name
    field :user
    field :category
    field :goal
    field :expires_at
    field :about
    field :headline
    field :video_url
    field :image_url
    field :short_url
    field :can_finish
    field :finished
    field :visible
    field :rejected
    #field :permalink
    field :recommended
    field :successful
    field :when_short
    field :when_long
    field :location
    field :maximum_backers
    field :leader_bio
    field :leader
    field :rewards
    field :curated_pages


    edit do
      fields_of_type :datetime do
        date_format :default
      end
    end
  end

  config.model "Reward" do
    edit do
      fields_of_type :datetime do
        date_format :default
      end
    end
  end

  config.model "Backer" do
    edit do
      fields_of_type :datetime do
        date_format :default
      end
    end
  end
end
