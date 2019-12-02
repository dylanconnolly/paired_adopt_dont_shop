require 'rails_helper'

RSpec.describe Pet, type: :model do
  describe "validations" do
    it {should validate_presence_of :name}
    it {should validate_presence_of :image}
    it {should validate_presence_of :sex}
    it {should validate_presence_of :approximate_age}
    it {should validate_presence_of :adoptable}
  end

  describe "relationships" do
    it {should belong_to :shelter}
  end

  it "defaults adoptable to true" do
    pet_1 = Pet.create(name: "Rufus", image: "https://cdn.pixabay.com/photo/2018/05/07/10/48/husky-3380548_1280.jpg", approximate_age: "4", sex: "male", shelter: @shelter_1)


    pet_1.adoptable.should == true
  end
end
