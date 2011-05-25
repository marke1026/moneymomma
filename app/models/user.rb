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
    puts "11-------------#{payments.count}----#{dates_for_next_six_months}"
    dates_for_next_six_months.each do |date|
      selected_payments = payments.select{ |p| p.transaction_dates.include?(date) }
       puts "111111==@@@@@@@@@@@@@2 #{selected_payments.count}"
      payment_collection << selected_payments.sum{ |p| p.amount.to_i}
    end
    return payment_collection
  end

  #Added by sandeep
  def  object_list_for_payments_for_next_six_months
    payment_collection = []
    payments = Payment.find_all_by_payee_id(payees.map{|p| p.id})
    puts "sadeep new 11-------------#{payments.count}----#{dates_for_next_six_months}"
    dates_for_next_six_months.each do |date|
      selected_payments = payments.select{ |p| p.transaction_dates.include?(date) }
      puts "sandeep new 22------------- #{selected_payments.count}"
     # payment_collection << selected_payments.sum{ |p| p.amount.to_i}
     payment_collection << selected_payments
    end
    return payment_collection
  end




  def deposits_for_next_six_months
    deposit_collection = []
    deposits = self.deposits.all
    dates_for_next_six_months.each do |date|
      selected_deposits = deposits.select{ |p| p.deposit_dates.include?(date) }
     puts "22222222==@@@@@@@@@@@@@2 #{selected_deposits.count}"
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
  
  def send_email_alerts
#    if self.email_alert?
#     puts "self.email_delivery_time-------- #{self.email_delivery_time}"
#      if self.email_delivery_time == "5 days before Paycheck"
        send_email_alerts_before_paycheck
#      elsif self.email_delivery_time == "5 days before and on Paycheck day"
#        send_email_alerts_before_paycheck
#        send_email_alerts_on_paycheck
#      end
#    end
  end
  
  def send_email_alerts_before_paycheck

#    dates_before_payments = self.payments.all.map{|p| p.transaction_dates}.flatten.map{|b| b-5}
#   puts "===dates_before_payments=============#{dates_before_payments}============"
#    dates_before_deposits = self.deposits.all.map{|d| d.deposit_dates}.flatten.map{|c| c-5}
#   puts "===dates_before_deposits=============#{dates_before_deposits}============"
#     if dates_before_payments.include?(Date.today) || dates_before_deposits.include?(Date.today)
     UserMailer.alert_before_paycheck(self).deliver
#    else
#      return false
#    end
  end
  
  def send_email_alerts_on_paycheck
    dates_of_payments = self.payments.all.map{|p| p.transaction_dates}.flatten
    dates_of_deposits = self.deposits.all.map{|d| d.deposit_dates}.flatten
        puts "222222222222^^^^^^^^^^^^^^^"
        puts "again dates_of_payments #{dates_of_payments}----#{dates_of_deposits} "
    if dates_of_payments.include?(Date.today) || dates_of_deposits.include?(Date.today)
     puts "11111^^^^^^^^^^^^^^^"
      UserMailer.alert_on_paycheck(self).deliver
    else
      return false
    end
  end
  
  def send_mobile_alerts
   puts "11---------- mobile Alert"
    if self.mobile_alert? && self.mobile?
     puts "22---------- mobile Alert"
      if self.sms_delivery_time == "5 days before Paycheck"
          puts "33---------- mobile Alert"
        send_mobile_alerts_before_paycheck
      elsif self.sms_delivery_time == "5 days before and on Paycheck day"
        puts "44---------- mobile Alert"
        send_mobile_alerts_before_paycheck
        send_mobile_alerts_on_paycheck
      end
    end
  end
  
  def send_mobile_alerts_before_paycheck
   puts "55---------- mobile Alert"
#    dates_before_payments = self.payments.all.map{|p| p.transaction_dates}.flatten.map{|b| b-4}
#    dates_before_deposits = self.deposits.all.map{|d| d.deposit_dates}.flatten.map{|c| c-4}
   dates_before_payments = self.payments.all.map{|p| p.transaction_dates}.flatten.map{|b| b-5}
   dates_before_deposits = self.deposits.all.map{|d| d.deposit_dates}.flatten.map{|c| c-5}
    puts "66 ke pahile wala---------- mobile Alert------#{dates_before_payments}----#{dates_before_deposits}"
    if dates_before_payments.include?(Date.today) || dates_before_deposits.include?(Date.today)
     puts "66---------- mobile Alert"
      sms = Moonshado::Sms.new(self.mobile, "You have 5 days left for payments, Please login to mymoneymomma to manage things.")
      sms.deliver_sms
    else
      return false
    end
  end
  
  def send_mobile_alerts_on_paycheck
    puts "77---------- mobile Alert"
    dates_of_payments = self.payments.all.map{|p| p.transaction_dates}.flatten
    dates_of_deposits = self.deposits.all.map{|d| d.deposit_dates}.flatten
    puts "88 ke pahile wala---------- mobile Alert------#{dates_of_payments}----#{dates_of_deposits}"
    if dates_of_payments.include?(Date.today) || dates_of_deposits.include?(Date.today)
     puts "88---------- mobile Alert"
      sms = Moonshado::Sms.new(self.mobile, "Today is your Payment day, Please login to mymoneymomma to manage things.")
      sms.deliver_sms
    else
      return false
    end
  end

end
