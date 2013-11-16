class Opinion < ActiveRecord::Base

  belongs_to :wiggle
  belongs_to :user

end
