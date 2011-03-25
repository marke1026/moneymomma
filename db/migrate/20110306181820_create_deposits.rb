class CreateDeposits < ActiveRecord::Migration
  def self.up
    create_table :deposits do |t|
      t.integer :user_id
      t.string :paycheck_amount
      t.string  :paycheck_frequency
      t.timestamps
    end
  end

  def self.down
    drop_table :deposits
  end
end
