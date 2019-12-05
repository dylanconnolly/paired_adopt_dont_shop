class ChangeRatingToInteger < ActiveRecord::Migration[5.1]
  def change
    change_column :shelter_reviews, :rating, :integer, using: 'rating::integer'
  end
end
