require 'spec_helper'

describe SessionsController do

  before do
   @request.env["devise.mapping"] = Devise.mappings[:user]
  end

  it "should render the login form" do
    get :new
    expect(response).to be_success
  end
  
  it "should allow a user to sign in" do 
    post :new, :user=>{:email=>"", :password=>"", :remember_me=>0}
    expect(response).to be_success
  end

end
