class WigglesController < ApplicationController
  def show
    @wiggle = Wiggle.find(params[:id])

    #Get the users opinion, or create the opinion if they don't have one.
    @your_opinion = @wiggle.opinions.where(:user_id => current_user.id).first || @wiggle.opinions.create(:value => 5, :user_id => current_user.id)
  end

  def average
    respond_to do |format|
      format.json do
        render :json => { :average => Wiggle.find(params[:id]).average_opinion }
      end
    end
  end

end
