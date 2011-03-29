class Payment < ActiveRecord::Base
  belongs_to :payee
  
  validates_presence_of :payee, :delivery_time, :amount
  
  DELIVERY_TIME = ["15th day of the month", "last day of the month", "both"]
  
  def transaction_dates
    middle_of_month = Date.parse("15.#{created_at.month}.#{created_at.year}")
    dates = []
    (1..number_of_payments.to_i+1).each do |num|
      break if dates.length >= number_of_payments.to_i
      unless self.created_at.day > 15 and num == 1
        if delivery_time == DELIVERY_TIME[0] or delivery_time == DELIVERY_TIME[2]
          dates << middle_of_month
        end
      end
      if delivery_time == DELIVERY_TIME[1] or delivery_time == DELIVERY_TIME[2]
        dates << middle_of_month.end_of_month
      end
      # move date to next month
      middle_of_month = middle_of_month.next_month
    end
    return dates
  end
  
end
