# RailsAdmin config file. Generated on March 29, 2013 15:54
# See github.com/sferik/rails_admin for more informations

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
  # config.excluded_models = ['Backer', 'Category', 'Configuration', 'CuratedPage', 'DynamicField', 'DynamicValue', 'InstitutionalVideo', 'Notification', 'OauthProvider', 'PaymentDetail', 'PaymentLog', 'Project', 'ProjectTotal', 'ProjectsCuratedPage', 'Reward', 'State', 'StaticContent', 'Statistics', 'Update', 'User', 'UserTotal']

  # Include specific models (exclude the others):
  # config.included_models = ['Backer', 'Category', 'Configuration', 'CuratedPage', 'DynamicField', 'DynamicValue', 'InstitutionalVideo', 'Notification', 'OauthProvider', 'PaymentDetail', 'PaymentLog', 'Project', 'ProjectTotal', 'ProjectsCuratedPage', 'Reward', 'State', 'StaticContent', 'Statistics', 'Update', 'User', 'UserTotal']

  # Label methods for model instances:
  # config.label_methods << :description # Default is [:name, :title]


  ################  Model configuration  ################

  # Each model configuration can alternatively:
  #   - stay here in a `config.model 'ModelName' do ... end` block
  #   - go in the model definition file in a `rails_admin do ... end` block
  
  # This is your choice to make:
  #   - This initializer is loaded once at startup (modifications will show up when restarting the application) but all RailsAdmin configuration would stay in one place.
  #   - Models are reloaded at each request in development mode (when modified), which may smooth your RailsAdmin development workflow.


  # Now you probably need to tour the wiki a bit: https://github.com/sferik/rails_admin/wiki
  # Anyway, here is how RailsAdmin saw your application's models when you ran the initializer:



  ###  Backer  ###

  # config.model 'Backer' do

  #   # You can copy this to a 'rails_admin do ... end' block inside your backer.rb model definition
  
  #   # Found associations:

  #     configure :project, :belongs_to_association 
  #     configure :user, :belongs_to_association 
  #     configure :reward, :belongs_to_association 
  #     configure :payment_logs, :has_many_association 
  #     configure :payment_detail, :has_one_association 
  #     configure :dynamic_values, :has_many_association 

  #   # Found columns:

  #     configure :id, :integer 
  #     configure :project_id, :integer         # Hidden 
  #     configure :user_id, :integer         # Hidden 
  #     configure :reward_id, :integer         # Hidden 
  #     configure :value, :decimal 
  #     configure :confirmed, :boolean 
  #     configure :confirmed_at, :datetime 
  #     configure :created_at, :datetime 
  #     configure :updated_at, :datetime 
  #     configure :display_notice, :boolean 
  #     configure :anonymous, :boolean 
  #     configure :key, :text 
  #     configure :can_refund, :boolean 
  #     configure :requested_refund, :boolean 
  #     configure :refunded, :boolean 
  #     configure :credits, :boolean 
  #     configure :notified_finish, :boolean 
  #     configure :payment_method, :text 
  #     configure :payment_token, :text 
  #     configure :payment_id, :string 
  #     configure :total_paid, :decimal 

  #   # Cross-section configuration:
  
  #     # object_label_method :name     # Name of the method called for pretty printing an *instance* of ModelName
  #     # label 'My model'              # Name of ModelName (smartly defaults to ActiveRecord's I18n API)
  #     # label_plural 'My models'      # Same, plural
  #     # weight 0                      # Navigation priority. Bigger is higher.
  #     # parent OtherModel             # Set parent model for navigation. MyModel will be nested below. OtherModel will be on first position of the dropdown
  #     # navigation_label              # Sets dropdown entry's name in navigation. Only for parents!
  
  #   # Section specific configuration:
  
  #     list do
  #       # filters [:id, :name]  # Array of field names which filters should be shown by default in the table header
  #       # items_per_page 100    # Override default_items_per_page
  #       # sort_by :id           # Sort column (default is primary key)
  #       # sort_reverse true     # Sort direction (default is true for primary key, last created first)
  #     end
  #     show do; end
  #     edit do; end
  #     export do; end
  #     # also see the create, update, modal and nested sections, which override edit in specific cases (resp. when creating, updating, modifying from another model in a popup modal or modifying from another model nested form)
  #     # you can override a cross-section field configuration in any section with the same syntax `configure :field_name do ... end`
  #     # using `field` instead of `configure` will exclude all other fields and force the ordering
  # end


  ###  Category  ###

  # config.model 'Category' do

  #   # You can copy this to a 'rails_admin do ... end' block inside your category.rb model definition
  
  #   # Found associations:

  #     configure :projects, :has_many_association 

  #   # Found columns:

  #     configure :id, :integer 
  #     configure :name, :text 
  #     configure :created_at, :datetime 
  #     configure :updated_at, :datetime 
  #     configure :featured, :boolean 

  #   # Cross-section configuration:
  
  #     # object_label_method :name     # Name of the method called for pretty printing an *instance* of ModelName
  #     # label 'My model'              # Name of ModelName (smartly defaults to ActiveRecord's I18n API)
  #     # label_plural 'My models'      # Same, plural
  #     # weight 0                      # Navigation priority. Bigger is higher.
  #     # parent OtherModel             # Set parent model for navigation. MyModel will be nested below. OtherModel will be on first position of the dropdown
  #     # navigation_label              # Sets dropdown entry's name in navigation. Only for parents!
  
  #   # Section specific configuration:
  
  #     list do
  #       # filters [:id, :name]  # Array of field names which filters should be shown by default in the table header
  #       # items_per_page 100    # Override default_items_per_page
  #       # sort_by :id           # Sort column (default is primary key)
  #       # sort_reverse true     # Sort direction (default is true for primary key, last created first)
  #     end
  #     show do; end
  #     edit do; end
  #     export do; end
  #     # also see the create, update, modal and nested sections, which override edit in specific cases (resp. when creating, updating, modifying from another model in a popup modal or modifying from another model nested form)
  #     # you can override a cross-section field configuration in any section with the same syntax `configure :field_name do ... end`
  #     # using `field` instead of `configure` will exclude all other fields and force the ordering
  # end


  ###  Configuration  ###

  # config.model 'Configuration' do

  #   # You can copy this to a 'rails_admin do ... end' block inside your configuration.rb model definition
  
  #   # Found associations:



  #   # Found columns:

  #     configure :id, :integer 
  #     configure :name, :text 
  #     configure :value, :text 
  #     configure :created_at, :datetime 
  #     configure :updated_at, :datetime 

  #   # Cross-section configuration:
  
  #     # object_label_method :name     # Name of the method called for pretty printing an *instance* of ModelName
  #     # label 'My model'              # Name of ModelName (smartly defaults to ActiveRecord's I18n API)
  #     # label_plural 'My models'      # Same, plural
  #     # weight 0                      # Navigation priority. Bigger is higher.
  #     # parent OtherModel             # Set parent model for navigation. MyModel will be nested below. OtherModel will be on first position of the dropdown
  #     # navigation_label              # Sets dropdown entry's name in navigation. Only for parents!
  
  #   # Section specific configuration:
  
  #     list do
  #       # filters [:id, :name]  # Array of field names which filters should be shown by default in the table header
  #       # items_per_page 100    # Override default_items_per_page
  #       # sort_by :id           # Sort column (default is primary key)
  #       # sort_reverse true     # Sort direction (default is true for primary key, last created first)
  #     end
  #     show do; end
  #     edit do; end
  #     export do; end
  #     # also see the create, update, modal and nested sections, which override edit in specific cases (resp. when creating, updating, modifying from another model in a popup modal or modifying from another model nested form)
  #     # you can override a cross-section field configuration in any section with the same syntax `configure :field_name do ... end`
  #     # using `field` instead of `configure` will exclude all other fields and force the ordering
  # end


  ###  CuratedPage  ###

  # config.model 'CuratedPage' do

  #   # You can copy this to a 'rails_admin do ... end' block inside your curated_page.rb model definition
  
  #   # Found associations:

  #     configure :projects_curated_pages, :has_many_association 
  #     configure :projects, :has_many_association 

  #   # Found columns:

  #     configure :id, :integer 
  #     configure :name, :string 
  #     configure :description, :text 
  #     configure :analytics_id, :string 
  #     configure :logo, :carrierwave 
  #     configure :video_url, :string 
  #     configure :created_at, :datetime 
  #     configure :updated_at, :datetime 
  #     configure :permalink, :string 
  #     configure :visible, :boolean 
  #     configure :site_url, :string 
  #     configure :banner, :carrierwave 

  #   # Cross-section configuration:
  
  #     # object_label_method :name     # Name of the method called for pretty printing an *instance* of ModelName
  #     # label 'My model'              # Name of ModelName (smartly defaults to ActiveRecord's I18n API)
  #     # label_plural 'My models'      # Same, plural
  #     # weight 0                      # Navigation priority. Bigger is higher.
  #     # parent OtherModel             # Set parent model for navigation. MyModel will be nested below. OtherModel will be on first position of the dropdown
  #     # navigation_label              # Sets dropdown entry's name in navigation. Only for parents!
  
  #   # Section specific configuration:
  
  #     list do
  #       # filters [:id, :name]  # Array of field names which filters should be shown by default in the table header
  #       # items_per_page 100    # Override default_items_per_page
  #       # sort_by :id           # Sort column (default is primary key)
  #       # sort_reverse true     # Sort direction (default is true for primary key, last created first)
  #     end
  #     show do; end
  #     edit do; end
  #     export do; end
  #     # also see the create, update, modal and nested sections, which override edit in specific cases (resp. when creating, updating, modifying from another model in a popup modal or modifying from another model nested form)
  #     # you can override a cross-section field configuration in any section with the same syntax `configure :field_name do ... end`
  #     # using `field` instead of `configure` will exclude all other fields and force the ordering
  # end


  ###  DynamicField  ###

  # config.model 'DynamicField' do

  #   # You can copy this to a 'rails_admin do ... end' block inside your dynamic_field.rb model definition
  
  #   # Found associations:

  #     configure :project, :belongs_to_association 
  #     configure :dynamic_values, :has_many_association 

  #   # Found columns:

  #     configure :id, :integer 
  #     configure :input_name, :string 
  #     configure :input_value, :string 
  #     configure :required, :boolean 
  #     configure :project_id, :integer         # Hidden 
  #     configure :created_at, :datetime 
  #     configure :updated_at, :datetime 

  #   # Cross-section configuration:
  
  #     # object_label_method :name     # Name of the method called for pretty printing an *instance* of ModelName
  #     # label 'My model'              # Name of ModelName (smartly defaults to ActiveRecord's I18n API)
  #     # label_plural 'My models'      # Same, plural
  #     # weight 0                      # Navigation priority. Bigger is higher.
  #     # parent OtherModel             # Set parent model for navigation. MyModel will be nested below. OtherModel will be on first position of the dropdown
  #     # navigation_label              # Sets dropdown entry's name in navigation. Only for parents!
  
  #   # Section specific configuration:
  
  #     list do
  #       # filters [:id, :name]  # Array of field names which filters should be shown by default in the table header
  #       # items_per_page 100    # Override default_items_per_page
  #       # sort_by :id           # Sort column (default is primary key)
  #       # sort_reverse true     # Sort direction (default is true for primary key, last created first)
  #     end
  #     show do; end
  #     edit do; end
  #     export do; end
  #     # also see the create, update, modal and nested sections, which override edit in specific cases (resp. when creating, updating, modifying from another model in a popup modal or modifying from another model nested form)
  #     # you can override a cross-section field configuration in any section with the same syntax `configure :field_name do ... end`
  #     # using `field` instead of `configure` will exclude all other fields and force the ordering
  # end


  ###  DynamicValue  ###

  # config.model 'DynamicValue' do

  #   # You can copy this to a 'rails_admin do ... end' block inside your dynamic_value.rb model definition
  
  #   # Found associations:

  #     configure :dynamic_field, :belongs_to_association 
  #     configure :backer, :belongs_to_association 

  #   # Found columns:

  #     configure :id, :integer 
  #     configure :dynamic_field_id, :integer         # Hidden 
  #     configure :backer_id, :integer         # Hidden 
  #     configure :value, :string 
  #     configure :created_at, :datetime 
  #     configure :updated_at, :datetime 

  #   # Cross-section configuration:
  
  #     # object_label_method :name     # Name of the method called for pretty printing an *instance* of ModelName
  #     # label 'My model'              # Name of ModelName (smartly defaults to ActiveRecord's I18n API)
  #     # label_plural 'My models'      # Same, plural
  #     # weight 0                      # Navigation priority. Bigger is higher.
  #     # parent OtherModel             # Set parent model for navigation. MyModel will be nested below. OtherModel will be on first position of the dropdown
  #     # navigation_label              # Sets dropdown entry's name in navigation. Only for parents!
  
  #   # Section specific configuration:
  
  #     list do
  #       # filters [:id, :name]  # Array of field names which filters should be shown by default in the table header
  #       # items_per_page 100    # Override default_items_per_page
  #       # sort_by :id           # Sort column (default is primary key)
  #       # sort_reverse true     # Sort direction (default is true for primary key, last created first)
  #     end
  #     show do; end
  #     edit do; end
  #     export do; end
  #     # also see the create, update, modal and nested sections, which override edit in specific cases (resp. when creating, updating, modifying from another model in a popup modal or modifying from another model nested form)
  #     # you can override a cross-section field configuration in any section with the same syntax `configure :field_name do ... end`
  #     # using `field` instead of `configure` will exclude all other fields and force the ordering
  # end


  ###  InstitutionalVideo  ###

  # config.model 'InstitutionalVideo' do

  #   # You can copy this to a 'rails_admin do ... end' block inside your institutional_video.rb model definition
  
  #   # Found associations:



  #   # Found columns:

  #     configure :id, :integer 
  #     configure :title, :string 
  #     configure :description, :text 
  #     configure :video_url, :string 
  #     configure :visible, :boolean 
  #     configure :created_at, :datetime 
  #     configure :updated_at, :datetime 

  #   # Cross-section configuration:
  
  #     # object_label_method :name     # Name of the method called for pretty printing an *instance* of ModelName
  #     # label 'My model'              # Name of ModelName (smartly defaults to ActiveRecord's I18n API)
  #     # label_plural 'My models'      # Same, plural
  #     # weight 0                      # Navigation priority. Bigger is higher.
  #     # parent OtherModel             # Set parent model for navigation. MyModel will be nested below. OtherModel will be on first position of the dropdown
  #     # navigation_label              # Sets dropdown entry's name in navigation. Only for parents!
  
  #   # Section specific configuration:
  
  #     list do
  #       # filters [:id, :name]  # Array of field names which filters should be shown by default in the table header
  #       # items_per_page 100    # Override default_items_per_page
  #       # sort_by :id           # Sort column (default is primary key)
  #       # sort_reverse true     # Sort direction (default is true for primary key, last created first)
  #     end
  #     show do; end
  #     edit do; end
  #     export do; end
  #     # also see the create, update, modal and nested sections, which override edit in specific cases (resp. when creating, updating, modifying from another model in a popup modal or modifying from another model nested form)
  #     # you can override a cross-section field configuration in any section with the same syntax `configure :field_name do ... end`
  #     # using `field` instead of `configure` will exclude all other fields and force the ordering
  # end


  ###  Notification  ###

  # config.model 'Notification' do

  #   # You can copy this to a 'rails_admin do ... end' block inside your notification.rb model definition
  
  #   # Found associations:

  #     configure :user, :belongs_to_association 
  #     configure :project, :belongs_to_association 

  #   # Found columns:

  #     configure :id, :integer 
  #     configure :user_id, :integer         # Hidden 
  #     configure :project_id, :integer         # Hidden 
  #     configure :text, :text 
  #     configure :twitter_text, :text 
  #     configure :facebook_text, :text 
  #     configure :email_subject, :text 
  #     configure :email_text, :text 
  #     configure :dismissed, :boolean 
  #     configure :created_at, :datetime 
  #     configure :updated_at, :datetime 

  #   # Cross-section configuration:
  
  #     # object_label_method :name     # Name of the method called for pretty printing an *instance* of ModelName
  #     # label 'My model'              # Name of ModelName (smartly defaults to ActiveRecord's I18n API)
  #     # label_plural 'My models'      # Same, plural
  #     # weight 0                      # Navigation priority. Bigger is higher.
  #     # parent OtherModel             # Set parent model for navigation. MyModel will be nested below. OtherModel will be on first position of the dropdown
  #     # navigation_label              # Sets dropdown entry's name in navigation. Only for parents!
  
  #   # Section specific configuration:
  
  #     list do
  #       # filters [:id, :name]  # Array of field names which filters should be shown by default in the table header
  #       # items_per_page 100    # Override default_items_per_page
  #       # sort_by :id           # Sort column (default is primary key)
  #       # sort_reverse true     # Sort direction (default is true for primary key, last created first)
  #     end
  #     show do; end
  #     edit do; end
  #     export do; end
  #     # also see the create, update, modal and nested sections, which override edit in specific cases (resp. when creating, updating, modifying from another model in a popup modal or modifying from another model nested form)
  #     # you can override a cross-section field configuration in any section with the same syntax `configure :field_name do ... end`
  #     # using `field` instead of `configure` will exclude all other fields and force the ordering
  # end


  ###  OauthProvider  ###

  # config.model 'OauthProvider' do

  #   # You can copy this to a 'rails_admin do ... end' block inside your oauth_provider.rb model definition
  
  #   # Found associations:



  #   # Found columns:

  #     configure :id, :integer 
  #     configure :name, :text 
  #     configure :key, :text 
  #     configure :secret, :text 
  #     configure :scope, :text 
  #     configure :order, :integer 
  #     configure :created_at, :datetime 
  #     configure :updated_at, :datetime 
  #     configure :strategy, :text 
  #     configure :path, :text 

  #   # Cross-section configuration:
  
  #     # object_label_method :name     # Name of the method called for pretty printing an *instance* of ModelName
  #     # label 'My model'              # Name of ModelName (smartly defaults to ActiveRecord's I18n API)
  #     # label_plural 'My models'      # Same, plural
  #     # weight 0                      # Navigation priority. Bigger is higher.
  #     # parent OtherModel             # Set parent model for navigation. MyModel will be nested below. OtherModel will be on first position of the dropdown
  #     # navigation_label              # Sets dropdown entry's name in navigation. Only for parents!
  
  #   # Section specific configuration:
  
  #     list do
  #       # filters [:id, :name]  # Array of field names which filters should be shown by default in the table header
  #       # items_per_page 100    # Override default_items_per_page
  #       # sort_by :id           # Sort column (default is primary key)
  #       # sort_reverse true     # Sort direction (default is true for primary key, last created first)
  #     end
  #     show do; end
  #     edit do; end
  #     export do; end
  #     # also see the create, update, modal and nested sections, which override edit in specific cases (resp. when creating, updating, modifying from another model in a popup modal or modifying from another model nested form)
  #     # you can override a cross-section field configuration in any section with the same syntax `configure :field_name do ... end`
  #     # using `field` instead of `configure` will exclude all other fields and force the ordering
  # end


  ###  PaymentDetail  ###

  # config.model 'PaymentDetail' do

  #   # You can copy this to a 'rails_admin do ... end' block inside your payment_detail.rb model definition
  
  #   # Found associations:

  #     configure :backer, :belongs_to_association 

  #   # Found columns:

  #     configure :id, :integer 
  #     configure :backer_id, :integer         # Hidden 
  #     configure :payer_name, :string 
  #     configure :payer_email, :string 
  #     configure :city, :string 
  #     configure :uf, :string 
  #     configure :payment_method, :string 
  #     configure :net_amount, :decimal 
  #     configure :total_amount, :decimal 
  #     configure :service_tax_amount, :decimal 
  #     configure :backer_amount_tax, :decimal 
  #     configure :payment_status, :string 
  #     configure :service_code, :string 
  #     configure :institution_of_payment, :string 
  #     configure :payment_date, :datetime 
  #     configure :created_at, :datetime 
  #     configure :updated_at, :datetime 

  #   # Cross-section configuration:
  
  #     # object_label_method :name     # Name of the method called for pretty printing an *instance* of ModelName
  #     # label 'My model'              # Name of ModelName (smartly defaults to ActiveRecord's I18n API)
  #     # label_plural 'My models'      # Same, plural
  #     # weight 0                      # Navigation priority. Bigger is higher.
  #     # parent OtherModel             # Set parent model for navigation. MyModel will be nested below. OtherModel will be on first position of the dropdown
  #     # navigation_label              # Sets dropdown entry's name in navigation. Only for parents!
  
  #   # Section specific configuration:
  
  #     list do
  #       # filters [:id, :name]  # Array of field names which filters should be shown by default in the table header
  #       # items_per_page 100    # Override default_items_per_page
  #       # sort_by :id           # Sort column (default is primary key)
  #       # sort_reverse true     # Sort direction (default is true for primary key, last created first)
  #     end
  #     show do; end
  #     edit do; end
  #     export do; end
  #     # also see the create, update, modal and nested sections, which override edit in specific cases (resp. when creating, updating, modifying from another model in a popup modal or modifying from another model nested form)
  #     # you can override a cross-section field configuration in any section with the same syntax `configure :field_name do ... end`
  #     # using `field` instead of `configure` will exclude all other fields and force the ordering
  # end


  ###  PaymentLog  ###

  # config.model 'PaymentLog' do

  #   # You can copy this to a 'rails_admin do ... end' block inside your payment_log.rb model definition
  
  #   # Found associations:

  #     configure :backer, :belongs_to_association 

  #   # Found columns:

  #     configure :id, :integer 
  #     configure :backer_id, :integer         # Hidden 
  #     configure :status, :integer 
  #     configure :amount, :float 
  #     configure :payment_status, :integer 
  #     configure :moip_id, :integer 
  #     configure :payment_method, :integer 
  #     configure :payment_type, :string 
  #     configure :consumer_email, :string 
  #     configure :created_at, :datetime 
  #     configure :updated_at, :datetime 

  #   # Cross-section configuration:
  
  #     # object_label_method :name     # Name of the method called for pretty printing an *instance* of ModelName
  #     # label 'My model'              # Name of ModelName (smartly defaults to ActiveRecord's I18n API)
  #     # label_plural 'My models'      # Same, plural
  #     # weight 0                      # Navigation priority. Bigger is higher.
  #     # parent OtherModel             # Set parent model for navigation. MyModel will be nested below. OtherModel will be on first position of the dropdown
  #     # navigation_label              # Sets dropdown entry's name in navigation. Only for parents!
  
  #   # Section specific configuration:
  
  #     list do
  #       # filters [:id, :name]  # Array of field names which filters should be shown by default in the table header
  #       # items_per_page 100    # Override default_items_per_page
  #       # sort_by :id           # Sort column (default is primary key)
  #       # sort_reverse true     # Sort direction (default is true for primary key, last created first)
  #     end
  #     show do; end
  #     edit do; end
  #     export do; end
  #     # also see the create, update, modal and nested sections, which override edit in specific cases (resp. when creating, updating, modifying from another model in a popup modal or modifying from another model nested form)
  #     # you can override a cross-section field configuration in any section with the same syntax `configure :field_name do ... end`
  #     # using `field` instead of `configure` will exclude all other fields and force the ordering
  # end


  ###  Project  ###

  # config.model 'Project' do

  #   # You can copy this to a 'rails_admin do ... end' block inside your project.rb model definition
  
  #   # Found associations:

  #     configure :user, :belongs_to_association 
  #     configure :category, :belongs_to_association 
  #     configure :leader, :belongs_to_association 
  #     configure :projects_curated_pages, :has_many_association 
  #     configure :curated_pages, :has_many_association 
  #     configure :backers, :has_many_association 
  #     configure :rewards, :has_many_association 
  #     configure :updates, :has_many_association 
  #     configure :notifications, :has_many_association 
  #     configure :dynamic_fields, :has_many_association 
  #     configure :project_total, :has_one_association 
  #     configure :managers, :has_and_belongs_to_many_association 

  #   # Found columns:

  #     configure :id, :integer 
  #     configure :name, :text 
  #     configure :user_id, :integer         # Hidden 
  #     configure :category_id, :integer         # Hidden 
  #     configure :goal, :decimal 
  #     configure :expires_at, :datetime 
  #     configure :about, :text 
  #     configure :headline, :text 
  #     configure :video_url, :text 
  #     configure :image_url, :text 
  #     configure :short_url, :text 
  #     configure :created_at, :datetime 
  #     configure :updated_at, :datetime 
  #     configure :can_finish, :boolean 
  #     configure :finished, :boolean 
  #     configure :about_html, :text 
  #     configure :visible, :boolean 
  #     configure :rejected, :boolean 
  #     configure :recommended, :boolean 
  #     configure :home_page_comment, :text 
  #     configure :successful, :boolean 
  #     configure :permalink, :string 
  #     configure :when_short, :string 
  #     configure :when_long, :string 
  #     configure :location, :text 
  #     configure :maximum_backers, :integer 
  #     configure :leader_bio, :text 
  #     configure :leader_id, :integer         # Hidden 

  #   # Cross-section configuration:
  
  #     # object_label_method :name     # Name of the method called for pretty printing an *instance* of ModelName
  #     # label 'My model'              # Name of ModelName (smartly defaults to ActiveRecord's I18n API)
  #     # label_plural 'My models'      # Same, plural
  #     # weight 0                      # Navigation priority. Bigger is higher.
  #     # parent OtherModel             # Set parent model for navigation. MyModel will be nested below. OtherModel will be on first position of the dropdown
  #     # navigation_label              # Sets dropdown entry's name in navigation. Only for parents!
  
  #   # Section specific configuration:
  
  #     list do
  #       # filters [:id, :name]  # Array of field names which filters should be shown by default in the table header
  #       # items_per_page 100    # Override default_items_per_page
  #       # sort_by :id           # Sort column (default is primary key)
  #       # sort_reverse true     # Sort direction (default is true for primary key, last created first)
  #     end
  #     show do; end
  #     edit do; end
  #     export do; end
  #     # also see the create, update, modal and nested sections, which override edit in specific cases (resp. when creating, updating, modifying from another model in a popup modal or modifying from another model nested form)
  #     # you can override a cross-section field configuration in any section with the same syntax `configure :field_name do ... end`
  #     # using `field` instead of `configure` will exclude all other fields and force the ordering
  # end


  ###  ProjectTotal  ###

  # config.model 'ProjectTotal' do

  #   # You can copy this to a 'rails_admin do ... end' block inside your project_total.rb model definition
  
  #   # Found associations:



  #   # Found columns:

  #     configure :project_id, :integer 
  #     configure :pledged, :decimal 
  #     configure :total_backers, :integer 

  #   # Cross-section configuration:
  
  #     # object_label_method :name     # Name of the method called for pretty printing an *instance* of ModelName
  #     # label 'My model'              # Name of ModelName (smartly defaults to ActiveRecord's I18n API)
  #     # label_plural 'My models'      # Same, plural
  #     # weight 0                      # Navigation priority. Bigger is higher.
  #     # parent OtherModel             # Set parent model for navigation. MyModel will be nested below. OtherModel will be on first position of the dropdown
  #     # navigation_label              # Sets dropdown entry's name in navigation. Only for parents!
  
  #   # Section specific configuration:
  
  #     list do
  #       # filters [:id, :name]  # Array of field names which filters should be shown by default in the table header
  #       # items_per_page 100    # Override default_items_per_page
  #       # sort_by :id           # Sort column (default is primary key)
  #       # sort_reverse true     # Sort direction (default is true for primary key, last created first)
  #     end
  #     show do; end
  #     edit do; end
  #     export do; end
  #     # also see the create, update, modal and nested sections, which override edit in specific cases (resp. when creating, updating, modifying from another model in a popup modal or modifying from another model nested form)
  #     # you can override a cross-section field configuration in any section with the same syntax `configure :field_name do ... end`
  #     # using `field` instead of `configure` will exclude all other fields and force the ordering
  # end


  ###  ProjectsCuratedPage  ###

  # config.model 'ProjectsCuratedPage' do

  #   # You can copy this to a 'rails_admin do ... end' block inside your projects_curated_page.rb model definition
  
  #   # Found associations:

  #     configure :project, :belongs_to_association 
  #     configure :curated_page, :belongs_to_association 

  #   # Found columns:

  #     configure :id, :integer 
  #     configure :project_id, :integer         # Hidden 
  #     configure :curated_page_id, :integer         # Hidden 
  #     configure :description, :text 
  #     configure :created_at, :datetime 
  #     configure :updated_at, :datetime 
  #     configure :description_html, :text 

  #   # Cross-section configuration:
  
  #     # object_label_method :name     # Name of the method called for pretty printing an *instance* of ModelName
  #     # label 'My model'              # Name of ModelName (smartly defaults to ActiveRecord's I18n API)
  #     # label_plural 'My models'      # Same, plural
  #     # weight 0                      # Navigation priority. Bigger is higher.
  #     # parent OtherModel             # Set parent model for navigation. MyModel will be nested below. OtherModel will be on first position of the dropdown
  #     # navigation_label              # Sets dropdown entry's name in navigation. Only for parents!
  
  #   # Section specific configuration:
  
  #     list do
  #       # filters [:id, :name]  # Array of field names which filters should be shown by default in the table header
  #       # items_per_page 100    # Override default_items_per_page
  #       # sort_by :id           # Sort column (default is primary key)
  #       # sort_reverse true     # Sort direction (default is true for primary key, last created first)
  #     end
  #     show do; end
  #     edit do; end
  #     export do; end
  #     # also see the create, update, modal and nested sections, which override edit in specific cases (resp. when creating, updating, modifying from another model in a popup modal or modifying from another model nested form)
  #     # you can override a cross-section field configuration in any section with the same syntax `configure :field_name do ... end`
  #     # using `field` instead of `configure` will exclude all other fields and force the ordering
  # end


  ###  Reward  ###

  # config.model 'Reward' do

  #   # You can copy this to a 'rails_admin do ... end' block inside your reward.rb model definition
  
  #   # Found associations:

  #     configure :project, :belongs_to_association 
  #     configure :backers, :has_many_association 

  #   # Found columns:

  #     configure :id, :integer 
  #     configure :project_id, :integer         # Hidden 
  #     configure :minimum_value, :decimal 
  #     configure :maximum_backers, :integer 
  #     configure :description, :text 
  #     configure :created_at, :datetime 
  #     configure :updated_at, :datetime 
  #     configure :expires_at, :datetime 
  #     configure :private, :boolean 
  #     configure :token, :string 

  #   # Cross-section configuration:
  
  #     # object_label_method :name     # Name of the method called for pretty printing an *instance* of ModelName
  #     # label 'My model'              # Name of ModelName (smartly defaults to ActiveRecord's I18n API)
  #     # label_plural 'My models'      # Same, plural
  #     # weight 0                      # Navigation priority. Bigger is higher.
  #     # parent OtherModel             # Set parent model for navigation. MyModel will be nested below. OtherModel will be on first position of the dropdown
  #     # navigation_label              # Sets dropdown entry's name in navigation. Only for parents!
  
  #   # Section specific configuration:
  
  #     list do
  #       # filters [:id, :name]  # Array of field names which filters should be shown by default in the table header
  #       # items_per_page 100    # Override default_items_per_page
  #       # sort_by :id           # Sort column (default is primary key)
  #       # sort_reverse true     # Sort direction (default is true for primary key, last created first)
  #     end
  #     show do; end
  #     edit do; end
  #     export do; end
  #     # also see the create, update, modal and nested sections, which override edit in specific cases (resp. when creating, updating, modifying from another model in a popup modal or modifying from another model nested form)
  #     # you can override a cross-section field configuration in any section with the same syntax `configure :field_name do ... end`
  #     # using `field` instead of `configure` will exclude all other fields and force the ordering
  # end


  ###  State  ###

  # config.model 'State' do

  #   # You can copy this to a 'rails_admin do ... end' block inside your state.rb model definition
  
  #   # Found associations:



  #   # Found columns:

  #     configure :id, :integer 
  #     configure :name, :string 
  #     configure :acronym, :string 
  #     configure :created_at, :datetime 
  #     configure :updated_at, :datetime 

  #   # Cross-section configuration:
  
  #     # object_label_method :name     # Name of the method called for pretty printing an *instance* of ModelName
  #     # label 'My model'              # Name of ModelName (smartly defaults to ActiveRecord's I18n API)
  #     # label_plural 'My models'      # Same, plural
  #     # weight 0                      # Navigation priority. Bigger is higher.
  #     # parent OtherModel             # Set parent model for navigation. MyModel will be nested below. OtherModel will be on first position of the dropdown
  #     # navigation_label              # Sets dropdown entry's name in navigation. Only for parents!
  
  #   # Section specific configuration:
  
  #     list do
  #       # filters [:id, :name]  # Array of field names which filters should be shown by default in the table header
  #       # items_per_page 100    # Override default_items_per_page
  #       # sort_by :id           # Sort column (default is primary key)
  #       # sort_reverse true     # Sort direction (default is true for primary key, last created first)
  #     end
  #     show do; end
  #     edit do; end
  #     export do; end
  #     # also see the create, update, modal and nested sections, which override edit in specific cases (resp. when creating, updating, modifying from another model in a popup modal or modifying from another model nested form)
  #     # you can override a cross-section field configuration in any section with the same syntax `configure :field_name do ... end`
  #     # using `field` instead of `configure` will exclude all other fields and force the ordering
  # end


  ###  StaticContent  ###

  # config.model 'StaticContent' do

  #   # You can copy this to a 'rails_admin do ... end' block inside your static_content.rb model definition
  
  #   # Found associations:



  #   # Found columns:

  #     configure :id, :integer 
  #     configure :title, :string 
  #     configure :body, :text 
  #     configure :body_html, :text 
  #     configure :created_at, :datetime 
  #     configure :updated_at, :datetime 

  #   # Cross-section configuration:
  
  #     # object_label_method :name     # Name of the method called for pretty printing an *instance* of ModelName
  #     # label 'My model'              # Name of ModelName (smartly defaults to ActiveRecord's I18n API)
  #     # label_plural 'My models'      # Same, plural
  #     # weight 0                      # Navigation priority. Bigger is higher.
  #     # parent OtherModel             # Set parent model for navigation. MyModel will be nested below. OtherModel will be on first position of the dropdown
  #     # navigation_label              # Sets dropdown entry's name in navigation. Only for parents!
  
  #   # Section specific configuration:
  
  #     list do
  #       # filters [:id, :name]  # Array of field names which filters should be shown by default in the table header
  #       # items_per_page 100    # Override default_items_per_page
  #       # sort_by :id           # Sort column (default is primary key)
  #       # sort_reverse true     # Sort direction (default is true for primary key, last created first)
  #     end
  #     show do; end
  #     edit do; end
  #     export do; end
  #     # also see the create, update, modal and nested sections, which override edit in specific cases (resp. when creating, updating, modifying from another model in a popup modal or modifying from another model nested form)
  #     # you can override a cross-section field configuration in any section with the same syntax `configure :field_name do ... end`
  #     # using `field` instead of `configure` will exclude all other fields and force the ordering
  # end


  ###  Statistics  ###

  # config.model 'Statistics' do

  #   # You can copy this to a 'rails_admin do ... end' block inside your statistics.rb model definition
  
  #   # Found associations:



  #   # Found columns:

  #     configure :total_users, :integer 
  #     configure :total_backs, :integer 
  #     configure :total_backers, :integer 
  #     configure :total_backed, :decimal 
  #     configure :total_projects, :integer 
  #     configure :total_projects_success, :integer 
  #     configure :total_projects_online, :integer 

  #   # Cross-section configuration:
  
  #     # object_label_method :name     # Name of the method called for pretty printing an *instance* of ModelName
  #     # label 'My model'              # Name of ModelName (smartly defaults to ActiveRecord's I18n API)
  #     # label_plural 'My models'      # Same, plural
  #     # weight 0                      # Navigation priority. Bigger is higher.
  #     # parent OtherModel             # Set parent model for navigation. MyModel will be nested below. OtherModel will be on first position of the dropdown
  #     # navigation_label              # Sets dropdown entry's name in navigation. Only for parents!
  
  #   # Section specific configuration:
  
  #     list do
  #       # filters [:id, :name]  # Array of field names which filters should be shown by default in the table header
  #       # items_per_page 100    # Override default_items_per_page
  #       # sort_by :id           # Sort column (default is primary key)
  #       # sort_reverse true     # Sort direction (default is true for primary key, last created first)
  #     end
  #     show do; end
  #     edit do; end
  #     export do; end
  #     # also see the create, update, modal and nested sections, which override edit in specific cases (resp. when creating, updating, modifying from another model in a popup modal or modifying from another model nested form)
  #     # you can override a cross-section field configuration in any section with the same syntax `configure :field_name do ... end`
  #     # using `field` instead of `configure` will exclude all other fields and force the ordering
  # end


  ###  Update  ###

  # config.model 'Update' do

  #   # You can copy this to a 'rails_admin do ... end' block inside your update.rb model definition
  
  #   # Found associations:

  #     configure :user, :belongs_to_association 
  #     configure :project, :belongs_to_association 

  #   # Found columns:

  #     configure :id, :integer 
  #     configure :user_id, :integer         # Hidden 
  #     configure :project_id, :integer         # Hidden 
  #     configure :title, :text 
  #     configure :comment, :text 
  #     configure :comment_html, :text 
  #     configure :created_at, :datetime 
  #     configure :updated_at, :datetime 

  #   # Cross-section configuration:
  
  #     # object_label_method :name     # Name of the method called for pretty printing an *instance* of ModelName
  #     # label 'My model'              # Name of ModelName (smartly defaults to ActiveRecord's I18n API)
  #     # label_plural 'My models'      # Same, plural
  #     # weight 0                      # Navigation priority. Bigger is higher.
  #     # parent OtherModel             # Set parent model for navigation. MyModel will be nested below. OtherModel will be on first position of the dropdown
  #     # navigation_label              # Sets dropdown entry's name in navigation. Only for parents!
  
  #   # Section specific configuration:
  
  #     list do
  #       # filters [:id, :name]  # Array of field names which filters should be shown by default in the table header
  #       # items_per_page 100    # Override default_items_per_page
  #       # sort_by :id           # Sort column (default is primary key)
  #       # sort_reverse true     # Sort direction (default is true for primary key, last created first)
  #     end
  #     show do; end
  #     edit do; end
  #     export do; end
  #     # also see the create, update, modal and nested sections, which override edit in specific cases (resp. when creating, updating, modifying from another model in a popup modal or modifying from another model nested form)
  #     # you can override a cross-section field configuration in any section with the same syntax `configure :field_name do ... end`
  #     # using `field` instead of `configure` will exclude all other fields and force the ordering
  # end


  ###  User  ###

  # config.model 'User' do

  #   # You can copy this to a 'rails_admin do ... end' block inside your user.rb model definition
  
  #   # Found associations:

  #     configure :secondary_users, :has_many_association 
  #     configure :backs, :has_many_association 
  #     configure :projects, :has_many_association 
  #     configure :led_projects, :has_many_association 
  #     configure :updates, :has_many_association 
  #     configure :notifications, :has_many_association 
  #     configure :user_total, :has_one_association 
  #     configure :manages_projects, :has_and_belongs_to_many_association 

  #   # Found columns:

  #     configure :id, :integer 
  #     configure :primary_user_id, :integer         # Hidden 
  #     configure :provider, :text 
  #     configure :uid, :text 
  #     configure :email, :text 
  #     configure :name, :text 
  #     configure :nickname, :text 
  #     configure :bio, :text 
  #     configure :image_url, :text 
  #     configure :newsletter, :boolean 
  #     configure :project_updates, :boolean 
  #     configure :created_at, :datetime 
  #     configure :updated_at, :datetime 
  #     configure :admin, :boolean 
  #     configure :full_name, :text 
  #     configure :address_street, :text 
  #     configure :address_number, :text 
  #     configure :address_complement, :text 
  #     configure :address_neighbourhood, :text 
  #     configure :address_city, :text 
  #     configure :address_state, :text 
  #     configure :address_zip_code, :text 
  #     configure :phone_number, :text 
  #     configure :credits, :decimal 
  #     configure :locale, :text 
  #     configure :cpf, :text 
  #     configure :password, :password         # Hidden 
  #     configure :password_confirmation, :password         # Hidden 
  #     configure :reset_password_token, :string         # Hidden 
  #     configure :reset_password_sent_at, :datetime 
  #     configure :remember_created_at, :datetime 
  #     configure :sign_in_count, :integer 
  #     configure :current_sign_in_at, :datetime 
  #     configure :last_sign_in_at, :datetime 
  #     configure :current_sign_in_ip, :string 
  #     configure :last_sign_in_ip, :string 
  #     configure :twitter, :string 
  #     configure :facebook_link, :string 
  #     configure :other_link, :string 

  #   # Cross-section configuration:
  
  #     # object_label_method :name     # Name of the method called for pretty printing an *instance* of ModelName
  #     # label 'My model'              # Name of ModelName (smartly defaults to ActiveRecord's I18n API)
  #     # label_plural 'My models'      # Same, plural
  #     # weight 0                      # Navigation priority. Bigger is higher.
  #     # parent OtherModel             # Set parent model for navigation. MyModel will be nested below. OtherModel will be on first position of the dropdown
  #     # navigation_label              # Sets dropdown entry's name in navigation. Only for parents!
  
  #   # Section specific configuration:
  
  #     list do
  #       # filters [:id, :name]  # Array of field names which filters should be shown by default in the table header
  #       # items_per_page 100    # Override default_items_per_page
  #       # sort_by :id           # Sort column (default is primary key)
  #       # sort_reverse true     # Sort direction (default is true for primary key, last created first)
  #     end
  #     show do; end
  #     edit do; end
  #     export do; end
  #     # also see the create, update, modal and nested sections, which override edit in specific cases (resp. when creating, updating, modifying from another model in a popup modal or modifying from another model nested form)
  #     # you can override a cross-section field configuration in any section with the same syntax `configure :field_name do ... end`
  #     # using `field` instead of `configure` will exclude all other fields and force the ordering
  # end


  ###  UserTotal  ###

  # config.model 'UserTotal' do

  #   # You can copy this to a 'rails_admin do ... end' block inside your user_total.rb model definition
  
  #   # Found associations:



  #   # Found columns:

  #     configure :id, :integer 
  #     configure :user_id, :integer 
  #     configure :sum, :decimal 
  #     configure :count, :integer 
  #     configure :credits, :decimal 

  #   # Cross-section configuration:
  
  #     # object_label_method :name     # Name of the method called for pretty printing an *instance* of ModelName
  #     # label 'My model'              # Name of ModelName (smartly defaults to ActiveRecord's I18n API)
  #     # label_plural 'My models'      # Same, plural
  #     # weight 0                      # Navigation priority. Bigger is higher.
  #     # parent OtherModel             # Set parent model for navigation. MyModel will be nested below. OtherModel will be on first position of the dropdown
  #     # navigation_label              # Sets dropdown entry's name in navigation. Only for parents!
  
  #   # Section specific configuration:
  
  #     list do
  #       # filters [:id, :name]  # Array of field names which filters should be shown by default in the table header
  #       # items_per_page 100    # Override default_items_per_page
  #       # sort_by :id           # Sort column (default is primary key)
  #       # sort_reverse true     # Sort direction (default is true for primary key, last created first)
  #     end
  #     show do; end
  #     edit do; end
  #     export do; end
  #     # also see the create, update, modal and nested sections, which override edit in specific cases (resp. when creating, updating, modifying from another model in a popup modal or modifying from another model nested form)
  #     # you can override a cross-section field configuration in any section with the same syntax `configure :field_name do ... end`
  #     # using `field` instead of `configure` will exclude all other fields and force the ordering
  # end

end
