require 'spec_helper'
require 'json'

describe WigglesController do
  before do
    login_as :user
    @wiggle = create :wiggle
  end

  it "responds successfully with an HTTP 200 status code for authenticated users" do
    get :show, :id => @wiggle
    expect(response).to be_success
    expect(response.status).to eq(200)
    assigns(:wiggle).should_not be_nil
    assigns(:your_opinion).should_not be_nil
  end

  it "denies access to unauthenticated users" do
    sign_out :user
    get :show, :id => @wiggle
    expect(response).not_to be_success
    expect(response.status).to eq(302)
  end

  it "renders the show template" do
    get :show, :id => @wiggle
    expect(response).to render_template("show")
  end
 
  it "returns average as json" do
    get :average, :id => @wiggle, :format => :json
    expect(response).to be_success

    parsed_json = JSON.parse(response.body)
    parsed_json.keys.should include("average")
 end

end
