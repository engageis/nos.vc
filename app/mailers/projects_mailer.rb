class ProjectsMailer < ActionMailer::Base
  include ERB::Util

  def new_project(name, link, project, user)
    @name = name
    @link = link
    @project = project
    @user = user
    mail(:from => "#{I18n.t('site.name')} <#{I18n.t('site.email.system')}>", :to => I18n.t('site.email.projects'), :subject => I18n.t('projects_mailer.new_project.subject', :name => @user.name ))
  end
end
