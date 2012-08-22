class CreateDynamicValues < ActiveRecord::Migration
  def change
    create_table :dynamic_values do |t|
      t.references :dynamic_field
      t.references :backer
      t.string :value

      t.timestamps
    end
    add_index :dynamic_values, :dynamic_field_id
    add_index :dynamic_values, :backer_id
  end
end
