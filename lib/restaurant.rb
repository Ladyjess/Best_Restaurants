class Restaurant
 attr_reader(:name, :id)

 def initialize(attri)
   @name = attri[:name]
   @id = attri[:id]
 end


 def self.all
   returned_restaurants = DB.exec("SELECT * FROM restaurants;")
   restaurants = []
   returned_restaurants.each do |restaurant|
     name = restaurant["name"]
     id = restaurant["id"].to_i
     restaurants << Restaurant.new({:name => name, :id => id})
   end
   restaurants
 end

 def save
   result = DB.exec("INSERT INTO restaurants (name) VALUES ('#{@name}') RETURNING id;")
   @id = result.first["id"].to_i
 end

 def ==(another_restaurant)
   self.name.==(another_restaurant.name).&(self.id.==(another_restaurant.id))
 end

 def self.find(identification)
   found_restaurant = nil
   Restaurant.all.each do |restaurant|
     if restaurant.id == identification
       found_restaurant = restaurant
     end
   end
   found_restaurant
 end

 def food_types
   restaurant_food_types = []
   food_types = DB.exec("SELECT * FROM food_types WHERE restaurant_id = #{self.id};")
   food_types.each do |type|
     name = type["name"]
     restaurant_id = type["restaurant_id"].to_i
     restaurant_food_types << FoodType.new(:name => name, :restaurant_id => restaurant_id)
   end
   restaurant_food_types
 end

 def update
   @name = attri.fetch("name")
   @id = self.id
   DB.exec("UPDATE restaurants SET name = '#{@name}' WHERE id = #{@id};")
 end

 def delete
   DB.exec("DELETE FROM restaurants WHERE id = #{self.id};")
   DB.exec("DELETE FROM food_types WHERE restaurant_id = #{self.id};")
 end
end
