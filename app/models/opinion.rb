class Opinion < ActiveRecord::Base
  belongs_to :wiggle
  belongs_to :user

  before_save do
    value = value.round(2) if value
  end
end
