module Hangry
  module Parsers
    module NonStandard
      class EatingWellParser < StructuredDataParser

        def self.can_parse?(html)
          canonical_url_matches_domain?(html, 'eatingwell.com') && super
        end

        def parse_yield(value)
          meta_items = nokogiri_doc.css(".recipe-meta-item").to_a
          servings_item = meta_items.find { |i| i.text.squish =~ /serving.*(\d+)/i }
          $1
        end
      end
    end
  end
end
