class CreateFoursquarePushes < ActiveRecord::Migration
  def self.up
    create_table :foursquare_pushes do |t|
      t.string :push_id
      t.string :push_created_at
      t.string :push_type
      t.string :push_time_zone

      t.timestamps
    end
  end

  def self.down
    drop_table :foursquare_pushes
  end
end
