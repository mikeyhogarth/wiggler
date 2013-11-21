require 'spec_helper'

describe User do

  it "should have a first name and a last name" do
    user = create(:user)

    user.first_name = "Loki"
    user.last_name = "Beans"

    expect(user.full_name).to eq("Loki Beans")
  end

end
