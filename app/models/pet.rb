class Pet < ApplicationRecord
  validates_presence_of :image, :name, :sex, :approximate_age, :adoptable
  belongs_to :shelter
end
