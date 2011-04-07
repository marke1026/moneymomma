class Transaction < ActiveRecord::Base
  belongs_to :payable, :polymorphic => true
  
  def self.generate_reference_number
    # Time.now.to_f.to_s + rand.to_s
    Digest::SHA1.hexdigest(Time.now.to_s + rand.to_s)
  end
  
  def self.process_all_transactions_for_today
    Payment.generate_transactions_for_today
    Deposit.generate_transactions_for_today
  end
end
