class CreateFoursquareVenues < ActiveRecord::Migration
  def self.up
    create_table :foursquare_venues do |t|
      t.string :venue_id
      t.string :venue_name

      t.timestamps
    end
  end

  def self.down
    drop_table :foursquare_venues
  end
end
