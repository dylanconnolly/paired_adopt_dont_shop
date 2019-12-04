class WelcomeController < ApplicationController

  def index
    @shelters = Shelter.all
    @pets = Pet.all
  end

end
