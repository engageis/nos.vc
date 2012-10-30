# coding: utf-8

require File.expand_path(File.dirname(__FILE__) + '/acceptance_helper')

feature "Show Project Feature" do

  include Rails.application.routes.url_helpers

  scenario "As an unlogged user, I want to see a project page" do

    project = Factory(:project)
    visit project_path(project)
    verify_translations

    page.should have_css(%@meta [property="og:title"][content="#{project.name}"]@)
    page.should have_css(%@meta [property="og:type"][content="cause"]@)
    page.should have_css(%@meta [property="og:url"][content="#{I18n.t('site.base_url')}#{project_path(project)}"]@)
    page.should have_css(%@meta [property="og:image"][content="#{project.display_image}"]@)
    page.should have_css(%@meta [property="og:site_name"][content="#{I18n.t('site.name')}"]@)
    page.should have_css(%@meta [property="og:description"][content="#{project.about}"]@)

    within '.section_header' do
      within 'h1' do
        page.should have_content(project.name)
      end
    end

    find("#project_about").visible?.should be_true
    within "#project_about" do
      page.should have_content(project.about)
    end
    find("#project_updates").visible?.should be_true
    find("#project_backers").visible?.should be_true
    find("#project_comments").visible?.should be_true

    find(".total_backers").should have_content("0")

    within '.media_content_backers' do
      page.should have_content "Ninguém se inscreveu ainda. Você pode ser a primeiríssima pessoa a dar vida ao encontro."
    end

    within '#project_updates' do
      within 'h1' do
        page.should have_content "Atualizações (0)"
      end
    end

    within '#project_comments' do
      page.should have_content 'Recomende, pergunte e construa este encontro:'
    end

  end

  scenario "As an unlogged user, I want to see a project page with updates, backers and comments" do

    project = Factory(:project)
    3.times { Factory(:backer, project: project) }
    2.times { Factory(:update, project: project) }

    visit project_path(project)


    within '#project_updates' do
      within 'h1' do
        page.should have_content "Atualizações (2)"
      end

      updates = project.updates.order("created_at DESC")
      list = all("li")
      list.should have(2).items
      list.each_index do |index|
        list[index].find("h3").text.should == updates[index].title
        list[index].find(".time").text.should == I18n.l(updates[index].created_at, :format => :updates)
        list[index].find(".comment").text.should == updates[index].comment
      end
    end

    find(".total_backers").should have_content("3")

    within "#project_backers" do
      backers = project.backers.confirmed.order("confirmed_at DESC")
      list = all("li")
      list.should have(3).items
      list.each_index do |index|
        list[index].find("a")[:href].should match(/\/users\/#{backers[index].user.to_param}/)
      end
    end
  end

  scenario "As a logged user, but not the project owner, I should not be able to post project updates" do
    fake_login

    project = Factory(:project)
    visit project_path(project)
    verify_translations

    page.should have_css("#project_updates")

    within "#project_updates" do
      within 'h1' do
        page.should have_content "Atualizações (0)"
      end

      page.should have_no_css("form")
    end
  end

  scenario "As a project owner, I want to post project updates" do
    fake_login

    project = Factory(:project, user: user)
    visit project_path(project)
    verify_translations
    page.should have_css("#project_updates")

    within "#project_updates" do
      within 'h1' do
        page.should have_content "Atualizações (0)"
      end

      all(".collection_list li").should have(0).items
      fill_in "Título da atualização", with: "My title"
      fill_in "Texto da atualização", with: "My text"
      click_on "Enviar atualização"
    end

    visit project_path(project)
    verify_translations

    within "#project_updates" do
      within 'h1' do
        page.should have_content "Atualizações (1)"
      end

      all(".collection_list li").should have(1).items
      update = find(".collection_list li")
      update.find("h3").text.should == "My title"
      update.find(".comment").text.should == "My text"
    end
  end
end
