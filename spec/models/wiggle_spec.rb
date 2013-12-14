require 'spec_helper'

describe Wiggle do

  it "Calculates the average of its opinions" do
    wiggle = create(:wiggle)

    wiggle.opinions << Opinion.new(:value => 1) 
    wiggle.opinions << Opinion.new(:value => 5) 
    wiggle.opinions << Opinion.new(:value => 10)
    
    # the above three should add up to 5.3 recurring
    expect(wiggle.average_opinion).to eq(5.3)
  end

  it "returns 0 if there are no opinions" do
    wiggle = create(:wiggle)
    expect(wiggle.opinions.count).to eq(0)
    expect(wiggle.average_opinion).to eq(0)
  end

  it "can tell you its channel" do
    wiggle = create(:wiggle)
    expect(wiggle.channel).to eq("/wiggles/#{wiggle.id}")
  end

end
