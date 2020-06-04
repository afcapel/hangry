require_relative '../../spec_helper'

describe Hangry do

  context "bbcgoodfood.com recipe" do
    let(:html) { File.read("spec/fixtures/schema_org/bbcgoodfood.html") }
    subject { Hangry.parse(html) }

    it "should use the correct parser" do
      expect(Hangry::ParserClassSelecter.new(html).parser_class).to eq(Hangry::Parsers::NonStandard::BBCGoodFoodParser)
    end

    its(:author) { should == "Miriam Nice" }
    its(:canonical_url) { should == "https://www.bbcgoodfood.com/recipes/mushroom-brunch" }
    its(:cook_time) { should == 15 }
    its(:description) { should == "You only need mushrooms, eggs, kale and garlic to cook this tasty one-pan brunch. It's comforting yet healthy, low-calorie and gluten-free too" }
    its(:image_url) { should == "//www.bbcgoodfood.com/sites/default/files/styles/recipe/public/recipe/recipe-image/2017/11/mushroom-brunch.jpg?itok=h73wuyE4" }
    its(:ingredients) {
      should == [
        "250g mushrooms",
        "1 garlic clove",
        "1 tbsp olive oil",
        "160g bag kale",
        "4 eggs"
      ]
    }
    its(:name) { should == "Mushroom brunch" }
    its(:nutrition) do
      should == {
        calories: "154",
        cholesterol: nil,
        fiber: "2g",
        protein: '13g',
        saturated_fat: "2g",
        sodium: "0.4g",
        sugar: "1g",
        total_carbohydrates: "1g",
        total_fat: "11g",
        trans_fat: nil,
        unsaturated_fat: nil
      }
    end
    its(:instructions) {
      instructions = <<-EOS
Slice the mushrooms and crush the garlic clove. Heat the olive oil in a large non-stick frying pan, then fry the garlic over a low heat for 1 min. Add the mushrooms and cook until soft. Then, add the kale. If the kale won’t all fit in the pan, add half and stir until wilted, then add the rest. Once all the kale is wilted, season.
Now crack in the eggs and keep them cooking gently for 2-3 mins. Then, cover with the lid to for a further 2-3 mins or until the eggs are cooked to your liking. Serve with bread.
      EOS
      should == instructions.strip
    }
    its(:prep_time) { should == 5 }
    its(:published_date) { should == Date.new(2017, 11, 1) }
    its(:total_time) { should == 20 }
    its(:yield) { should == "Serves 4" }
  end
end
