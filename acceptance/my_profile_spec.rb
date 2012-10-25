# coding: utf-8

require File.expand_path(File.dirname(__FILE__) + '/acceptance_helper')

feature "My profile Feature" do

  scenario "I should be able to see and edit my profile when I click on 'meu perfil'" do

    fake_login

    add_some_projects(4, user: user)
    add_some_projects(3)
    7.times do
      Factory(:backer, user: user, confirmed: true)
    end

    click_link "Olá, #{current_user.display_name.split(' ').first}"
    verify_translations
    click_link 'Meu perfil'
    verify_translations
    current_path.should == user_path(user)

    within 'head title' do
      page.should have_content("#{user.display_name} · #{I18n.t('site.name')}")
    end

    within '.profile_title' do
      within 'h1' do
        page.should have_content(user.display_name)
      end
      within 'h4' do
        page.should have_content(user.bio)
      end
    end

    titles = all("#user_profile_menu a")
    titles.shift.should have_content("Me inscrevi")
    titles.shift.should have_content("Criei")
    titles.shift.should have_content("Depoimentos")
    titles.shift.should have_content("Créditos")
    titles.shift.should have_content("Configurações")

    # User Settings
    within "#user_profile_menu" do
      click_link "Configurações"
    end
    verify_translations

    within "#my_data ul" do
      page.should have_content(user.email)
      #page.should have_css("input[type=checkbox]#newsletter")
    end

    within "#social_info" do
      page.should have_css("input[type=text]#user_twitter")
      page.should have_css("input[type=text]#user_facebook_link")
      page.should have_css("input[type=text]#user_other_link")
      page.should have_css("input[type=submit]#user_submit")
    end

    # My Projects
    within "#user_profile_menu" do
      click_link "Criei"
    end
    verify_translations
    sleep 2

    within "#user_created_projects" do
      all('li .project').should have(4).items
    end

    # Backed Projects
    within "#user_profile_menu" do
      click_link "Me inscrevi"
    end
    verify_translations
    sleep 2

    within "#user_backed_projects" do
      all('li .project').should have(7).items
    end

    # Testing on the spot edits
    within '.profile_title' do
      within 'h1' do
        page.should have_no_content("New user name")
        page.should have_content(user.display_name)
        find("span").click
        find("input").set("New user name")
        click_on "OK"
        page.should have_content("New user name")
        user.reload
        user.display_name.should == "New user name"
      end

      within 'h4' do
        page.should have_no_content("New user biography")
        page.should have_content(user.bio)
        find("span").click
        find("textarea").set("New user biography")
        click_on "OK"
        page.should have_content("New user biography")
        user.reload
        user.bio.should == "New user biography"
      end
    end

    within "#user_profile_menu" do
      click_link "Configurações"
    end
    verify_translations

    within "#my_data ul" do
      within first("li") do
        page.should have_no_content("new@email.com")
        page.should have_content(user.email)
        find("span").click
        find("input").set("new@email.com")
        click_on "OK"
        page.should have_content("new@email.com")
        user.reload
        user.email.should == "new@email.com"
      end
    end

    within "#user_profile_menu" do
      click_link "Configurações"
    end
    verify_translations

    within "#social_info" do
      fill_in "Seu usuário do twitter", with: "@FooBar"
      fill_in "Link do seu perfil do facebook", with: "facebook.com/FooBar"
      fill_in "Link do seu site", with: "boobar.com"
      click_button "Atualizar"
    end
    verify_translations

    within "#social_info" do
      find_field("Seu usuário do twitter").value.should == "FooBar"
      find_field("Link do seu perfil do facebook").value.should == "https://facebook.com/FooBar"
      find_field("Link do seu site").value.should == "http://boobar.com"
    end

  end

end
