class Project < ActiveRecord::Base

  attr_accessible :name, :description
  validates :name, :presence => true
  has_many :tickets, :dependent => :delete_all
end
