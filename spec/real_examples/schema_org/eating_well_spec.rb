# encoding: UTF-8
require_relative "../../spec_helper"

describe Hangry do

  context "eatingwell.com recipe" do
    let(:html) { File.read("spec/fixtures/schema_org/eatingwell.com.html") }
    subject { Hangry.parse(html) }

    it "should use the correct parser" do
      expect(Hangry::ParserClassSelecter.new(html).parser_class).to eq(Hangry::Parsers::NonStandard::EatingWellParser)
    end

    its(:author) { should == "EatingWell Test Kitchen" }
    its(:canonical_url) { should == "http://www.eatingwell.com/recipe/251798/sauteed-chicken-breasts-with-creamy-chive-sauce/" }
    its(:cook_time) { should == nil }
    its(:description) { should == "Here's a sauce so delicious, it's missing only one thing: a little crunchy bread to dip in it. Make It a Meal: Serve with steamed asparagus or cauliflower, mashed potatoes or orzo pasta, and a glass of Vinho Verde." }
    its(:image_url) { should == "https://imagesvc.meredithcorp.io/v3/mm/image?url=https%3A%2F%2Fimages.media-allrecipes.com%2Fuserphotos%2F3755910.jpg" }
    its(:ingredients) {
      should == [
        "4 boneless, skinless chicken breasts, (about 1 pound), trimmed of fat",
        "1 teaspoon kosher salt, divided",
        "1/4 cup plus 1 tablespoon all-purpose flour, divided",
        "3 teaspoons extra-virgin olive oil, divided",
        "2 large shallots, finely chopped",
        "½ cup dry white wine",
        "1 14-ounce can reduced-sodium chicken broth",
        "⅓ cup reduced-fat sour cream",
        "1 tablespoon Dijon mustard",
        "1/2 cup chopped chives, (about 1 bunch)"
      ]
    }
    its(:name) { should == "Sauteed Chicken Breasts with Creamy Chive Sauce" }
    its(:nutrition) do
      should == {
        calories: '257 calories',
        cholesterol: '70 mg',
        fiber: '0.5 g',
        protein: '26.3 g',
        saturated_fat: '2.8 g',
        sodium: '634 mg',
        sugar: '1 g',
        total_carbohydrates: '11.8 g',
        total_fat: '8.7 g',
        trans_fat: nil,
        unsaturated_fat: nil
      }
    end

    its(:instructions) {
      instructions = <<-EOS
Place chicken between sheets of plastic wrap and pound with a meat mallet or heavy skillet until flattened to an even thickness, about 1/2 inch. Season both sides of the chicken with 1/2 teaspoon salt. Place 1/4 cup flour in a shallow glass baking dish and dredge the chicken in it. Discard the excess flour.\nHeat 2 teaspoons oil in a large nonstick skillet over medium-high heat. Add the chicken and cook until golden brown, 1 to 2 minutes per side. Transfer to a plate, cover and keep warm.\nHeat the remaining 1 teaspoon oil in the pan over medium-high heat. Add shallots and cook, stirring constantly and scraping up any browned bits, until golden brown, 1 to 2 minutes. Sprinkle with the remaining 1 tablespoon flour; stir to coat. Add wine, broth and the remaining 1/2 teaspoon salt; bring to a boil, stirring often.\nReturn the chicken and any accumulated juices to the pan, reduce heat to a simmer, and cook until heated through and no longer pink in the center, about 6 minutes. Stir in sour cream and mustard until smooth; turn the chicken to coat with the sauce. Stir in chives and serve immediately.
      EOS
      should == instructions.strip
    }

    its(:prep_time) { should == nil }
    its(:published_date) { should == nil }
    its(:total_time) { should == 35 }
    its(:yield) { should == "4" }
  end
end
