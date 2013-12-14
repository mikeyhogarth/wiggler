require 'spec_helper'

describe HomeController do

  before do
    # Eventually we will not need this login for the home page.
    login_as :user
  end

  it "responds successfully with an HTTP 200 status code for authenticated users" do
    get :index
    expect(response).to be_success
    expect(response.status).to eq(200)
    assigns(:current_wiggles).should_not be_nil
    assigns(:upcoming_wiggles).should_not be_nil
  end

  it "renders the index template" do
    get :index
    expect(response).to render_template("index")
  end

end
