require 'json'

class Dictionary
  def initialize(contents)
    @contents = JSON.parse(contents)
  end

  def definition_for(word)
    definition = @contents[word]["definition"]

    related_words = definition.scan(/{(.*?)}/).flatten

    related_urls = related_words.map do |related_word|

      if found_related_word?(related_word)
        url_for(related_word)

      else
        url_for_singular(related_word)
      end
    end

    {
        definition: definition.gsub(/{/, '').gsub(/}/, ''),
        see_also: related_urls
    }
  end

  private
  def url_for_singular(related_word)
    @contents[related_word[0..-2]]["url"]
  end


  def url_for(related_word)
    @contents[related_word]["url"]
  end

  def found_related_word?(related_word)
    !@contents[related_word].nil?
  end

end