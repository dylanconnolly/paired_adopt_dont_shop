class SheltersController < ApplicationController

  def index
    @shelters = Shelter.all
  end

  def show
    @shelter = Shelter.find(params[:id])
    @shelter_reviews = @shelter.shelter_reviews
  end

  def new
  end

  def create
    shelter = Shelter.new(shelter_params)

    if shelter.save
      redirect_to '/shelters'
    else
      flash[:error] = "Please complete all fields on the form."
      render :new
    end
  end

  def edit
    @shelter = Shelter.find(params[:id])
  end

  def update
    shelter = Shelter.find(params[:id])

    shelter.update(shelter_params)

    shelter.save

    redirect_to "/shelters/#{shelter.id}"
  end

  def destroy
    shelter = Shelter.find(params[:id])

    if shelter.pets_with_approved_applications.count == 0
      Shelter.destroy(params[:id])
      redirect_to '/shelters'
    else
      flash[:error] = "Cannot delete shelter due to one or more pets having approved applications."
      redirect_back(fallback_location: "/shelters")
    end
  end

  def index_pets
    @shelter = Shelter.find(params[:id])

    @pets = @shelter.pets
  end

  def new_pet
  end

  private

    def shelter_params
      params.permit(:name, :address, :city, :state, :zip)
    end

end
