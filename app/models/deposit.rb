class Deposit < ActiveRecord::Base
  belongs_to :user
  has_many :transactions, :as => :payable
  
  validates_presence_of :paycheck_amount, :paycheck_frequency
  
  PAYCHECK_FREQUENCY = ["15th day of the month", "last day of the month", "both"]
  
  def deposit_dates
    middle_of_month = Date.parse("15.#{Date.today.month}.#{Date.today.year}")
    dates = []
    (1..10).each do |num|
      unless self.created_at.day > 15 and num == 1
        if paycheck_frequency == PAYCHECK_FREQUENCY[0] or paycheck_frequency == PAYCHECK_FREQUENCY[2]
          dates << middle_of_month
        end
      end
      if paycheck_frequency == PAYCHECK_FREQUENCY[1] or paycheck_frequency == PAYCHECK_FREQUENCY[2]
        dates << middle_of_month.end_of_month
      end
      # move date to next month
      middle_of_month = middle_of_month.next_month
    end
    return dates
  end
  
  def process_deposit
    t = self.transactions.new
    t.amount = self.paycheck_amount
    t.reference_number = Transaction.generate_reference_number
    t.status = true
    t.save
  end
  
  def self.generate_transactions_for_today
    self.all.select{|p| p.deposit_dates.include?(Date.today)}.each do |trans|
      trans.process_deposit
    end
  end
  
end
