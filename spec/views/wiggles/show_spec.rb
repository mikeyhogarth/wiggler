require 'spec_helper'

describe 'wiggles/show.html.haml' do

  before do
    assign(:wiggle, create(:wiggle))
  end

  it 'displays a gauge and some opinion controls for logged in users' do
    assign(:opinion, create(:opinion))
    login_as :user

    render 
    rendered.should have_selector(".wiggle")
    rendered.should have_selector(".your-opinion-controls")
  end

  it 'displays only a gauge for non-logged in users' do
    render    
    rendered.should have_selector(".wiggle")
    rendered.should_not have_selector(".your-opinion-controls")
  end

end
