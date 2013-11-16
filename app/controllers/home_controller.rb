class HomeController < ApplicationController
  def index
    @wiggles = Wiggle.all
  end
end
