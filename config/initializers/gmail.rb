begin
  if Rails.env.production?
    ActionMailer::Base.smtp_settings = {
      :address => 'smtp.gmail.com',
      :port => 587,
      :domain => 'matehackers.org',
      :user_name => ENV['GMAIL_USERNAME'],
      :password => ENV['GMAIL_PASSWORD'],
      :authentication => :plain,
      :enable_starttls_auto => true
    }
    ActionMailer::Base.delivery_method = :smtp
  end
rescue
  nil
end
