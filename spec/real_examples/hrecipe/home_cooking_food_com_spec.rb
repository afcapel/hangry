# encoding: UTF-8
require_relative '../../spec_helper'
require 'rspec/its'

describe Hangry do

  context "homecooking.about.com recipe" do
    let(:html) { File.read("spec/fixtures/hrecipe/homecooking.about.com.html") }
    subject { Hangry.parse(html) }

    it "should use the correct parser" do
      expect(Hangry::ParserClassSelecter.new(html).parser_class).to eq(Hangry::StructuredDataParser)
    end

    its(:author) { should == "Peggy Trowbridge Filippone" }
    its(:canonical_url) { should == "https://www.thespruceeats.com/white-chocolate-key-lime-muffins-recipe-1808282" }
    its(:cook_time) { should == 25 }
    its(:description) { should == "Use this basic recipe for incredibly moist and delightfully tangy sweet muffins or cake." }
    its(:image_url) { should == "https://www.thespruceeats.com/thmb/XJf779UaP9u_zkNYbTAU1aZkXtw=/1600x900/smart/filters:no_upscale()/blmuff23-56a4957e3df78cf772831d0f.jpg" }
    its(:ingredients) {
      should == [
        "Cupcakes or Cake:",
        "1 3/4 cups all-purpose flour",
        "2 teaspoons baking powder",
        "1/2 teaspoon salt",
        "6 tablespoons butter (softened)",
        "1 cup sugar", "2 large eggs (lightly beaten)",
        "1 1/2 teaspoons key lime zest (grated)",
        "1 tablespoon fresh key lime juice",
        "2/3 cup buttermilk",
        "1 cup white chocolate chips",
        "Glaze:",
        "1 cup powdered sugar",
        "1/8 cup fresh key lime juice",
      ]
    }
    its(:name) { should == "White Chocolate Key Lime Muffins or Cake" }
    its(:nutrition) do
      should == {
        calories: "154 kcal",
        cholesterol: "61 mg",
        fiber: "1 g",
        protein: "3 g",
        saturated_fat: "3 g",
        sodium: "162 mg",
        sugar: nil,
        total_carbohydrates: "23 g",
        total_fat: "6 g",
        trans_fat: nil,
        unsaturated_fat: "2 g"
      }
    end

    its(:instructions) {
      instructions = <<-EOS
For Muffins:\nGather the ingredients.\nPreheat oven to 350 F/175 C. Line standard-size muffin tin with foil liners.\nBlend the flour, baking powder, and salt together in a small bowl. Set aside.\nIn a large mixing bowl, cream butter and sugar together with a mixer, beating until blended.\nAdd the eggs, lime zest, and lime juice.\nInto the butter-cream mixture in the large bowl, add 1/3 of the flour mixture, stirring until combined.\nAdd one-third of the buttermilk, stirring until combined.\nContinue alternating one-third of each until all is mixed well. Fold in white chocolate chips.\nFill cupcake liners two-thirds full with batter.\nBake 18 to 20 minutes (or 12 to 14 minutes for mini-muffins) until wooden pick inserted in the center comes out clean.\nMake the Glaze:\nGather the ingredients.\nWhisk powdered sugar and lime juice together until combined and smooth.\nWhile muffins are still warm, poke holes in the tops of the muffins with a wooden pick.\nSmooth about a teaspoon on top of each warm muffin.\nCool completely.\nServe and enjoy!\nFor Cake:\nGather the ingredients.\nPreheat oven to 350 F/175 C. Prepare a 9 x 13-inch baking pan by lining with foil (non-stick foil recommended).\nFollow the same mixing instructions as above in the muffins.\nSpread batter evenly in pan.\nBake 35 to 40 minutes or until wooden pick inserted in center comes out clean.\nLet rest in pan about 5 minutes and then poke holes all over the top of the cake with a wooden pick.\nSpread glaze evenly over top of cake and cool completely.\nCut into pieces to serve and enjoy!.
      EOS
      should == instructions.strip
    }

    its(:prep_time) { should == 10 }
    its(:published_date) { should == nil }
    its(:total_time) { should == 35 }
    its(:yield) { should == "18 muffins (18 servings)" }

  end

end
