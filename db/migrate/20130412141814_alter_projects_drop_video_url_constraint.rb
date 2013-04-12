require 'sexy_pg_constraints'
class AlterProjectsDropVideoUrlConstraint < ActiveRecord::Migration
  def up
    execute "
    ALTER TABLE projects ALTER video_url DROP NOT NULL;
    "
    constrain :projects do |t|
      t.video_url :not_blank => false
    end

  end

  def down
    execute "
    ALTER TABLE projects ALTER video_url SET NOT NULL;
    "
    constrain :projects do |t|
      t.video_url :not_blank => true
    end
  end
end
