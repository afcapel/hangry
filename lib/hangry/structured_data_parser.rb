require "json"
require 'hangry/canonical_url_parser'
require "rails-html-sanitizer"

module Hangry
  class StructuredDataParser < RecipeParser

    ATTRIBUTES_MAP = {
      image_url: :image,
      yield: :recipeYield,
      ingredients: :recipeIngredient,
      instructions: :recipeInstructions,
    }

    EMPTY_NUTRITION = {
      calories: nil,
      cholesterol: nil,
      fiber: nil,
      protein: nil,
      saturated_fat: nil,
      sodium: nil,
      sugar: nil,
      total_carbohydrates: nil,
      total_fat: nil,
      trans_fat: nil,
      unsaturated_fat: nil
    }

    def initialize(recipe_html)
      @recipe_html = recipe_html
      @recipe = Recipe.new
      self.nokogiri_doc = Nokogiri::HTML(recipe_html)
    end

    def self.can_parse?(html)
      instance = new(html)
      instance.recipe_data
    end

    def parse
      RECIPE_ATTRIBUTES.each do |attribute|
        attr_value = parse_attribute(attribute)
        recipe.public_send("#{attribute}=", attr_value)
      end

      recipe
    end

    def parse_attribute(attr_name)
      key = ATTRIBUTES_MAP[attr_name] || attr_name.to_s.camelize(:lower)

      attr_value = value(recipe_data.dig(*key))

      if self.respond_to?("parse_#{attr_name}")
        attr_value = self.send("parse_#{attr_name}", attr_value)
      end

      attr_value
    end

    def parse_canonical_url(parsed)
      parsed || CanonicalUrlParser.new(nokogiri_doc).canonical_url
    end

    def parse_prep_time(value)
      parse_duration(value)
    end

    def parse_cook_time(value)
      parse_duration(value)
    end

    def parse_total_time(value)
      parse_duration(value)
    end

    def parse_image_url(image_value)
      if image_value.is_a?(Array)
        image_value = image_value.first
      end

      if image_value.is_a?(Hash)
        image_value = image_value[:url]
      end

      image_value
    end

    def parse_author(author_value)
      return parse_author(author_value.first) if author_value.is_a?(Array)

      author_value.is_a?(Hash) ? author_value[:name] : author_value
    end

    def parse_instructions(instructions_value)
      if instructions_value.is_a?(Array)
        instructions_value = instructions_value.map { |i| parse_instructions_step(i) }
        instructions_value = instructions_value.join("\n")
      end

      instructions_value = Rails::Html::Sanitizer.full_sanitizer.new.sanitize(instructions_value)
      instructions_value
    end

    def parse_instructions_step(instruction_step_value)
      return instruction_step_value unless instruction_step_value.is_a?(Hash)
      return instruction_step_value[:text] if instruction_step_value.has_key?(:text)

      if instruction_step_value["@type"] == "HowToSection"
        parse_how_to(instruction_step_value)
      end
    end

    def parse_how_to(how_to_data)
      list = how_to_data[:itemListElement] || []
      steps = [how_to_data[:name]]
      steps += list.select { |s| s["@type"] == "HowToStep" }.collect { |s| s["text"] }
    end

    def parse_nutrition(nutrition_value)
      return EMPTY_NUTRITION unless nutrition_value.present?

      nutrition_value = nutrition_value[:nutrition] || nutrition_value

      {
        calories: nutrition_value[:calories],
        cholesterol: nutrition_value[:cholesterolContent],
        fiber: nutrition_value[:fiberContent],
        protein: nutrition_value[:proteinContent],
        saturated_fat: nutrition_value[:saturatedFatContent],
        sodium: nutrition_value[:sodiumContent],
        sugar: nutrition_value[:sugarContent],
        total_carbohydrates: nutrition_value[:carbohydrateContent],
        total_fat: nutrition_value[:fatContent],
        trans_fat: nutrition_value[:transFatContent],
        unsaturated_fat: nutrition_value[:unsaturatedFatContent],
      }
    end

    def recipe_data
      @recipe_data ||= structured_data.find do |data|
        data["@context"] =~ /https?:\/\/schema\.org/ &&
          data["@type"] == "Recipe"
      end&.with_indifferent_access
    end

    def how_to_data
      @how_to_data ||= structured_data.find do |data|
        data["@context"] =~ /https?:\/\/schema\.org/ &&
          data["@type"] == "HowToSection"
      end&.with_indifferent_access
    end

    def structured_data
      @structured_data ||= load_structured_data
    end

    def load_structured_data
      @structured_data ||= nokogiri_doc.css("script[type='application/ld+json']").collect do |n|
        JSON.parse(n.content)
      end.to_a.flatten

      if @structured_data.first.is_a?(Hash) && @structured_data.first.has_key?("@graph")
        @structured_data = @structured_data.first["@graph"]
      end

      @structured_data
    end
  end
end
