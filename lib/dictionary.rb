require 'json'
require 'definition'

class Dictionary
  def initialize(contents)
    @contents = JSON.parse(contents)
  end

  def definition_for(word)
    definition = Definition.new(@contents[word]["definition"])

    {
        definition: definition.for_display,
        see_also: related_urls(definition)
    }
  end

  private

  def url_for(related_word)
    @contents[related_word]["url"]
  end

  def related_urls(definition)
    definition.related_words.map do |related_word|
      url_for(related_word)
    end
  end
end