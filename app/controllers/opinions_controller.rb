class OpinionsController < ApplicationController
  load_and_authorize_resource
  
  def update
    @opinion.update! opinion_params 
    @wiggle = @opinion.wiggle
    
    respond_to do |format|
      format.js
    end

  end

  private
  def opinion_params
    params.require(:opinion).permit(:value)
  end

end
