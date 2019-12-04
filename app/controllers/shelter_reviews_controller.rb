class ShelterReviewsController < ApplicationController

  def new
    @shelter = Shelter.find(params[:id])
  end

  def create
    @shelter = Shelter.find(params[:id])

    review = @shelter.shelter_reviews.new(review_params)

    if review.save
      redirect_to "/shelters/#{@shelter.id}"
    else
      flash.now[:error] = "Unable to create review: missing required fields"
      render :new
    end
  end

  private

    def review_params
      params.permit(:title, :rating, :content, :img)
    end
end
