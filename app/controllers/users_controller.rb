class UsersController < ApplicationController
  before_filter :require_no_user, :only => [:new, :create]
  before_filter :require_user, :only => [:show, :edit, :update, :email_alert, :foursquare_callback]
  
  def new
    @user = User.new
    render :layout => "login"
  end
  
  def create
    @user = User.new(params[:user])
    if @user.save_without_session_maintenance
      @user.deliver_activation_instructions!
      flash[:notice] = "Your account has been created. Please check your e-mail for your account activation instructions!"
      redirect_to new_user_session_path
    else
      render :action => :new, :layout => "login"
    end
  end
  
  def show
    @user = @current_user
    @merchant = initialize_foursquare
  end

  def edit
    @user = @current_user
  end
  
  def update
    @user = @current_user # makes our views "cleaner" and more consistent
    if @user.update_attributes(params[:user])
      flash[:notice] = "Account updated!"
      redirect_to user_path(@user)
    else
      render :action => :edit
    end
  end
  
  def foursquare_callback
    merchant = initialize_foursquare
    access_token = merchant.access_token(params[:code], CALLBACK_URL)

    @user = @current_user
    if @user.update_attribute('foursquare_token', access_token)
      flash[:notice] = "Foursquare information saved successfully!"
      redirect_to user_path(@user)
    else  
      render :text => 'failed'
    end  
  end  

  def email_alert
    @user = @current_user
  end
  
  def initialize_foursquare
    Foursquare::Merchant::Consumer.new(CLIENT_ID, CLIENT_SECRET_ID)
  end  
end