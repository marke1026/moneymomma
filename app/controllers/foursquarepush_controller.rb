class FoursquarepushController < ApplicationController

  skip_before_filter :verify_authenticity_token

  def notify
    
    user = params['user']
    puts ">>>>User<<<<<"
    puts user.inspect
    puts ">>>>Params"
    puts params.inspect
    fp =  user['firstName'].to_s
    
    puts user['firstName'].to_s

    sms = Moonshado::Sms.new("18139577566", "Bam!" + fp.to_s + "  just checkin on Foursquare!")
    sms.deliver_sms
    sms = Moonshado::Sms.new("17278715066", "Bam! "  + fp + "just checkin on Foursquare!")
    sms.deliver_sms
    FoursquareHandler.save_from_push(params)
    render :nothing => true
  end

end

