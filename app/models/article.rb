class Article < ActiveRecord::Base
  belongs_to :user
  has_many :comments, :dependent => :destroy
  
  validates_presence_of :title, :description
  validates_uniqueness_of :title
  
  has_attached_file :avatar, :styles => { :medium => "200x118!", :small => "160x160#", :minor => "80x80#" },
                    :url  => "/assets/articles/:id/:style/:basename.:extension",
                    :path => "#{Rails.root}/public/assets/articles/:id/:style/:basename.:extension"

  validates_attachment_size :avatar, :less_than => 5.megabytes
  validates_attachment_content_type :avatar, :content_type => ['image/jpeg', 'image/png', 'image/jpg']
end
