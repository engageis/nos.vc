# coding: utf-8

require File.expand_path(File.dirname(__FILE__) + '/acceptance_helper')

feature "Send Project Feature", :driver => :selenium do

  scenario "I'm not logged in and I want to send a project. It should ask for login." do
    visit homepage
    click_link 'Criar um encontro'
    verify_translations
    current_path.should == login_path
  end

  scenario "I am logged in and I want to send a project" do

    c = Factory(:category)
    visit homepage
    fake_login
    click_link 'Criar um encontro'
    verify_translations
    current_path.should == start_projects_path

    within '.bootstrap-form' do
      fill_in  'name', :with => 'Foo bar'
      fill_in 'about', :with => 'about this very cool project'
      fill_in 'when', :with => "today"
      fill_in 'where', :with => "here"
      fill_in 'video', :with => "http://vimeo.com/28220980"
      fill_in 'leader_name', :with => "me"
      fill_in 'more_info', :with => "on my site"
      fill_in 'goal', :with => 10
      fill_in 'maximum_backers', :with => 10
      fill_in 'how_works', :with => "Foo bar"
      fill_in 'know_us_via', :with => 'goole'

      fill_in 'contact', :with => 'foo@bar.com'
      check 'accept'
      verify_translations
      click_button 'Enviar'
    end

    ActionMailer::Base.deliveries.should_not be_empty
    current_path.should == homepage

  end

end
