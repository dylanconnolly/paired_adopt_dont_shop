class ApplicationsController < ApplicationController

  def new
    @pets = Pet.where(id: favorites.pets)
  end

  def create
    pets = Pet.where(id: params[:pet_ids])
    application = Application.new(application_params)

    if application.save
      pets.each do |pet|
        favorites.remove(pet.id)
      end
      flash[:succes] = "Application successfully submitted!"
      redirect_to '/favorites'
    else
      flash[:error] = "Please complete all fields on the form."
      render :new
    end


  end



  private

    def application_params
      params.permit(:name, :address, :city, :state, :zip, :phone, :reason)
    end
end
