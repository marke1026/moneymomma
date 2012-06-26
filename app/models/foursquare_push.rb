class FoursquarePush < ActiveRecord::Base

  has_one :foursquare_user, :dependent => :destroy
  has_one :foursquare_venue, :dependent => :destroy

end

