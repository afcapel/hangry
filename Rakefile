#!/usr/bin/env rake
require "bundler/gem_tasks"

require 'rspec/core/rake_task'
require 'httparty'

RSpec::Core::RakeTask.new(:spec)

task :default => :spec

desc 'Fetch the current versions of all the fixtures'
task :update_fixtures do
  USER_AGENT = 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/41.0.2228.0 Safari/537.36'
  [
    ['https://www.chow.com/recipes/30700-strawberry-rhubarb-pie-with-sour-cream-crust',        'spec/fixtures/schema.org/chow.com.html'],
    ['https://www.myrecipes.com/recipe/best-carrot-cake-10000000257583/',                      'spec/fixtures/schema.org/data-vocabulary_org/myrecipes.com.html'],
    ['https://www.saveur.com/article/Recipes/Smoked-Trout-Blinis-with-Creme-Fraiche-and-Dill', 'spec/fixtures/schema.org/data-vocabulary_org/saveur.com.html'],
    ['https://www.tarladalal.com/5-Spice-Vegetable-Fried-Rice-8631r',                          'spec/fixtures/schema.org/data-vocabulary_org/tarladalal.com.html'],
    ['https://www.taste.com.au/recipes/24586/lemon+melting+moments',                           'spec/fixtures/schema.org/data-vocabulary_org/taste.com.au.html'],
    ['https://www.allrecipes.com/recipe/230347/roasted-vegetable-and-couscous-salad/',         'spec/fixtures/schema_org/allrecipes.html'],
    ['https://www.bettycrocker.com/recipes/skillet-chicken-nachos/9bf0c3be-09dd-4b1b-8cf4-a9cfa979b232', 'spec/fixtures/schema_org/betty_crocker.html'],
    ['https://www.copykat.com/2014/12/03/low-fat-scalloped-potatoes/',                          'spec/fixtures/schema_org/copykat.com.html'],
    ['https://www.eatingwell.com/recipes/sauteed_chicken_breasts_with_creamy_chive_sauce.html', 'spec/fixtures/schema_org/eatingwell.com.html'],
    ['https://www.food.com/recipe/panda-express-orange-chicken-103215', 'spec/fixtures/schema_org/food.com.html'],
    ['https://www.foodnetwork.com/recipes/rachael-ray/spinach-and-mushroom-stuffed-chicken-breasts-recipe.html', 'spec/fixtures/schema_org/food_network_schema_org.html'],
    ['https://www.foodnetwork.com/recipes/food-network-kitchens/easter-bunny-cake-recipe/index.html', 'spec/fixtures/schema_org/food_network_with_blank_ingredients.html'],
    ['https://www.foodandwine.com/recipes/honey-glazed-roasted-root-vegetables','spec/fixtures/schema_org/foodandwine.com.html'],
    ['https://www.pillsbury.com/recipes/big-cheesy-pepperoni-hand-pies/a17766e6-30ce-4a0c-af08-72533bb9b449', 'spec/fixtures/schema_org/pillsbury.com.html'],
    ['https://www.bbc.co.uk/food/recipes/paella_7100', 'spec/fixtures/structured_data/bbc.co.uk.html'],
    ['https://www.bigoven.com/recipe/steves-fish-tacos/178920', 'spec/fixtures/hrecipe/bigoven.html'],
    ['https://www.campbellskitchen.com/recipes/recipedetails?recipeid=60821', 'spec/fixtures/hrecipe/campbellskitchen.com.html'],
    ['https://www.cooking.com/recipes-and-more/recipes/garlic-shrimp-recipe-41.aspx', 'spec/fixtures/hrecipe/cooking.com.html'],
    ['https://www.drinksmixer.com/drink2438.html', 'spec/fixtures/hrecipe/drinksmixer.com.html'],
    ['https://www.epicurious.com/recipes/food/views/grilled-turkey-burgers-with-cheddar-and-smoky-aioli-354289', 'spec/fixtures/hrecipe/epicurious.html'],
    ['https://www.grouprecipes.com/135867/deep-dark-chocolate-cheesecake.html', 'spec/fixtures/hrecipe/grouprecipes.com.html'],
    ['https://homecooking.about.com/od/muffinrecipes/r/blmuff23.htm', 'spec/fixtures/hrecipe/homecooking.about.com.html'],
    ['https://www.jamieoliver.com/recipes/pork-recipes/neck-fillet-steak/', 'spec/fixtures/structured_data/jamieoliver.com.html'],
    ['https://www.mrfood.com/Slow-Cooker-Recipes/Saucy-Italian-Pot-Roast-4268', 'spec/fixtures/hrecipe/mrfood.com.html'],
    ['https://southernfood.about.com/od/collardgreens/r/Kale-Saute-Recipe.htm', 'spec/fixtures/hrecipe/southernfood.about.com.html'],
    ['https://www.tasteofhome.com/recipes/rhubarb-popover-pie', 'spec/fixtures/hrecipe/tasteofhome.com.html'],
  ].each do |source, fixture|
    begin
      puts "fetching #{source} to update #{fixture}"
      response = HTTParty.get(source, headers: {"User-Agent" => USER_AGENT})
      if response.code == 200
        path = File.join(Dir.pwd, fixture)
        File.open(path, 'w') { |file| file.write(response.body) }
      else
        puts "failed"
      end
    rescue
    end
  end
end
