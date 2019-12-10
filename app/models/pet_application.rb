class PetApplication < ApplicationRecord
  belongs_to :pet
  belongs_to :application

  def self.pet_adopted?(pet)
    approved_statuses = select('approved').where("pet_id = #{pet.id}").pluck(:approved)
    approved_statuses.include?(true)
  end

  def self.find(pet_id, app_id)
    find_by(pet_id: pet_id, application_id: app_id)
  end
end
