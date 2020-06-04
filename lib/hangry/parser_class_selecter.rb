require 'hangry/recipe_parser'
require 'hangry/default_recipe_parser'
require 'hangry/hrecipe_parser'
require 'hangry/schema_org_recipe_parser'
require 'hangry/structured_data_parser'
require 'hangry/data_vocabulary_recipe_parser'

require 'hangry/parsers/non_standard/all_recipes_parser'
require 'hangry/parsers/non_standard/bbc_good_food_parser'
require 'hangry/parsers/non_standard/chow_com_parser'
# require 'hangry/parsers/non_standard/copykat_parser'
require 'hangry/parsers/non_standard/eatingwell_parser'
require 'hangry/parsers/non_standard/epicurious_parser'
require 'hangry/parsers/non_standard/food_network_parser'
require 'hangry/parsers/non_standard/home_cooking_parser'
require 'hangry/parsers/non_standard/mr_food_parser'

module Hangry
  class ParserClassSelecter
    def initialize(html)
      @html = html
    end

    def parser_class
      # Prefer the more specific parsers
      parser_classes = [
        Parsers::NonStandard::AllRecipesParser,
        Parsers::NonStandard::BBCGoodFoodParser,
        Parsers::NonStandard::ChowComParser,
        # Parsers::NonStandard::CopykatParser,
        Parsers::NonStandard::EatingWellParser,
        Parsers::NonStandard::EpicuriousParser,
        Parsers::NonStandard::FoodNetworkParser,
        Parsers::NonStandard::HomeCookingParser,
        Parsers::NonStandard::MrFoodParser,
      ]
      parser_classes += [StructuredDataParser, SchemaOrgRecipeParser, HRecipeParser, DataVocabularyRecipeParser]
      parser_classes << DefaultRecipeParser
      parser_classes.detect { |p| p.can_parse?(@html) }
    end

  end
end
