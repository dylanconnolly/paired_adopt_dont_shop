require 'rails_helper'

RSpec.describe "pet can be deleted" do
  before :each do
    @shelter_1 = Shelter.create(name: "Blue Blue Barky",
                               address: "123 This Way",
                               city: "Denver",
                               state: "CO",
                               zip: "90204")

    @pet_1 = Pet.create(name: "Rufus", image: "https://cdn.pixabay.com/photo/2018/05/07/10/48/husky-3380548_1280.jpg", approximate_age: "4", sex: "male", shelter: @shelter_1)
  end

  it "there is a delete button on pet show page" do

    visit "/pets/#{@pet_1.id}"

    click_link "Delete Pet"
  end

  it "redirects to pets index page where pet can no longer be found" do

    visit "/pets/#{@pet_1.id}"

    click_link "Delete Pet"

    expect(current_path).to eq("/pets")
    expect(page).to_not have_content(@pet_1.name)
    expect(page).to_not have_content(@pet_1.image)
  end
end
