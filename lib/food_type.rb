class FoodType
  attr_reader(:name, :restaurant_id)

  def initialize(attri)
    @name = attri[:name]
    @restaurant_id = attri[:restaurant_id]
  end

  def self.all
     returned_types = DB.exec("SELECT * FROM food_types;")
     food_types_array = []
     returned_types.each do |food_type|
       name = food_type.fetch("name")
       restaurant_id = food_type.fetch("restaurant_id").to_i
       food_types_array << FoodType.new({:name => name, :restaurant_id => restaurant_id})
     end
    food_types_array
  end

  def save
    DB.exec("INSERT INTO food_types (name, restaurant_id) VALUES ('#{@name}', #{@restaurant_id});")
  end

  def ==(another_food_type)
    self.name.==(another_food_type.name).&(self.restaurant_id.==(another_food_type.restaurant_id))
  end
end
