desc "This task is called by the Heroku cron add-on"
task :cron => :environment do

    Transaction.process_all_transactions_for_today
    
    User.find(:all).each do |user|
      user.send_email_alerts
    end

end