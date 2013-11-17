class Wiggle < ActiveRecord::Base

  has_many :opinions

  def average_opinion
    average_opinion = opinions.average :value 

    if average_opinion.nil?
      return 0
    else
      return average_opinion.round(2)
    end
  end
end
