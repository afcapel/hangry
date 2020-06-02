module Hangry
  module Parsers
    module NonStandard
      class BBCGoodFoodParser < SchemaOrgRecipeParser

        def self.can_parse?(html)
          canonical_url_matches_domain?(html, 'bbcgoodfood.com')
        end

        def parse_ingredients
          nodes_with_itemprop(:ingredients).map do |i|
            i.attribute('content').value
          end
        end
      end
    end
  end
end
