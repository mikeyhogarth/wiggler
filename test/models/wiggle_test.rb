require 'test_helper'

class WiggleTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end

  test "averages" do
    w = Wiggle.new
    assert_equal 0, w.average_opinion

    w.opinions << Opinion.new(:value => 5)
    w.save!

    assert_equal 5, w.average_opinion 
  end

end
