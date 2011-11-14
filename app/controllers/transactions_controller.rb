class TransactionsController < ApplicationController
  before_filter :require_user, :except => [:index, :ask_momma, :company, :contact]
  
  def index
    @trans = current_user.transactions if current_user
  end
  
  def widget
    render :layout => false
  end
  
  def contact
    if params[:name].present? and params[:email].present? and params[:message].present?
      Contact.notification(params[:name], params[:email], params[:message]).deliver
      redirect_to root_url, :notice => "Thank you for contacting us. We will revert back soon."
    else
      redirect_to root_url, :alert => "All the fields in the contact form are required."
    end
  end
  
end
