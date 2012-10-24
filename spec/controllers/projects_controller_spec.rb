#encoding:utf-8
require 'spec_helper'

describe ProjectsController do
  render_views
  subject{ response }

  describe "GET show" do
    context "when we have permalink and do not pass permalink in the querystring" do
      let(:project){ Factory(:project, :permalink => 'test') }
      before{ get :show, :id => project, :locale => :pt }
      it{ should redirect_to project_by_slug_path(project.permalink) }
    end

    context "when we do not have permalink and do not pass permalink in the querystring" do
      let(:project){ Factory(:project, :permalink => nil) }
      before{ get :show, :id => project, :locale => :pt }
      it{ should be_success }
    end
  end

  describe "POST send_mail" do
    let(:project){ Factory(:project) }
    let(:name){ project.name }
    let(:user){ project.user }

    before do
      controller.stubs(:current_user).returns(user)
      email_subject = I18n.t('project.start.email_subject', :locale => user.locale)
      email_text = I18n.t('project.start.email_text',
                          :facebook => I18n.t('site.facebook', :locale => user.locale),
                          :twitter => "http://twitter.com/#{I18n.t('site.twitter', :locale => user.locale)}",
                          :blog => I18n.t('site.blog', :locale => user.locale),
                          :explore_link => explore_url,
                          :email => (I18n.t('site.email.contact', :locale => user.locale)),
                          :locale => user.locale,
                          :help => (I18n.t('site.help', :locale => user.locale)))
      notification_text = I18n.t('project.start.notification_text', :locale => user.locale)
      Notification.expects(:create).with(:user => user, :text => notification_text, :email_subject => email_subject, :email_text => email_text)
      post :send_mail, :locale => :pt
    end

    it{ should redirect_to root_path }
  end

  describe "private rewards" do
    before do
      @project = Factory(:project, :permalink => nil)
      @reward = Factory(:reward, :project => @project)
      @reward_with_token = Factory(:reward, :project => @project, :private => true)
    end

    describe "without token param" do
      it "should have only one reward" do
        get :show, :id => @project, :locale => :pt
        assigns(:rewards).should have(1).item
        assigns(:rewards).should == [@reward]
      end
    end

    describe "with token param" do
      it "should have only one reward" do
        get :show, :id => @project, :locale => :pt, :token => @reward_with_token.token
        page.should redirect_to @project
        session[:token].should == @reward_with_token.token

        get :show, :id => @project, :locale => :pt
        assigns(:rewards).should have(2).items
        assigns(:rewards).should == [@reward_with_token, @reward]
      end
    end
  end
end
