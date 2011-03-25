class CreatePayments < ActiveRecord::Migration
  def self.up
    create_table :payments do |t|
      t.integer :payee_id, :null=>false
      t.string  :delivery_time
      t.string  :suffix
      t.string  :amount
      t.string  :number_of_payments
      t.timestamps
    end
  end

  def self.down
    drop_table :payments
  end
end
