require 'rails_helper'

RSpec.describe "shelter reviews", type: :feature do
  describe "when on a shelter show page" do
    before :each do
      @shelter_1 = Shelter.create(name: "Blue Blue Barky",
        address: "123 This Way",
        city: "Denver",
        state: "CO",
        zip: "90204")

      @shelter_2 = Shelter.create(name: "Puppy Pound",
        address: "5608 N Eaton St.",
        city: "Chicago",
        state: "IL",
        zip: "80234")

      @review_1 = @shelter_1.shelter_reviews.create(title: "Good spot", rating: "4", content: "Lovely place down the street with cute dogs")
      @review_2 = @shelter_1.shelter_reviews.create(title: "THE BEST", rating: "5", content: "THE BEST woooooo")
      @review_2 = @shelter_2.shelter_reviews.create(title: "Awful", rating: "0", content: "This place only had cats. They're the worst.")
    end

    it "shows a list of all reviews for that shelter" do

      visit "/shelters/#{@shelter_1.id}"

      expect(page).to have_content("Good spot")
    end
  end
end
