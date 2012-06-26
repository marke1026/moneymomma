class FoursquarepushController < ApplicationController

  skip_before_filter :verify_authenticity_token

  def notify
    FoursquareHandler.save_from_push(params)
    render :nothing => true
  end

end

