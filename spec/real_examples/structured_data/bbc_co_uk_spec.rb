# encoding: UTF-8
require_relative "../../spec_helper"

describe Hangry do

  context "bbc.co.uk recipe" do
    let(:html) { File.read("spec/fixtures/structured_data/bbc.co.uk.html") }
    subject { Hangry.parse(html) }

    it "should use the correct parser" do
      expect(Hangry::ParserClassSelecter.new(html).parser_class).to eq(Hangry::StructuredDataParser)
    end

    its(:author) { should == "Antony Worrall Thompson" }
    its(:canonical_url) { should == "https://www.bbc.co.uk/food/recipes/paella_7100" }
    its(:cook_time) { should == 30 }
    its(:description) { should include "An authentic seafood and chicken paella that boasts some of Spain’s finest ingredients, from calasparra rice to chorizo." }
    its(:image_url) { should == 'https://food-images.files.bbci.co.uk/food/recipes/paella_7100_16x9.jpg' }
    its(:ingredients) {
      should match_array [
        "170g/6oz chorizo, cut into thin slices",
        "110g/4oz pancetta, cut into small dice",
        "2 cloves garlic finely chopped",
        "1 large Spanish onion, finely diced",
        "1 red pepper, diced",
        "1 tsp soft thyme leaves",
        "¼ tsp dried red chilli flakes",
        "570ml/1pint calasparra (Spanish short-grain) rice",
        "1 tsp paprika",
        "125ml/4fl oz dry white wine",
        "1.2 litres/2 pints chicken stock, heated with ¼ tsp saffron strands",
        "8 chicken thighs, each chopped in half and browned",
        "18 small clams, cleaned",
        "110g/4oz fresh or frozen peas",
        "4 large tomatoes, de-seeded and diced",
        "50ml/2fl oz good olive oil",
        "1 head garlic, cloves separated and peeled",
        "12 jumbo raw prawns, in shells",
        "450g/1lb squid, cleaned and chopped into bite-sized pieces",
        "5 tbsp chopped flatleaf parsley",
        "Salt and freshly ground black pepper"
      ]
    }
    its(:name) { should == "Paella" }
    its(:nutrition) do
      should == {
        calories: "660kcal",
        cholesterol: nil,
        fiber: "3.5g",
        protein: "51g",
        saturated_fat: "6g",
        sodium: nil,
        sugar: "5g",
        total_carbohydrates: "65g",
        total_fat: "20g",
        trans_fat: nil,
        unsaturated_fat: nil
      }
    end

    its(:instructions) {
      instructions = <<-EOS
Heat half the olive oil in a paella dish or heavy-based saucepan. Add the chorizo and pancetta and fry until crisp. Add the garlic, onion and pepper and heat until softened. Add the thyme, chilli flakes and calasparra rice, and stir until all the grains of rice are nicely coated and glossy. Now add the paprika and dry white wine and when it is bubbling, pour in the hot chicken stock, add the chicken thighs and cook for 5-10 minutes.
Now place the clams into the dish with the join facing down so that the edges open outwards. Sprinkle in the peas and chopped tomatoes and continue to cook gently for another 10 minutes.
Meanwhile, heat the remaining oil with the garlic cloves in a separate pan and add the prawns. Fry quickly for a minute or two then add them to the paella. Now do the same with the squid and add them to the paella too.
Scatter the chopped parsley over the paella and serve immediately.
      EOS
      should == instructions.strip
    }

    its(:prep_time) { should == 60 }
    its(:published_date) { should == nil }
    its(:total_time) { should == nil }
    its(:yield) { should == "Serves 8" }
  end
end
