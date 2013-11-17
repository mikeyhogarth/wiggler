class OpinionsController < ApplicationController
  before_filter :set_opinion_ivar, :only => :update

  def update
    #TODO: Replace this with CanCan eventually
    raise "You are not the owner of this opinion" unless @opinion.user_id == current_user.id 
    
    @opinion.update! opinion_params
    render :json => { :your_opinion => @opinion.value, :average => @opinion.wiggle.average_opinion } 
  end

  private
  def opinion_params
    params.require(:opinion).permit(:value)
  end

  def set_opinion_ivar
    @opinion = Opinion.find(params[:id])
  end

end
