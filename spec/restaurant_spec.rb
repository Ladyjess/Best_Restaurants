require 'spec_helper'

describe Restaurant do

  describe ".all" do
    it "starts off with no restaurants" do
    expect(Restaurant.all).to eq ([])
   end
 end

  describe "#name" do
    it "tells you the name" do
      restaurant = Restaurant.new({:name => "Armani Italian", :id => nil})
      expect(restaurant.name).to eq ("Armani Italian")
    end
  end

  describe "#save" do
    it "allows you to save a restaurant to the database" do
      restaurant = Restaurant.new({:name => "Krispy Kreme", :id => nil})
      restaurant.save
      expect(Restaurant.all).to eq ([restaurant])
    end
  end

  describe "#==" do
    it("is the same restaurant if it has the same name") do
      restaurant1 = Restaurant.new({:name => "Armani Italian", :id => nil})
      restaurant2 = Restaurant.new({:name => "Armani Italian", :id => nil})
      expect(restaurant1).to eq (restaurant2)
    end
  end

  describe "#id" do
    it "sets the ID when you save it" do
      restaurant = Restaurant.new({:name => "OutBack Steakhouse", :id => nil})
      restaurant.save
      expect(restaurant.id).to (be_an_instance_of(Fixnum))
    end
  end

  describe ".find" do
    it "returns a restaurant by its ID number" do
      test_restaurant = Restaurant.new({:name => "OutBack Steak House", :id => nil})
      test_restaurant.save
      test_restaurant2 = Restaurant.new({:name => "Ritz Carlton Sushi", :id => nil})
      test_restaurant2.save
      expect(Restaurant.find(test_restaurant2.id)).to eq (test_restaurant2)
    end
  end

  describe "#food_types" do
    it "returns array of types for a restaurant" do
      test_restaurant = Restaurant.new({:name => "OutBack Steakhouse", :id => nil})
      test_restaurant.save
      test_food_type = FoodType.new({:name => "Victoria Steak", :restaurant_id => test_restaurant.id})
      test_food_type.save
      test_food_type2 = FoodType.new({:name => "Firecracker Salmon", :restaurant_id => test_restaurant.id})
      test_food_type2.save
      expect(test_restaurant.food_types).to eq ([test_food_type, test_food_type2])
    end
  end
end
