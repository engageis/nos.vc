class AddTotalPaidToBackers < ActiveRecord::Migration
  def change
    add_column :backers, :total_paid, :float
  end
end
