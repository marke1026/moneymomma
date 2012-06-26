require 'faraday'

conn = Faraday.new(:url => 'http://localhost:3000') do |faraday|
  faraday.request  :url_encoded             # form-encode POST params
  #faraday.response :logger                  # log requests to STDOUT
  faraday.adapter  Faraday.default_adapter  # make requests with Net::HTTP
end

## POST ##

# post payload as JSON instead of "www-form-urlencoded" encoding:
conn.post do |req|
  req.url '/foursquarepush'
  req.headers['Content-Type'] = 'application/json'
  req.body = <<-eos
    {
      "id":"4fe963a64fc664298edf7eb4",
      "createdAt":1340695462,
      "type":"checkin",
      "shout":"I'm in your consumers, testing your push API!",
      "timeZone":"UTC",
      "timeZoneOffset":0,
      "user":{
        "id":"1",
        "firstName":"Jimmy",
        "lastName":"Foursquare",
        "relationship":"self",
        "photo":"https:\/\/is0.4sqi.net\/userpix_thumbs\/S54EHRPJAHQK0VHP.jpg",
        "tips":{"count":0},
        "lists":
          {"groups":
            [
              { "type":"created",
                "count":1,
                "items":[]}]
           },
        "gender":"male",
        "homeCity":"New York, NY",
        "bio":"",
        "contact":{"email":"accounts+foursquare@foursquare.com"}
      },
      "venue":{
        "id":"4ef0e7cf7beb5932d5bdeb4e",
        "name":"foursquare HQ",
        "contact":{"twitter":"foursquare"},
        "location":{"address":"568 Broadway (10th Fl)",
        "crossStreet":"at Prince St.",
        "lat":40.72438048356713,
        "lng":-73.9974045753479,
        "postalCode":"10012",
        "city":"New York",
        "state":"NY",
        "country":"United States",
        "cc":"US"
      },
      "categories":
        [
         {"id":"4bf58dd8d48988d125941735",
          "name":"Tech Startup",
          "pluralName":"Tech Startups",
          "shortName":"Tech Startup",
          "icon":"https:\/\/foursquare.com\/img\/categories\/shops\/technology.png",
          "parents":["Professional & Other Places","Offices"],
          "primary":true}
        ],
      "verified":true,
      "stats":{"checkinsCount":12029,"usersCount":2779,"tipCount":97},
      "url":"https:\/\/foursquare.com",
      "likes":{"count":0,"groups":[]},"beenHere":{"count":0}}
    }
  eos

end

