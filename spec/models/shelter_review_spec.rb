require 'rails_helper'

RSpec.describe ShelterReview, type: :model do
  describe "validations" do
    it {should validate_presence_of :title}
    it {should validate_presence_of :rating}
    it {should validate_presence_of :content}
    it {should validate_numericality_of(:rating).only_integer}
    it {should validate_numericality_of(:rating).is_greater_than_or_equal_to(0)}
    it {should validate_numericality_of(:rating).is_less_than_or_equal_to(5)}
    it {should allow_values(1,2,3,4,5).for(:rating)}
  end

  describe "relationships" do
    it {should belong_to :shelter}
  end

end
