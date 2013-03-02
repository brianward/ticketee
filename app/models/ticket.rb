class Ticket < ActiveRecord::Base
  attr_accessible :title, :description, :asset

  has_attached_file :asset
  belongs_to :project
  belongs_to :user
  
  validates :title, :presence => true
  validates :description, :presence => true, :length => { :minimum => 10 }
end
