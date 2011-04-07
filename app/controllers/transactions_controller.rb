class TransactionsController < ApplicationController
  before_filter :require_user
  
  def index
    @trans = current_user.transactions
  end
  
end
