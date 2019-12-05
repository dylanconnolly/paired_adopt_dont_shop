class ShelterReview < ApplicationRecord
  validates_presence_of :title, :rating, :content
# validates numericality of or inclusion of
  belongs_to :shelter
end
