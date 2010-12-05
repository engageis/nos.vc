require File.expand_path(File.dirname(__FILE__) + '/acceptance_helper')

feature "Login Feature" do

  scenario "I'm new to the site and I want to signup with Twitter" do

    visit homepage
    
    page.should have_no_css('#user')
    page.should have_no_link('Catarse Test')
    
    click_link 'Login'
    click_link 'Twitter'

    if page.has_button? 'Sign in'
      fill_in 'username_or_email', :with => 'catarsetest'
      fill_in 'session[password]', :with => 'testcatarse'
      click_button 'Sign in'
    end
    
    click_button 'Allow' if page.has_button?('Allow')
    
    current_path.should == homepage
    
    page.should have_css('#user')
    page.should have_link('Catarse Test')

  end

end