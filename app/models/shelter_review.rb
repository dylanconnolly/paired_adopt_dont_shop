class ShelterReview < ApplicationRecord
  validates_presence_of :title, :rating, :content
  validates :rating, numericality: { only_integer: true, greater_than_or_equal_to: 0, less_than_or_equal_to: 5}
# validates numericality of or inclusion of
  belongs_to :shelter
end
