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
    end

    expect(find_field("title").value).to eq("Good spot")
    expect(find_field("rating").value).to eq("4")
    expect(find_field("content").value).to eq("Lovely place down the street with cute dogs")
  end

  it "user can update details of review and submit it" do

    visit "/shelters/#{@shelter_1.id}"

    within "#review-#{@review_1.id}" do
      click_on "Edit"
    end

    fill_in "title", with: "Bad spot"
    fill_in "rating", with: 0
    fill_in "content", with: "Changing this comment's content"

    click_on "Update Review"

    within "#review-#{@review_1.id}" do
      expect(page).to have_content("Bad spot")
      expect(page).to have_content("0")
      expect(page).to have_content("Changing this comment's content")
    end
  end

  it "an error message is displayed if user fails to input a title, rating, or content when updating review" do

    visit "/shelters/#{@shelter_1.id}"

    within "#review-#{@review_1.id}" do
      click_on "Edit"
    end

    fill_in "title", with: "This will fail"
    fill_in "rating", with: 5
    fill_in "content", with: ""

    click_on "Update Review"

    expect(page).to have_content("Unable to update review: missing required fields")

    fill_in "title", with: "This will pass"
    fill_in "rating", with: 0
    fill_in "content", with: "Adding content so review will update"

    click_on "Update Review"
  end
end
