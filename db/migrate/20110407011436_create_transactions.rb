class CreateTransactions < ActiveRecord::Migration
  def self.up
    create_table :transactions do |t|
      t.integer :amount
      t.integer :payable_id
      t.string :payable_type
      t.string :reference_number
      t.boolean :status
      t.timestamps
    end
  end

  def self.down
    drop_table :transactions
  end
end
