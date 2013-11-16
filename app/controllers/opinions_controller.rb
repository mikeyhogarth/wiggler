class OpinionsController < ApplicationController
  def update
    opinion = Opinion.find(params[:id])
    if opinion.user_id == current_user.id
      opinion.value = params[:value] 
      opinion.save
      puts opinion.value
    else
      #replace with cancan
      raise AuthenticationError
    end

    render :json => { :your_opinion => opinion.value, :average => opinion.wiggle.average_opinion }
end
end
