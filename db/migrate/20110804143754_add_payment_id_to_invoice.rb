class AddPaymentIdToInvoice < ActiveRecord::Migration
  def self.up
    add_column :invoices, :paypal_payment_id, :string
  end

  def self.down
    remove_column :invoices, :paypal_payment_id
  end
end
