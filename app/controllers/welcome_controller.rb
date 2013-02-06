class WelcomeController < ApplicationController

  def index
    @paintings = Painting.last(5)
  end

end
