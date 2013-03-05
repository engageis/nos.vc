# coding: utf-8

require File.expand_path(File.dirname(__FILE__) + '/acceptance_helper')

feature "Back project" do

  include Rails.application.routes.url_helpers

  before do
    @project = Factory(:project, visible: true)
    @rewards = [
      Factory(:reward, project: @project, minimum_value: 10, description: "$10 reward"),
      Factory(:reward, project: @project, minimum_value: 20, description: "$20 reward"),
      Factory(:reward, project: @project, minimum_value: 30, description: "$30 reward")
    ]
    # Create a state to select
    State.create! name: "Foo bar", acronym: "FB"
    Blog.stubs(:fetch_last_posts).returns([])
    ::Configuration.create!(name: "paypal_username", value: "usertest_api1.teste.com")
    ::Configuration.create!(name: "paypal_password", value: "HVN4PQBGZMHKFVGW")
    ::Configuration.create!(name: "paypal_signature", value: "AeL-u-Ox.N6Jennvu1G3BcdiTJxQAWdQcjdpLTB9ZaP0-Xuf-U0EQtnS")
  end


  scenario "As a user without credits, I want to back a project by clicking on the reward on the back project page, and pay using MoIP" do
    MoIP::Client.stubs(:checkout).returns({"Token" => "foobar"})
    MoIP::Client.stubs(:moip_page).returns("http://www.moip.com.br")
    fake_login

    visit project_path(@project)
    verify_translations

    click_on "Me inscrever"
    verify_translations
    current_path.should == new_project_backer_path(@project)

    choose "backer_reward_id_#{@rewards[2].id}"
    find("#backer_value")[:value].should == "30"
    choose "backer_reward_id_#{@rewards[1].id}"
    find("#backer_value")[:value].should == "20"
    choose "backer_reward_id_#{@rewards[0].id}"
    find("#backer_value")[:value].should == "10"

    choose "backer_reward_id_#{@rewards[1].id}"
    find("#backer_value")[:value].should == "20"

    Backer.count.should == 0

    click_on "selecionar"
    verify_translations
    current_path.should == review_project_backers_path(@project)
    page.should have_content("R$ 20")
    page.should have_content(@rewards[1].description)

    Backer.count.should == 1
    backer = Backer.first
    backer.payment_method.should == "MoIP"

    page.evaluate_script('jQuery.mask = function() { return true; }')

    fill_in "Nome completo", with: "Foo bar"
    fill_in "Email", with: "foo@bar.com"
    fill_in "CPF", with: "815.587.240-87"
    fill_in "CEP", with: "90050-004"
    fill_in "Endereço", with: "Lorem Ipsum"

    # Sleep to wait for the loading of zip code data
    #sleep 2

    fill_in "Número", with: "1010"
    fill_in "Complemento", with: "10"
    fill_in "Bairro", with: "Foo bar"
    fill_in "Cidade", with: "Foo bar"
    select "Foo bar", from: "Estado"
    fill_in "Celular", with: "(99)9999-9999"

    page.should have_css("#user_full_name.ok")
    page.should have_css("#user_email.ok")

    check "Eu li Como funciona e os Termos de uso do Nós.vc e estou de acordo."

    click_on "Confirmar"

    current_url.should match(/moip\.com\.br/)
    backer.reload
    backer.payment_method.should == "MoIP"

    visit thank_you_path
    verify_translations

    within 'head title' do
      page.should have_content("Muito obrigado")
    end

    page.should have_content "Você está dando vida a este encontro e vai receber uma confirmação por email assim que a inscrição for processada. Entre em contato!"

  end


  scenario "As a user with credits, I want to back a project using my credits" do

    fake_login
    Factory(:backer, :value => 20, :project => Factory(:project, :finished => true, :successful => false), :user => user)

    visit project_path(@project)
    verify_translations

    click_on "Me inscrever"
    verify_translations
    current_path.should == new_project_backer_path(@project)

    choose "backer_reward_id_#{@rewards[1].id}"
    check "Quero usar meus créditos para me inscrever."

    Backer.count.should == 1

    click_on "selecionar"
    verify_translations

    Backer.count.should == 2
    backer = Backer.last
    backer.payment_method.should == "MoIP"

    current_path.should == review_project_backers_path(@project)
    page.should have_content("R$ 20")
    page.should have_content(@rewards[1].description)

    page.should have_content("Esta inscrição será paga com seus créditos. Após a confirmação, você ficará com um saldo de R$ 0 em créditos para se inscrever em outros encontros.")

    find("#user_submit")[:disabled].should == "true"
    check "Eu li Como funciona e os Termos de uso do Nós.vc e estou de acordo."
    find("#user_submit")[:disabled].should be_nil
    click_on "Confirmar inscrição com créditos"

    current_path.should == thank_you_path
    backer.reload
    backer.payment_method.should == "Credits"
    backer.confirmed.should == true
    user.reload
    user.credits.should == 0

  end

  scenario "As a user, I want to back a project anonymously" do

    fake_login
    Factory(:backer, :value => 10, :project => Factory(:project, :finished => true, :successful => false), :user => user)

    visit project_path(@project)
    verify_translations

    click_on "Me inscrever"
    verify_translations

    choose "backer_reward_id_#{@rewards[0].id}"
    check "Quero usar meus créditos para me inscrever."

    check "Quero que minha inscrição seja anônima."

    Backer.count.should == 1

    click_on "selecionar"
    verify_translations

    Backer.count.should == 2
    backer = Backer.last
    backer.anonymous.should == true
  end

  scenario "I should not be able to access /thank_you if I not backed a project" do

    fake_login
    visit thank_you_path
    verify_translations

    current_path.should == root_path
    page.should have_css('.failure.wrapper')

  end

  scenario "As an unlogged user, before I back a project I need to be asked to log in" do

    visit project_path(@project)
    verify_translations

    click_on "Me inscrever"
    verify_translations

    verify_translations
    current_path == new_user_session_path

  end

end
