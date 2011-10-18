class Comment < ActiveRecord::Base
  belongs_to :article
  
  validates_presence_of :name, :email, :description
end
