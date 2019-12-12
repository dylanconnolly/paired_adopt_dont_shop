class Pet < ApplicationRecord
  validates_presence_of :image, :name, :sex, :approximate_age
  belongs_to :shelter
  has_many :pet_applications, dependent: :destroy
  has_many :applications, through: :pet_applications

  def switch_adoption_status
    toggle(:adoptable)
    save
  end

  def deletable?
    !(PetApplication.pet_adopted?(self))
  end

  def self.applied_for
    pet_ids = PetApplication.select(:pet_id).distinct.pluck(:pet_id)
    Pet.where(id: pet_ids)
  end
end
