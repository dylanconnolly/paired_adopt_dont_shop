# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
shelter_1 = Shelter.create(name: "Blue Blue Barky",
  address: "123 This Way",
  city: "Denver",
  state: "CO",
  zip: "90204")

shelter_2 = Shelter.create(name: "Rodeo Roundup",
 address: "5608 N Eaton St.",
 city: "Chicago",
 state: "IL",
 zip: "80234")

pet_1 = Pet.create(name: "Rufus", image: "https://cdn.pixabay.com/photo/2018/05/07/10/48/husky-3380548_1280.jpg", approximate_age: "4", sex: "male", shelter: shelter_1)
pet_2 = Pet.create(name: "Peter", image: "https://cdn.pixabay.com/photo/2016/05/09/10/42/weimaraner-1381186_1280.jpg", approximate_age: "1", sex: "male", shelter: shelter_2)
pet_3 = Pet.create(name: "Bella", image: "https://cdn.pixabay.com/photo/2015/06/08/15/02/pug-801826_1280.jpg", approximate_age: "3", sex: "female", shelter: shelter_1)
