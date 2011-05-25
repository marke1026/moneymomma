class UserMailer < ActionMailer::Base
  if Rails.env == 'development'
    default :from => "from@example.com"
    default_url_options[:host] = "localhost:3000"
  end
  
  if Rails.env == 'production'
    default :from => "mymoneymomma.com"
    default_url_options[:host] = "mymoneymomma.com"
  end
  
  def activation_instructions(user)
    @account_activation_url = activate_url(user.perishable_token)
    @user1 = user
    mail(:to => user.email, :subject => "Money Momma Activation Instructions")
    content_type "text/html"
  end
  
  def welcome(user)
    mail(:to => user.email, :subject => "Welcome to Money Momma. You are on your way to take command of your finances forever!")
    @root_url = root_url
    content_type "text/html"
  end
  
  def password_reset_instructions(user)   
    @edit_password_reset_url = edit_password_reset_url(user.perishable_token)
    content_type "text/html"
    mail(:to => user.email, :subject => "Money Momma Password Reset Instructions")
  end
  
  def alert_before_paycheck(user)
    # Added by sandeep
      @depositss1 = user.deposits.all
             # puts "77777777777777+++++++++++++++-----#{@depositss1[0].paycheck_amount}-----#{@depositss1.inspect}--"
              # @deposits1 = user.deposits_for_next_six_months
     @payments1 = user.payments_for_next_six_months
   # @diffrence = @deposits1[18] - @payments1[0]
     @diffrence = @depositss1[0].paycheck_amount.to_i - @payments1[0]
     @paymentsobject =user.object_list_for_payments_for_next_six_months
    puts " +++++++++++++++-----#{@paymentsobject[0]}-------"
 
    mail(:to => user.email, :subject => "paycheck alert before 5 days")
    content_type "text/html"
  end
  
  def alert_on_paycheck(user)
    mail(:to => user.email, :subject => "paycheck alert")
    content_type "text/html"
  end
end
