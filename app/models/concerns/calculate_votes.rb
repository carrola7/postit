module CalculateVotes
  extend ActiveSupport::Concern

  def total_votes
    votes_up - votes_down
  end
  
  def votes_up
    self.votes.where(vote: true).size
  end
  
  def votes_down
    self.votes.where(vote: false).size    
  end
end