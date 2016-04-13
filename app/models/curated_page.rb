class CuratedPage < ActiveRecord::Base
  has_many :projects_curated_pages
  has_many :projects, :through => :projects_curated_pages

  validates_uniqueness_of :permalink
  validates_presence_of :permalink, :name, :logo, :banner

  scope :visible, where("visible is true")
  scope :not_visible, where("visible is not true")

  has_vimeo_video :video_url, :message => I18n.t('project.vimeo_regex_validation')

  mount_uploader :logo, LogoUploader
  mount_uploader :banner, LogoUploader

  auto_html_for :description do
    html_escape :map => {
      '&' => '&amp;',
      '>' => '&gt;',
      '<' => '&lt;',
      '"' => '"' }
    redcarpet :target => :_blank
    link :target => :_blank
  end

  def to_param
    "#{self.id}-#{self.name.parameterize}"
  end

end
