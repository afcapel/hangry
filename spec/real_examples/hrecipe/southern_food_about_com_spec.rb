# encoding: UTF-8
require_relative '../../spec_helper'
require 'rspec/its'

describe Hangry do

context "southernfood.about.com recipe" do
    let(:html) { File.read("spec/fixtures/hrecipe/southernfood.about.com.html") }
    subject { Hangry.parse(html) }

    it "should use the correct parser" do
      expect(Hangry::ParserClassSelecter.new(html).parser_class).to eq(Hangry::StructuredDataParser)
    end

    its(:author) { should == "Diana Rattray" }
    its(:canonical_url) { should == "https://www.thespruceeats.com/sauteed-kale-with-garlic-and-peppers-3053940" }
    its(:cook_time) { should == 13 }
    its(:description) { should == "Sautéed kale is a tasty way to enjoy fresh or frozen cooked kale. This frozen kale recipe is not only easy to prepare but nutritious and delicious." }
    its(:image_url) { should == "https://www.thespruceeats.com/thmb/K0_wQg_b1fTuUAk_x5yDlHevXhQ=/1414x795/smart/filters:no_upscale()/Cookedkaleandpeppers-GettyImages-596035304-59bf50a49abed5001110aa3c.jpg" }
    its(:ingredients) {
      should == [
        "1 pound kale (large stems removed, chopped, or use frozen chopped kale)",
        "2 teaspoons extra virgin olive oil",
        "1/2 cup finely chopped purple onion",
        "1 medium clove garlic (pressed)",
        "1 or 2 hot peppers (minced, or 1 heaping tablespoon Portuguese crushed red peppers from a jar)",
        "3 tablespoons red wine vinegar",
        "1 tomato (chopped)",
        "1/2 teaspoon salt (or to taste)"
      ]
    }
    its(:name) { should == "Kale With Garlic and Peppers" }
    its(:nutrition) do
      should == {
        calories: "89 kcal",
        cholesterol: "0 mg",
        fiber: "3 g",
        protein: "4 g",
        saturated_fat: "0 g",
        sodium: "225 mg",
        sugar: nil,
        total_carbohydrates: "15 g",
        total_fat: "2 g",
        trans_fat: nil,
        unsaturated_fat: "1 g"
      }
    end

    its(:instructions) {
      instructions = <<-EOS
To cook the kale, bring a pot of salted water to a boil. Add the chopped kale and boil for 10 to 15 minutes, or until stem portions are tender. Or, follow directions on the package if using frozen kale.
Heat olive oil in a large skillet  or sauté pan over medium heat; cook onion until just tender.
Add the garlic and cook, stirring, for 1 minute.
Add crushed red peppers, kale, and vinegar; cook, stirring, for 1 minute longer.
Add chopped tomato, salt, and pepper; heat through.
      EOS
      should == instructions.strip
    }

    its(:prep_time) { should == 12 }
    its(:published_date) { should == nil }
    its(:total_time) { should == 25 }
    its(:yield) { should == "4-6 portions (4-6 servings)" }

  end

end
