class Contact < ActionMailer::Base
  if Rails.env == 'development'
    default :from => "from@example.com"
    default_url_options[:host] = "localhost:3000"
    ADMIN_RECIPIENTS = ['notify@mymoneymomma.com']
  end
  
  if Rails.env == 'production'
    default :from => "mymoneymomma.com"
    default_url_options[:host] = "mymoneymomma.com"
    ADMIN_RECIPIENTS = ['notify@mymoneymomma.com']
  end
  
  def notification(name, email, message)
    @name = name
    @message = message
    @email = email
    mail :to => ADMIN_RECIPIENTS,
         :from => email,
         :subject => "Contact request from: #{name}"
  end
end