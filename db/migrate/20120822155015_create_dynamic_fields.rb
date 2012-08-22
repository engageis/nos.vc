class CreateDynamicFields < ActiveRecord::Migration
  def change
    create_table :dynamic_fields do |t|
      t.string :input_name
      t.string :input_value
      t.boolean :required
      t.references :project

      t.timestamps
    end
    add_index :dynamic_fields, :project_id
  end
end
