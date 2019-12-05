class FavoritesController < ApplicationController

  def update
    pet = Pet.find(params[:pet_id])

    favorites.add_pet(pet.id)
    session[:favorites] = favorites.contents
    flash[:notice] = "You have successfully added #{pet.name} to your favorites!"
    redirect_to "/pets/#{pet.id}"
  end

  def index
    @pets = Pet.all
  end
end
