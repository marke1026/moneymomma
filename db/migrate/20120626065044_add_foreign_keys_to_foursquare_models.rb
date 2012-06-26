class AddForeignKeysToFoursquareModels < ActiveRecord::Migration
  def self.up
    add_column :foursquare_venues, :foursquare_push_id, :integer
    add_column :foursquare_users, :foursquare_push_id, :integer
  end

  def self.down
    remove_column :foursquare_venues, :foursquare_push_id
    remove_column :foursquare_users, :foursquare_push_id
  end
end

