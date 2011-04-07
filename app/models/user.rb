class User < ActiveRecord::Base
  acts_as_authentic
  
  validates_presence_of :first_name
  
  has_many :payees
  has_many :payments, :through => :payees
  has_many :deposits
  
  def activate!
    self.active = true
    save
  end
  
  def sex
    self.gender == true ? "Male" : "Female"
  end
  
  def deliver_activation_instructions!
    reset_perishable_token!
    UserMailer.activation_instructions(self).deliver
  end

  def deliver_welcome!
    reset_perishable_token!
    UserMailer.welcome(self).deliver
  end
  
  def deliver_password_reset_instructions!  
    reset_perishable_token!  
    UserMailer.password_reset_instructions(self).deliver
  end

  def payments_for_next_six_months
    payment_collection = []
    payments = Payment.find_all_by_payee_id(payees.map{|p| p.id})
    dates_for_next_six_months.each do |date|
      selected_payments = payments.select{ |p| p.transaction_dates.include?(date) }
      payment_collection << selected_payments.sum{ |p| p.amount.to_i}
    end
    return payment_collection
  end

  def deposits_for_next_six_months
    deposit_collection = []
    deposits = self.deposits.all
    dates_for_next_six_months.each do |date|
      selected_deposits = deposits.select{ |p| p.deposit_dates.include?(date) }
      deposit_collection << selected_deposits.sum{ |p| p.paycheck_amount.to_i}
    end
    return deposit_collection
  end

  def dates_for_next_six_months
    middle_of_month = Date.parse("15.#{Date.today.month}.#{Date.today.year}")
    dates = []
    (1..10).each do |x|
      dates << middle_of_month unless Date.today.day > 15 and x == 1
      end_of_month = middle_of_month.end_of_month
      dates << end_of_month
      # move date to next month
      middle_of_month = middle_of_month.next_month
    end
    return dates
  end
  
  def transactions
    p = self.payments.all(:include => "transactions")
    p.map{|a| a.transactions}.flatten
  end
    
  
end
