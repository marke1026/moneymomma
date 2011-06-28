class TransactionsController < ApplicationController
  before_filter :require_user
  
  def index
    @trans = current_user.transactions
  end
  
  def widget
    render :layout => false
  end
  
end
