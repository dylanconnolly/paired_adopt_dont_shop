class CreateShelterReviews < ActiveRecord::Migration[5.1]
  def change
    create_table :shelter_reviews do |t|
      t.string :title
      t.string :rating
      t.string :content
      t.string :img
      t.timestamps
    end
  end
end
