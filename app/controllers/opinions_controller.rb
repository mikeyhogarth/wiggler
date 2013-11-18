class OpinionsController < ApplicationController
  load_and_authorize_resource
  
  def update
    @opinion.update! opinion_params 
    render :json => { :your_opinion => @opinion.value, :average => @opinion.wiggle.average_opinion } 
  end

  private
  def opinion_params
    params.require(:opinion).permit(:value)
  end

end
