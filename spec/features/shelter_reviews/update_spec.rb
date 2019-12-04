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

  it "there is a link next to each review to edit that review" do


    visit "/shelters/#{@shelter_1.id}"

    within "#review-#{@review_1.id}" do
      expect(page).to have_link("Edit")
    end

    within "#review-#{@review_2.id}" do
      expect(page).to have_link("Edit")
    end
  end

  it "when edit button is clicked user is taken to form with fields populated with current info" do

    visit "/shelters/#{@shelter_1.id}"

    within "#review-#{@review_1.id}" do
      click_on "Edit"
      expect(find_field(:title).value).to eq("Good spot")
      expect(find_field(:rating).value).to eq(4)
      expect(find_field(:content).value).to eq("Lovely place down the street with cute dogs")
    end
  end

  it "user can update details of review and submit it" do

    visit "/shelters/#{@shelter_1.id}"

    within "#review-#{@review_1.id}" do
      click_on "Edit"
      fill_in :title, with: "Bad spot"
      fill_in :rating, with: 0
      fill_in :content, with: "Changing this comment's content"
    end
  end




end
