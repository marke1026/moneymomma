class FoursquarepushController < ApplicationController

  skip_before_filter :verify_authenticity_token

  def notify
    sms = Moonshado::Sms.new("18139577566", "This is a test Foursquare checkin notifcation")
    sms.deliver_sms
    sms = Moonshado::Sms.new("17278715066", "This is a test Foursquare checkin notifcation")
    sms.deliver_sms
    FoursquareHandler.save_from_push(params)
    render :nothing => true
  end

end

