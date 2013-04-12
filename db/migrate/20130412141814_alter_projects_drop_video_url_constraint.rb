require 'sexy_pg_constraints'
class AlterProjectsDropVideoUrlConstraint < ActiveRecord::Migration
  def up
    constrain :projects do |t|
      t.video_url :not_blank => false
    end
    execute "
    ALTER TABLE projects ALTER video_url DROP NOT NULL;
    ALTER TABLE projects DROP CONSTRAINT projects_video_url_not_blank;
    "
  end

  def down
    constrain :projects do |t|
      t.video_url :not_blank => true
    end
    execute "
    ALTER TABLE projects ALTER video_url SET NOT NULL;
    ALTER TABLE projects ADD  projects_video_url_not_blank CHECK(video_url <> '');
    "
  end
end
