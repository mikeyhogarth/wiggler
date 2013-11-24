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
    assigns(:opinion).should_not be_nil
  end

  it "renders the show template" do
    get :show, :id => @wiggle
    expect(response).to render_template("show")
  end

end
