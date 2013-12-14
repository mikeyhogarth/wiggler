class HomeController < ApplicationController
  def index
    @current_wiggles = Wiggle.current
    @upcoming_wiggles = Wiggle.upcoming
  end
end
