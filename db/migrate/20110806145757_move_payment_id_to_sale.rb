class MovePaymentIdToSale < ActiveRecord::Migration
  def self.up
    remove_column :invoices, :paypal_payment_id
    add_column :sales, :paypal_payment_id, :string
  end

  def self.down
    add_column :invoices, :paypal_payment_id, :string
    remove_column :sales, :paypal_payment_id
  end
end
