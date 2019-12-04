class ShelterReviewsController < ApplicationController

  def new
    @shelter = Shelter.find(params[:id])
  end

  def create
    shelter = Shelter.find(params[:id])

    review = shelter.shelter_reviews.new(review_params)
    review.save

    redirect_to "/shelters/#{shelter.id}"
  end

  private

    def review_params
      params.permit(:title, :rating, :content, :img)
    end
end
