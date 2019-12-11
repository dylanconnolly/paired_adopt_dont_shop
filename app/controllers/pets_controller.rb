class PetsController < ApplicationController

  def index
    @pets = Pet.all
  end

  def show
    @pet = Pet.find(params[:id])
    if @pet.adoptable == false
      @pet_application = PetApplication.find_by(pet_id: @pet.id, approved: true)
    end
  end

  def new
    @shelter_id = params[:id]

    @list = ["male", "female"]
  end

  def create
    shelter = Shelter.find(params[:id])
    shelter.pets.create(pet_params)

    redirect_to "/shelters/#{shelter.id}/pets"
  end

  def edit
    @pet = Pet.find(params[:pet_id])
  end

  def update
    # request_path = URI(request.referer).path
    pet = Pet.find(params[:pet_id])
    pet.update(pet_params)

    redirect_to "/pets/#{pet.id}"
  end

  def destroy
    pet = Pet.find(params[:pet_id])

    if pet.deletable? == true
      Pet.destroy(pet.id)
      favorites.remove(pet.id)
      redirect_to '/pets'
    else
      flash[:error] = "Cannot delete pet as the pet has been approved for adoption."
      redirect_to URI(request.referer).path
    end
  end

  private

    def pet_params
      params.permit(:image, :name, :description, :approximate_age, :sex)
    end
end
