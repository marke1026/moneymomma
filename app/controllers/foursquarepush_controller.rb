class FoursquarepushController < ApplicationController

  def notify
    FoursquareHandler.save_from_push(params)
    render :nothing => true
  end

end

