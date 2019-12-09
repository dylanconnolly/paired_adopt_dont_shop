class Pet < ApplicationRecord
  validates_presence_of :image, :name, :sex, :approximate_age
  belongs_to :shelter
  has_many :pet_applications
  has_many :applications, through: :pet_applications

  def switch_adoption_status
    toggle(:adoptable)
    save
  end
end
