class PetApplication < ApplicationRecord
  belongs_to :pet
  belongs_to :application

  def self.pet_adopted?(pet)
    approved_statuses = select('approved').where("pet_id = #{pet.id}").pluck(:approved)
    approved_statuses.include?(true)
  end
end
