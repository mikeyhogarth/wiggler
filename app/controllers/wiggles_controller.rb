class WigglesController < ApplicationController
  load_and_authorize_resource   

  def show
    #Get the users opinion, or create the opinion if they don't have one.
    if current_user
      @opinion = @wiggle.opinions.where(:user_id => current_user.id).first || @wiggle.opinions.create(:value => 50, :user_id => current_user.id)
    end
  end

end
