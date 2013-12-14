class Wiggle < ActiveRecord::Base

  #Associations
  has_many :opinions
  
  #Scopes
  scope :current, -> { where("start < ? and end > ?", DateTime.now, DateTime.now) }
  scope :upcoming, -> { where("start > ? and start < ?", DateTime.now, DateTime.now + 1.week) }

  def average_opinion
    average_opinion = opinions.average :value 

    if average_opinion.nil?
      return 0
    else
      return average_opinion.round(1)
    end
  end

  def channel
    "/wiggles/#{id}"
  end

end
