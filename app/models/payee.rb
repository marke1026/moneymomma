class Payee < ActiveRecord::Base
  belongs_to :user
  has_many :payments
  
  validates_presence_of :name, :account_number
  validates_uniqueness_of :name, :account_number, :scope => :user_id
  
end
