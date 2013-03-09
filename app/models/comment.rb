class Comment < ActiveRecord::Base
  attr_accessible :text, :state_id

  belongs_to :ticket
  belongs_to :user
  belongs_to :state

  delegate :project, :to => :ticket

  validates :text, :presence => true

  after_create :set_ticket_state

  private
    def set_ticket_state
      self.ticket.state = self.state
      self.ticket.save!
    end
end