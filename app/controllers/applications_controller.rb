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
        application.pets << pet
      end
      redirect_to '/favorites'
      flash[:success] = "Application successfully submitted!"
    else
      flash[:error] = "Please complete all fields on the form."
      @pets = Pet.where(id: favorites.pets)
      render :new
    end


  end

  private

    def application_params
      params.permit(:name, :address, :city, :state, :zip, :phone, :reason)
    end
end
