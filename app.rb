require("sinatra")
require("sinatra/reloader")
also_reload("lib/**/*.rb")
require("./lib/food_type")
require("./lib/restaurant")
require("pg")

DB = PG.connect({:dbname => "restaurants"})

get("/") do
  @restaurants = Restaurant.all()
  erb(:index)
end

post("/restaurants") do
  name = params.fetch("name")
  restaurant = Restaurant.new({:name => name, :id => nil})
  restaurant.save()
  @restaurants = Restaurant.all()
  erb(:index)
end


get("/restaurants/:id") do
  @restaurant = Restaurant.find(params.fetch("id").to_i)
  erb(:restaurant)
end


post("/food_types") do
  name = params.fetch("name")
  restaurant_id = params.fetch("restaurant_id").to_i
  food_type = FoodType.new({:name => name, :restaurant_id => restaurant_id})
  food_type.save()
  @restaurant = Restaurant.find(restaurant_id)
  erb(:restaurant)
end

get("/restaurants/:id/edit") do
  @restaurant = Restaurant.find(params.fetch("id").to_i)
  erb(:restaurant_edit)
end


patch "/restaurants/:id" do
  name = params.fetch("name")
  @restaurant = Restaurant.find(params.fetch("id").to_i)
  @restaurant.update({:name => name})
  erb(:restaurant)
end



# delete("/restaurants/:id") do
#   @restaurant = Restaurant.find(params.fetch("id"))
#   @restaurant.delete
#   @restaurants = Restaurant.all
#   erb(:restaurant_edit)
# end
