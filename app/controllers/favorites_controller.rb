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
  end

  def destroy
    pet = Pet.find(params[:pet_id])

    favorites.remove(pet.id)
    flash[:notice] = "You have removed #{pet.name} from your favorites."

    redirect_back(fallback_location: "/favorites")
  end

  def destroy_all
    index.each do |pet|
      favorites.remove(pet.id)
    end
    redirect_to "/favorites"
  end
end
