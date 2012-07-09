class FoursquarepushController < ApplicationController

  skip_before_filter :verify_authenticity_token

  def notify
    
   user = JSON.parse(params['user'])
   v = user['venue']
   puts v
    #user = params['user']
    #fn =  user['firstName'].to_s
    #ln = user['lastName'].to_s
   # venue  = JSON.parse(params['venue'])
  # v  = JSON.parse(params['venue'])
  # puts v['name'].to_s
  #  name = venue['name'].to_s
   #name  = 'test' 
    
   

    #sms = Moonshado::Sms.new("18139577566", "Bam! " + fn.to_s + " " + ln.to_s + "  just checked in at " + name.to_s)
    #sms.deliver_sms
    #sms = Moonshado::Sms.new("17278715066",  "Bam! " + fn.to_s + " " + ln.to_s + "  just checked in at " + name.to_s)
    #sms.deliver_sms
    FoursquareHandler.save_from_push(params)
    render :nothing => true
  end

end

