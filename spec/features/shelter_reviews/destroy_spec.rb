require 'rails_helper'

RSpec.describe "on shelter show page" do
  before :each do
    @shelter_1 = Shelter.create(name: "Blue Blue Barky",
      address: "123 This Way",
      city: "Denver",
      state: "CO",
      zip: "90204")

    @review_1 = @shelter_1.shelter_reviews.create(title: "Good spot", rating: 4, content: "Lovely place down the street with cute dogs")
    @review_2 = @shelter_1.shelter_reviews.create(title: "THE BEST", rating: 5, content: "THE BEST woooooo")
  end

  it "there is a button to delete a review next to each review" do
    visit "/shelters/#{@shelter_1.id}"

    within "#review-#{@review_1.id}" do
      click_on "Delete"
    end

    expect(page).to_not have_content("Good spot")
    expect(page).to_not have_content("Lovely place down the street with cute dogs")

    within "#review-#{@review_2.id}" do
      expect(page).to have_link("Delete")
    end
  end
end
