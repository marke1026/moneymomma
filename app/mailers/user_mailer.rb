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
   
      depositss1 = user.deposits.all
      @payments1 = user.payments_for_next_six_months  

    if !depositss1.empty?
          @depositamount = depositss1.sum{ |p| p.paycheck_amount.to_i}
    else
          @depositamount = 0.to_i
    end

      @diffrence = @depositamount - @payments1[0]
      @paymentsobject =user.object_list_for_payments_for_next_six_months
  
    mail(:to => user.email, :subject => "Money Momma 5 day notification before your next paycheck deposit!")
    content_type "text/html"
  end
  
  def alert_on_paycheck(user)
    mail(:to => user.email, :subject => "Money Momma notifcation that your paycheck has been deposited!")
    content_type "text/html"
  end
end
