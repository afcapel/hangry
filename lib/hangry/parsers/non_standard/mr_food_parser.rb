module Hangry
  module Parsers
    module NonStandard
      class MrFoodParser < StructuredDataParser

        def self.can_parse?(html)
          canonical_url_matches_domain?(html, "mrfood.com")
        end

        def parse_yield(value)
          nokogiri_doc.css("#articlePageNutritionLabel .top").text.gsub(/\D/, '')
        end

        def parse_instructions(value)
          nokogiri_doc.css(".stepByStepInstructionsDiv li").map(&:content).join("\n")
        end
      end
    end
  end
end
