class PaymentsController < ApplicationController
  include OpenFlashChart
  before_filter :require_user
  
  def index
    @payments = Payment.find(:all, :conditions => {:payee_id => current_user.payees})
    @payees = current_user.payees.find(:all)
    @deposits = current_user.deposits.find(:all)
    @graph = Graph.new(bar_graph_payments_path, 1000, 500, :base_path => '/')
  end
  
  def new
    @payment = Payment.new
  end
  
  def create
    @payment = Payment.new(params[:payment])
    if @payment.save
      flash[:notice] = "Recurring Payment has been added successfully!"
      redirect_to payments_path
    else
      render :action => :new
    end
  end
  
  def edit
    @payment = Payment.find_by_id(params[:id])
  end
  
  def update
    @payment = Payment.find_by_id(params[:id])
    if @payment.update_attributes(params[:payment])
      flash[:notice] = "Recurring Payment updated!"
      redirect_to payments_path
    else
      render :action => :edit
    end
  end
  
  def destroy
    @payment = Payment.find_by_id(params[:id])
    @payment.destroy
    if request.xhr?
      render :update do |page|
        page.remove "payment_#{params[:id]}"
      end
    end
  end
  
  def bar_graph
    deposits = current_user.deposits_for_next_six_months
    
    payments = current_user.payments_for_next_six_months
    
    bar1 = Bar.new
    bar1.text = "Deposits"
    bar1.colour = '#818D9D'
    bar1.values = deposits
    
    bar2 = Bar.new
    bar2.text = "Payments"
    bar2.color = '#424581'
    bar2.values = payments
    
    x_axis = XAxis.new
    x_axis.labels = current_user.dates_for_next_six_months.map{|d| d.strftime('%d, %b')}
    x_axis.colour = '#818D9D'
          
    y_axis = YAxis.new
    y_axis.colour = '#818D9D'
    y_axis.set_range(0, 4000, 1000)
    
    chart = OpenFlashChart.new
    chart.add_element(bar1)
    chart.add_element(bar2)
    
    chart.x_axis = x_axis
    chart.y_axis = y_axis
    
    render :text => chart.to_s

  end
  
end
