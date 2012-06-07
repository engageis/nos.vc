class ProjectsMailer < ActionMailer::Base
  include ERB::Util

  def start_project_email(name, about, when_, where, video, leader_name, more_info, goal, maximum_backers, how_works, contact, know_us_via, user, user_url)
    @name = h(name)
    @about = h(about).gsub("\n", "<br>").html_safe
    @when = h(when_)
    @where = h(where).gsub("\n", "<br>").html_safe
    @video = h(video)
    @leader_name = h(leader_name)
    @more_info = h(more_info).gsub("\n", "<br>").html_safe
    @goal = h(goal)
    @maximum_backers = h(maximum_backers)
    @how_works = h(how_works).gsub("\n", "<br>").html_safe
    @contact = contact
    @know_us_via = h(know_us_via).gsub("\n", "<br>").html_safe
    @user = user
    @user_url = user_url
    mail(:from => "#{I18n.t('site.name')} <#{I18n.t('site.email.system')}>", :to => I18n.t('site.email.projects'), :subject => I18n.t('projects_mailer.start_project_email.subject', :name => @user.name))
  end
end
