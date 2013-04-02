# RailsAdmin config file. Generated on March 29, 2013 15:54
# See github.com/sferik/rails_admin for more informations

require Rails.root.join('lib', 'rails_admin_report_backers_financial.rb')
require Rails.root.join('lib', 'rails_admin_report_backers_location.rb')

RailsAdmin.config do |config|


  ################  Global configuration  ################

  # Set the admin name here (optional second array element will appear in red). For example:
  config.main_app_name = ['Catarse', 'Admin']
  # or for a more dynamic name:
  # config.main_app_name = Proc.new { |controller| [Rails.application.engine_name.titleize, controller.params['action'].titleize] }

  # RailsAdmin may need a way to know who the current user is]
  config.current_user_method { current_user } # auto-generated

  # If you want to track changes on your models:
  # config.audit_with :history, 'User'

  # Or with a PaperTrail: (you need to install it first)
  # config.audit_with :paper_trail, 'User'

  # Display empty fields in show views:
  # config.compact_show_view = false

  # Number of default rows per-page:
  # config.default_items_per_page = 20

  # Exclude specific models (keep the others):
  config.excluded_models = ['Configuration', 'DynamicValue', 'Notification', 'OauthProvider', 'ProjectTotal', 'ProjectsCuratedPage', 'State', 'StaticContent', 'Statistics', 'UserTotal']

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
    report_backers_location
  end

end
