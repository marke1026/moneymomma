class AddFoursquareTokenToUsers < ActiveRecord::Migration
  def self.up
  	add_column :users, :foursquare_token, :text

  end

  def self.down
  	remove_column :users, :foursquare_token
  end
end
