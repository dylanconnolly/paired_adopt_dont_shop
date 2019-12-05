require 'rails_helper'

RSpec.describe Favorite, type: :model do
  it "can calculate the amount of favorites stored" do
    @favorites = Favorite.new({1 => 1, 2 => 1, 3 => 1})

    expect(@favorites.total_count).to eq(3)
  end

  it "can add pets to it" do
    @favorites = Favorite.new({"1" => 1, "2" => 1})

    @favorites.add_pet(3)
    @favorites.add_pet(4)

    expect(@favorites.contents).to eq({"1" => 1, "2" => 1, "3" => 1, "4" => 1})
  end
end
