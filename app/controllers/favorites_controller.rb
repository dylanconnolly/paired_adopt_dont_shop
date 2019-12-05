class FavoritesController < ApplicationController

  def update
    pet = Pet.find(params[:pet_id])
    flash[:notice] = "You have successfully added #{pet.name} to your favorites!"

    redirect_to "/pets/#{pet.id}"
  end
end
