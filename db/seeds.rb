# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
user = User.create(name: 'nameofuser', email:'asdt560@gmail.com', password:'6letters', encrypted_password: '$2a$12$192AtELpNZ0aZCfnSxs35umQYmbSn52FK8ML/vY.iZvDW4FvkvHn2')
food = Food.create(name: 'foodstuff', measurement_unit: 'gr', price: 20, quantity: 1, user_id: user.id)
recipe = Recipe.create(name: 'foodrecipe', preparation_time: '1.5', cooking_time: '1', description: 'lorem', public: true, user_id: user.id)
private_recipe = Recipe.create(name: 'foodrecipeprivate', preparation_time: '1.5', cooking_time: '1', description: 'lorem', public: false, user_id: user.id)
food_recipe = RecipeFood.create(quantity: 5, food_id: food.id, recipe_id: recipe.id)
