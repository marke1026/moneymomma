class Deposit < ActiveRecord::Base
  belongs_to :user
  
  validates_presence_of :paycheck_amount, :paycheck_frequency
  
  PAYCHECK_FREQUENCY = ["15th day of the month", "last day of the month", "both"]
  
  def deposit_dates
    middle_of_month = Date.parse("15.#{Date.today.month}.#{Date.today.year}")
    dates = []
    (1..6).each do |num|
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
  
end
