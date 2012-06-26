class FoursquareHandler

  class << self

    def save_from_push(params)
      Rails.logger.error params.to_s
      fp = FoursquarePush.new(
        :push_id => params['id'],
        :push_created_at => params['createdAt'],
        :push_type => params['type'],
        :push_time_zone => params['timeZone']
      )
      user = params['user']
      fp.build_foursquare_user(
        :foursquare_user_id => user['id'],
        :last_name => user['firstName'],
        :first_name => user['lastName'],
        :photo => user['photo'],
        :gender => user['gender'],
        :home_city => user['homeCity'],
        :relationship => user['relationship']
      )
      venue = params['venue']
      fp.build_foursquare_venue(
        :venue_id => venue['id'],
        :venue_name => venue['name']
      )
      fp.save
    end

  end

end

# Sample Foursquare Push Response
#
#  {
#      "id": "4e6fe1404b90c00032eeac34",
#      "createdAt": 1315955008,
#      "type": "checkin",
#      "timeZone": "America/New_York",
#      "user": {
#          "id": "1",
#          "firstName": "Jimmy",
#          "lastName": "Foursquare",
#          "photo": "https://foursquare.com/img/blank_boy.png",
#          "gender": "male",
#          "homeCity": "New York, NY",
#          "relationship": "self"
#      },
#      "venue": {
#          "id": "4ab7e57cf964a5205f7b20e3",
#          "name": "foursquare HQ",
#          "contact": {
#              "twitter": "foursquare"
#          },
#          "location": {
#              "address": "East Village",
#              "lat": 40.72809214560253,
#              "lng": -73.99112284183502,
#              "city": "New York",
#              "state": "NY",
#              "postalCode": "10003",
#              "country": "USA"
#          },
#          "categories": [
#              {
#                  "id": "4bf58dd8d48988d125941735",
#                  "name": "Tech Startup",
#                  "pluralName": "Tech Startups",
#                  "shortName": "Tech Startup",
#                  "icon": "https://foursquare.com/img/categories/building/default.png",
#                  "parents": [
#                      "Professional & Other Places",
#                      "Offices"
#                  ],
#                  "primary": true
#              }
#          ],
#          "verified": true,
#          "stats": {
#              "checkinsCount": 7313,
#              "usersCount": 565,
#              "tipCount": 128
#          },
#          "url": "http://foursquare.com"
#      }
#  }

