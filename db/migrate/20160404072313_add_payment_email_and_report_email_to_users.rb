class AddPaymentEmailAndReportEmailToUsers < ActiveRecord::Migration
  def change
    add_column :users, :payment_email, :string
    add_column :users, :report_email, :string
  end
end
