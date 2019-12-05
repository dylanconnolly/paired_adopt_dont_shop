# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
shelter_1 = Shelter.create(
  name: "Blue Blue Barky",
  address: "1243 Elliot Cove",
  city: "Denver",
  state: "CO",
  zip: "90204"
)

shelter_2 = Shelter.create(
  name: "Rodeo Roundup",
  address: "5608 N Eaton St.",
  city: "Chicago",
  state: "IL",
  zip: "80234"
)

shelter_3 = Shelter.create(
  name: "East Coast Pups",
  address: "311 Weston Pkwy",
  city: "Detroit",
  state: "MI",
  zip: "48055"
)

pet_1 = Pet.create(name: "Rufus", image: "https://cdn.pixabay.com/photo/2018/05/07/10/48/husky-3380548_1280.jpg", approximate_age: "4", sex: "male", shelter: shelter_1)
pet_2 = Pet.create(name: "Peter", image: "https://cdn.pixabay.com/photo/2016/05/09/10/42/weimaraner-1381186_1280.jpg", approximate_age: "1", sex: "male", shelter: shelter_2)
pet_3 = Pet.create(name: "Bella", image: "https://cdn.pixabay.com/photo/2015/06/08/15/02/pug-801826_1280.jpg", approximate_age: "3", sex: "female", shelter: shelter_1)
pet_4 = Pet.create(name: "Maximus", image: "https://cdn.pixabay.com/photo/2018/03/31/06/31/dog-3277416_1280.jpg", approximate_age: "7", sex: "male", shelter: shelter_2)
pet_5 = Pet.create(name: "Babos", image: "https://cdn.pixabay.com/photo/2016/01/05/17/51/dog-1123016_1280.jpg", approximate_age: "2", sex: "female", shelter: shelter_2)
pet_6 = Pet.create(name: "Lucy", image: "https://cdn.pixabay.com/photo/2016/10/15/12/01/dog-1742295_1280.jpg", approximate_age: "13", sex: "female", shelter: shelter_3)
pet_7 = Pet.create(name: "Penny", image: "https://cdn.pixabay.com/photo/2018/03/18/18/06/australian-shepherd-3237735_1280.jpg", approximate_age: "6", sex: "female", shelter: shelter_3)
pet_8 = Pet.create(name: "Jedi", image: "https://cdn.pixabay.com/photo/2014/09/19/21/47/chihuahua-453063_1280.jpg", approximate_age: "3", sex: "female", shelter: shelter_1)
pet_9 = Pet.create(name: "Lando", image: "https://cdn.pixabay.com/photo/2016/02/19/11/53/pug-1210025_1280.jpg", approximate_age: "5", sex: "male", shelter: shelter_3)
