class UserMailer < ActionMailer::Base
  if Rails.env == 'development'
    default :from => "from@example.com"
    default_url_options[:host] = "localhost:3000"
  end
  
  if Rails.env == 'production'
    default :from => "mymoneymomma.heroku.com"
    default_url_options[:host] = "mymoneymomma.com"
  end
  
  def activation_instructions(user)
    @account_activation_url = activate_url(user.perishable_token)
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
end
