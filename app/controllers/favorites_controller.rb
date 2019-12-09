class FavoritesController < ApplicationController

  def update
    pet = Pet.find(params[:pet_id])

    favorites.add_pet(pet.id)
    session[:favorites] = favorites.contents
    flash[:notice] = "You have successfully added #{pet.name} to your favorites!"
    redirect_to "/pets/#{pet.id}"
  end

  def index
    @pets = Pet.where(id: favorites.pets)
    @applications = Application.all
  end

  def destroy
    path = request.env["PATH_INFO"] # will return where the request came from ("/favorites/:pet_id" if specific pet is to be removed or "/favorites" if user wants to remove all)
    if path == "/favorites"
      require "pry"; binding.pry
      @pets.each do |pet|
        favorites.remove(pet.id)
      end
    else
      pet = Pet.find(params[:pet_id])
      favorites.remove(pet.id)
      flash[:notice] = "You have removed #{pet.name} from your favorites."
    end

    redirect_back(fallback_location: "/favorites")
  end
end
