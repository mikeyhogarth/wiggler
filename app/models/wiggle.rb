class Wiggle < ActiveRecord::Base

  has_many :opinions

  def average_opinion
    average_value = opinions.average :value

    if(average_value.nil?)
      0
    else
      average_value.ceil 1
    end
  end
end
