class AddColumnsToUsersTable < ActiveRecord::Migration
  def self.up
    add_column :users, :secondry_email, :string
    add_column :users, :mobile, :string
    add_column :users, :email_delivery_time, :string
    add_column :users, :sms_delivery_time, :string
    add_column :users, :email_alert, :boolean
    add_column :users, :mobile_alert, :boolean
  end

  def self.down
    remove_column :users, :mobile_alert
    remove_column :users, :email_alert
    remove_column :users, :sms_delivery_time
    remove_column :users, :email_delivery_time
    remove_column :users, :mobile
    remove_column :users, :secondry_email
  end
end
