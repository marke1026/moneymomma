class RemoveSuffixFromPayments < ActiveRecord::Migration
  def self.up
    remove_column :payments, :suffix
  end

  def self.down
    add_column :payments, :suffix, :string
  end
end
