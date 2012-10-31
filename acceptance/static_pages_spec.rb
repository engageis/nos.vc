# coding: utf-8

require File.expand_path(File.dirname(__FILE__) + '/acceptance_helper')

feature "Static Pages Feature", :driver => :selenium do

  scenario "I visit the guidelines page" do
    visit homepage
    click_link 'Como funciona'
    verify_translations
    current_path.should == guidelines_path

    within 'head title' do
      page.should have_content("Como funciona")
    end

    within '.title' do
      page.should have_content("Aprenda e ensine ao lado de pessoas apaixonadas pelas mesmas coisas que você.")
    end
  end

  scenario "I visit the terms of use page" do
    visit homepage
    click_link 'Termos de Uso'
    verify_translations
    current_path.should == terms_path

    within 'head title' do
      page.should have_content("Termos de uso")
    end

    within '.title' do
      page.should have_content("Termos de uso")
    end
  end

  scenario "I visit the privacy policy page" do
    visit homepage
    click_link 'Política de Privacidade'
    verify_translations
    current_path.should == privacy_path

    within 'head title' do
      page.should have_content("Política de privacidade")
    end

    within '.title' do
      page.should have_content("Política de privacidade")
    end
  end

  scenario "I visit the about page" do
    visit homepage
    click_link 'Sobre'
    verify_translations
    current_path.should == about_us_path

    within 'head title' do
      page.should have_content("Sobre Nós.vc")
    end

    within '.title' do
      page.should have_content("Acreditamos que aprendizado tem que ser um processo inspirador.")
    end
  end

  scenario "I visit the contact page" do
    visit homepage
    click_link 'Contato'
    verify_translations
    current_path.should == contact_path

    within 'head title' do
      page.should have_content("Contato")
    end

    within '.title' do
      page.should have_content("Vem falar com a gente")
    end
  end

end
