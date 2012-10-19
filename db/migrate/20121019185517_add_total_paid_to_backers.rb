class AddTotalPaidToBackers < ActiveRecord::Migration
  def change
    add_column :backers, :total_paid, :decimal, :defaul => 0
  end
end
