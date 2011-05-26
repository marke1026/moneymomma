desc "This task is called by the Heroku cron add-on"
task :cron => :environment do

   # Transaction.process_all_transactions_for_today
    puts "Inside Cron!"
    
    User.find(:all).each do |user|
      user.send_email_alerts
      user.send_mobile_alerts
    end

#      user = User.find(13)
#      user.send_email_alerts
#      user.send_mobile_alerts
end