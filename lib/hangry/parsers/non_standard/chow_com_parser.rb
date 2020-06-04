module Hangry
  module Parsers
    module NonStandard
      class ChowComParser < SchemaOrgRecipeParser
        def self.can_parse?(html)
          canonical_url_matches_domain?(html, 'chow.com')
        end

        def self.ingredient_itemprop
          :ingredients
        end
      end
    end
  end
end
