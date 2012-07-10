class FoursquarepushController < ApplicationController

  skip_before_filter :verify_authenticity_token

  def notify
    
   user = JSON.parse(params['user'])
   checkin = JSON.parse(params['checkin'])


     venue = checkin['venue']
     puts venue
   #puts  v
    #user = params['user']
    fn =  user['firstName'].to_s
    ln = user['lastName'].to_s
    name = venue['name']


    sms = Moonshado::Sms.new("18139577566", "Bam! " + fn.to_s + " " + ln.to_s + "  just checked in at " + name.to_s)
    sms.deliver_sms
    sms = Moonshado::Sms.new("17278715066",  "Bam! " + fn.to_s + " " + ln.to_s + "  just checked in at " + name.to_s)
    sms.deliver_sms
    FoursquareHandler.save_from_push(params)

    puts FoursquareVenue.last.inspect
    
    render :nothing => true
  end

end

