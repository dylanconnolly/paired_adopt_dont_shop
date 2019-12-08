class ApplicationsController < ApplicationController

  def new
    @pets = Pet.where(id: favorites.pets)
  end
end
