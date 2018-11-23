module Hangry
  module Parsers
    module NonStandard
      class EatingWellParser < SchemaOrgRecipeParser

        def self.root_selector
          '[itemtype="http://schema.org/Recipe"]'
        end

        def self.can_parse?(html)
          canonical_url_matches_domain?(html, 'eatingwell.com')
        end

        def parse_name
          recipe_ast&.at_css("h3[itemprop='name']")&.content
        end

        def parse_description
          node = nodes_with_itemprop(:description).last || NullObject
          node.attr('content')
        end

        def parse_instructions
          nodes_with_itemprop(:recipeInstructions).map(&:content).join("\n")
        end

        def parse_ingredients
          nodes_with_itemprop(:ingredients).map do |i|
            i.content.strip
          end
        end

        def parse_nutrition
          recipe.nutrition.tap do |nutrition|
            nutrition[:calories] = nutrition_property_value(:calories)
            nutrition[:cholesterol] = nutrition_property_value(:cholesterolContent)
            nutrition[:fiber] = nutrition_property_value(:fiberContent)
            nutrition[:protein] = nutrition_property_value(:proteinContent)
            nutrition[:saturated_fat] = nutrition_property_value(:saturatedFatContent)
            nutrition[:sodium] = nutrition_property_value(:sodiumContent)
            nutrition[:sugar] = nutrition_property_value(:sugarContent)
            nutrition[:total_carbohydrates] = nutrition_property_value(:carbohydrateContent)
            nutrition[:total_fat] = nutrition_property_value(:fatContent)
            nutrition[:trans_fat] = nutrition_property_value(:transFatContent)
            nutrition[:unsaturated_fat] = nutrition_property_value(:unsaturatedFatContent)
          end
        end

        def parse_yield
          value(node_with_itemprop(:recipeYield).attr('content')) || NullObject.new
        end

        def parse_prep_time
          parse_time(:cookTime)
        end
      end
    end
  end
end
