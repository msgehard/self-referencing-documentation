require 'json'

class Dictionary
  def initialize(contents)
    @contents = JSON.parse(contents)
  end

  def definition_for(word)
    definition = @contents[word]["definition"]

    {
        definition: definition_for_display(definition),
        see_also: related_urls(definition)
    }
  end

  private

  def definition_for_display(definition)
    definition.gsub(/{/, '').gsub(/}/, '')
  end

  def related_words(definition)
    definition.scan(/{(.*?)}/).flatten
  end

  def url_for_singular(related_word)
    @contents[related_word[0..-2]]["url"]
  end

  def url_for(related_word)
    @contents[related_word]["url"]
  end

  def found_related_word?(related_word)
    !@contents[related_word].nil?
  end

  def related_urls(definition)
    related_words(definition).map do |related_word|

      if found_related_word?(related_word)
        url_for(related_word)
      else
        url_for_singular(related_word)
      end
    end
  end

end