module Hangry
  module Parsers
    module NonStandard
      class AllRecipesParser < SchemaOrgRecipeParser

        def self.ingredient_itemprop
          'recipeIngredient'
        end

        def self.can_parse?(html)
          canonical_url_matches_domain?(html, 'allrecipes.com')
        end

        def parse_name
          recipe_ast.css('h1#recipe-main-content').first.content
        end

        def parse_instructions
          recipe_ast.css('.directions--section ol').first.content
        end
      end
    end
  end
end
