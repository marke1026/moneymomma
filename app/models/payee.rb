class Payee < ActiveRecord::Base
  belongs_to :user
  has_many :payments
  
  validates_presence_of :name, :account_number
end
