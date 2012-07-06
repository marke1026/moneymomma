class FoursquarepushController < ApplicationController

  skip_before_filter :verify_authenticity_token

  def notify
    
    user = params['user']
    fn = user['firstName']
    sms = Moonshado::Sms.new("18139577566", "Bam! " + fn + " " + user['lastName'] + " just checkin on Foursquare!")
    sms.deliver_sms
    sms = Moonshado::Sms.new("17278715066", "Bam! " + fn + " "  + user['lastName'] + " just checkin on Foursquare!")
    sms.deliver_sms
    FoursquareHandler.save_from_push(params)
    render :nothing => true
  end

end

