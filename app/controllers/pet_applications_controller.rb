class PetApplicationsController < ApplicationController

  def update
    @pet_application =  PetApplication.find_by(pet_id: params[:pet_id], application_id: params[:app_id])
    @pet_application.toggle(:approved).save
    @pet_application.pet.switch_adoption_status
    redirect_to "/pets/#{@pet_application.pet.id}"
  end
end
