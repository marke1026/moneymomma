class TransactionsController < ApplicationController
  before_filter :require_user, :except => [:index, :ask_momma, :company]
  
  def index
    @trans = current_user.transactions if current_user
  end
  
  def widget
    render :layout => false
  end
  
end
