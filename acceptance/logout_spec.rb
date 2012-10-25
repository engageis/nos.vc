# Encoding: utf-8
require File.expand_path(File.dirname(__FILE__) + '/acceptance_helper')

feature "Logout Feature" do

  scenario "Given I'm logged in, I must be able to logout" do

    fake_login
    page.should have_link("Olá, #{current_user.display_name.split(' ').first}")
    click_link "Olá, #{current_user.display_name.split(' ').first}"
    click_link "Sair"
    page.should have_no_link("Olá, #{current_user.display_name.split(' ').first}")
    verify_translations

  end

end
