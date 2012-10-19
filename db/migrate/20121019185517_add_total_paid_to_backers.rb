class AddTotalPaidToBackers < ActiveRecord::Migration
  def change
    add_column :backers, :total_paid, :float, :defaul => 0
  end
end
