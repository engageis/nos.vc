# coding: utf-8

require File.expand_path(File.dirname(__FILE__) + '/acceptance_helper')

feature "New Project Feature", :driver => :selenium do

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
    visit new_project_path
    verify_translations
    current_path.should == new_project_path
    within '.title' do
      within 'h1' do
        page.should have_content("Agora é pra valer. Construa a página do seu encontro.")
      end
    end

    within '.bootstrap-form' do
      sleep 2
      fill_in 'project_name', :with => 'test project'

      fill_in 'project_video_url', :with => 'http://vimeo.com/18210052'
      fill_in 'project_about', :with => 'about this very cool project'
      fill_in 'project_headline', :with => 'this is our nice headline'
      fill_in 'project_goal', :with => '1000'
      fill_in 'project_expires_at', :with => '21/12/2012'
      fill_in 'project_when_short', :with => "25/12/2012"
      fill_in 'project_when_long', :with => "Segunda, 2 de janeiro de 2012. Das 9:00 às 17:00"
      fill_in 'project_location', :with => "Porto Alegre"
      fill_in 'project_rewards_attributes_0_description', :with => 'this is an exciting reward'
      fill_in 'project_rewards_attributes_0_minimum_value', :with => '10'
      select c.name, :from => 'project_category_id'
      check 'accept'
      verify_translations
      click_button 'project_submit'
    end

    verify_translations

    sleep 2
    p = Project.first
    p.name.should == 'test project'
    p.expires_at.utc.should == (Time.zone.parse('2012-12-21') + (23.hours + 59.minutes + 59.seconds)).utc
    page.should have_content("test project")

  end

end
