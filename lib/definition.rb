class Definition
  def initialize(text)
    @text = text
  end

  def for_display
    @text.gsub(/{/, '').gsub(/}/, '')
  end

  def related_words
    @text.scan(/{(.*?)}/).flatten
  end
end