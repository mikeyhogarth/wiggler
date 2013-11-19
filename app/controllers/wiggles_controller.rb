class WigglesController < ApplicationController
  load_and_authorize_resource   

  def show
    #Get the users opinion, or create the opinion if they don't have one.
    @your_opinion = @wiggle.opinions.where(:user_id => current_user.id).first || @wiggle.opinions.create(:value => 5, :user_id => current_user.id)
  end

end
