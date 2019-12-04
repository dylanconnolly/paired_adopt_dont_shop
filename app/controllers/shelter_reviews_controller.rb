class ShelterReviewsController < ApplicationController

  def new
    @shelter = Shelter.find(params[:shelter_id])
  end

  def create
    @shelter = Shelter.find(params[:shelter_id])
    review = @shelter.shelter_reviews.new(review_params)

    if review.save
      redirect_to "/shelters/#{@shelter.id}"
    else
      flash.now[:error] = "Unable to create review: missing required fields"
      render :new
    end
  end

  def edit
    @review = ShelterReview.find(params[:review_id])
    @shelter = @review.shelter
  end

  def update
    @review = ShelterReview.find(params[:review_id])
    @shelter = @review.shelter

    if @review.update(review_params)
      redirect_to "/shelters/#{@shelter.id}"
    else
      flash.now[:error] = "Unable to update review: missing required fields"
      render :edit
    end
  end

  private

    def review_params
      params.permit(:title, :rating, :content, :img)
    end
end
