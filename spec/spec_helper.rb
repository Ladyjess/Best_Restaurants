require("rspec")
require("pg")
require("restaurant")
require("food_type")

DB = PG.connect({:dbname => "restaurants_test"})

RSpec.configure do |config|
  config.after(:each) do
    DB.exec("DELETE FROM restaurants *;")
    DB.exec("DELETE FROM food_types *;")
  end
end
