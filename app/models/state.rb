class State < ActiveRecord::Base
  attr_accessible :background, :color, :name

  belongs_to :state

  def to_s 
    name
  end
end
