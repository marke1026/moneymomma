class DepositsController < ApplicationController
  before_filter :require_user
  
  def index
  end
  
  def new
    @deposit = Deposit.new
  end
  
  def create
    @deposit = current_user.deposits.new(params[:deposit])
    if @deposit.save
      flash[:notice] = "Financial Info has been added successfully!"
      redirect_to payments_path
    else
      render :action => :new
    end
  end
  
  def edit
    @deposit = current_user.deposits.find_by_id(params[:id])
  end
  
  def update
    @deposit = current_user.deposits.find_by_id(params[:id])
    if @deposit.update_attributes(params[:deposit])
      flash[:notice] = "Financial Info updated!"
      redirect_to payments_path
    else
      render :action => :edit
    end
  end
  
  def destroy
    @deposit = current_user.deposits.find_by_id(params[:id])
    @deposit.destroy
    if request.xhr?
      render :update do |page|
        page.remove "deposit_#{params[:id]}"
      end
    end
  end
  
end
