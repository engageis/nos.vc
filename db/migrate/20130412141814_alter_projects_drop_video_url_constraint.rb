require 'sexy_pg_constraints'
class AlterProjectsDropVideoUrlConstraint < ActiveRecord::Migration
  def up
    execute "ALTER TABLE projects ALTER video_url DROP NOT NULL;"
  end

  def down
    execute "ALTER TABLE projects ALTER video_url SET NOT NULL;"
  end
end
