class Favorite
  attr_reader :contents

  def initialize(initial_contents)
    @contents = initial_contents || {}
  end

  def total_count
    @contents.values.length
  end

  def add_pet(id)
    @contents[id.to_s] = 1
  end

  def pets
    @contents.keys
  end
end