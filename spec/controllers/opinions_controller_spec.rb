require 'spec_helper'
require 'json'

describe OpinionsController do
  before do
    @opinion = create(:opinion)
  end

  it "allows users to update their own opinion, respond with JSON representing the change" do
    sign_in @opinion.user
 
    put :update, :id => @opinion, :opinion => { :value => 5.0 }
    assigns(:opinion).should_not be_nil

    expect(response).to be_success
    parsed_json = JSON.parse(response.body)
    parsed_json.keys.should include("your_opinion", "average")
  end

  it "stops users from updating each others opinions" do
    login_as :user
    expect{ put :update, :id => @opinion }.to raise_error(RuntimeError)
  end

end
