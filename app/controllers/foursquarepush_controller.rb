class FoursquarepushController < ApplicationController

  skip_before_filter :verify_authenticity_token

  def notify
    
   user = JSON.parse(params['user'])

   # checkin = JSON.parse(params['checkin'])
   # venue = checkin['venue']
   # puts ">>>>>>>Venue<<<<<<<<<<<<"
   # puts venue.inspect
   # puts venue['name']

   #puts  v
    #user = params['user']
    #fn =  user['firstName'].to_s
    #ln = user['lastName'].to_s
   # venue  = JSON.parse(params['venue'])
  # v  = JSON.parse(params['venue'])
  # puts v['name'].to_s
  #  name = venue['name'].to_s
   #name  = 'test' 
    
   {"checkin"=>"{\"id\":\"4ffb83b2e4b02c1b10e52019\",\"createdAt\":1341883314,\"type\":\"checkin\",\"timeZone\":\"Asia\\/Dubai\",\"timeZoneOffset\":240,
    \"user\":{\"id\":\"10779936\",\"firstName\":\"Kaleem\",\"lastName\":\"Ullah\",\"relationship\":\"self\",\"photo\":\"https:\\/\\/is0.4sqi.net\\/userpix_thumbs\\/0E5N5MVVNKPSDBMM.jpg\",
    \"tips\":{\"count\":0},
    \"lists\":{\"groups\":[{\"type\":\"created\",\"count\":1,\"items\":[]}]},\"gender\":\"male\",\"homeCity\":\"Abu Dhabi, United Arab Emirates\",\"bio\":\"\",
    \"contact\":{\"email\":\"kaleembinkhan@gmail.com\",\"twitter\":\"kaleemullah\",\"facebook\":\"722104282\"}},
    \"venue\":{\"id\":\"4e1cfb791838f4ab743a96f4\",\"name\":\"Delma Street, Abu Dhabi\",\"contact\":{},
    \"location\":{\"lat\":24.464478109343794,\"lng\":54.37952937910345,\"city\":\"Abu Dhabi\",\"state\":\"Abu Dhabi\",\"country\":\"United Arab Emirates\",\"cc\":\"AE\"},\"categories\":[],\"verified\":false,\"stats\":{\"checkinsCount\":335,\"usersCount\":48,\"tipCount\":1},\"likes\":{\"count\":0,\"groups\":[]},\"beenHere\":{\"count\":0}}}", "user"=>"{\"id\":\"10779936\",\"firstName\":\"Kaleem\",\"lastName\":\"Ullah\",\"relationship\":\"self\",\"photo\":\"https:\\/\\/is0.4sqi.net\\/userpix_thumbs\\/0E5N5MVVNKPSDBMM.jpg\",\"tips\":{\"count\":0},\"lists\":{\"groups\":[{\"type\":\"created\",\"count\":1,\"items\":[]}]},\"gender\":\"male\",\"homeCity\":\"Abu Dhabi, United Arab Emirates\",\"bio\":\"\",\"contact\":{\"email\":\"kaleembinkhan@gmail.com\",\"twitter\":\"kaleemullah\",\"facebook\":\"722104282\"}}", "secret"=>"UYLATHW4ZW0RLUYMNTIVBZS3L0JL003WJ3HOCP0VRX1B3MJX", "action"=>"notify", "controller"=>"foursquarepush"}


    #sms = Moonshado::Sms.new("18139577566", "Bam! " + fn.to_s + " " + ln.to_s + "  just checked in at " + name.to_s)
    #sms.deliver_sms
    #sms = Moonshado::Sms.new("17278715066",  "Bam! " + fn.to_s + " " + ln.to_s + "  just checked in at " + name.to_s)
    #sms.deliver_sms
    FoursquareHandler.save_from_push(params)
    puts FoursquareVenue.last.inspect
    render :nothing => true
  end

end

