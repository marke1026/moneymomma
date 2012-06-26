class CreateFoursquareUsers < ActiveRecord::Migration
  def self.up
    create_table :foursquare_users do |t|
      t.string :foursquare_user_id
      t.string :last_name
      t.string :first_name
      t.string :photo
      t.string :gender
      t.string :home_city
      t.string :relationship

      t.timestamps
    end
  end

  def self.down
    drop_table :foursquare_users
  end
end
