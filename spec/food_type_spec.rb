require 'spec_helper'

describe FoodType do

  describe ".all" do
    it "is empty at first" do
      expect(FoodType.all).to eq ([])
    end
  end

 describe "#name" do
   it "gives the name of a food type" do
    test_food_type = FoodType.new({:name => "Victoria Sirloin", :restaurant_id => 1})
    test_food_type.save
   expect(test_food_type.name).to eq ("Victoria Sirloin")
   end
 end

 describe "#save" do
   it "add a food type to array of saved food types" do
     test_food_type = FoodType.new({:name => "Victoria Sirloin", :restaurant_id => 1})
     test_food_type.save
     expect(FoodType.all).to eq ([test_food_type])
   end
 end

 describe "restaurant_id" do
   it "links to a restaurant" do
     test_food_type = FoodType.new({:name => "Coconut Shrimp", :restaurant_id => 1})
     expect(test_food_type.restaurant_id).to eq (1)
   end
 end


 describe "==" do
   it "is the same type if it has the same name and restaurant id" do
     type1 = FoodType.new({:name => "Coconut Shrimp", :restaurant_id => 1})
     type2 = FoodType.new({:name => "Coconut Shrimp", :restaurant_id => 1})
     expect(type1).to eq (type2)
   end
  end
end
