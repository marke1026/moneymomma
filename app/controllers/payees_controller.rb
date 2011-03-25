class PayeesController < ApplicationController
  before_filter :require_user
  
  def index
  end
  
  def new
    @payee = Payee.new
  end
  
  def create
    @payee = current_user.payees.new(params[:payee])
    if @payee.save
      flash[:notice] = "Payee has been added successfully!"
      redirect_to payments_path
    else
      render :action => :new
    end
  end
  
  def edit
    @payee = current_user.payees.find_by_id(params[:id])
  end
  
  def update
    @payee = current_user.payees.find_by_id(params[:id])
    if @payee.update_attributes(params[:payee])
      flash[:notice] = "Payee has been updated!"
      redirect_to payments_path
    else
      render :action => :edit
    end
  end
  
  def destroy
    @payee = current_user.payees.find_by_id(params[:id])
    @payee.destroy
    if request.xhr?
      render :update do |page|
        page.remove "payee_#{params[:id]}"
      end
    end
  end
  
end
