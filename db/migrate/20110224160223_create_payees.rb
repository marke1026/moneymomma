class CreatePayees < ActiveRecord::Migration
  def self.up
    create_table :payees do |t|
      t.string :name, :null => false
      t.integer :user_id, :null => false
      t.string :address_1
      t.string :address_2
      t.string :city
      t.string :state
      t.string :zipcode
      t.string :phone
      t.string :name_on_bill
      t.string :account_number
      t.string :nick_name
      t.timestamps
    end
  end

  def self.down
    drop_table :payees
  end
end
