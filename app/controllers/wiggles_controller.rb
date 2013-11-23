class WigglesController < ApplicationController
  load_and_authorize_resource   

  def show
    #Get the users opinion, or create the opinion if they don't have one.
    if current_user
      your_opinion = @wiggle.opinions.where(:user_id => current_user.id).first || @wiggle.opinions.create(:value => 5, :user_id => current_user.id)
      @update_url = url_for(your_opinion)
      @your_opinion_value = your_opinion.value
    else
      @your_opinion_value = 0
    end

  end

end
