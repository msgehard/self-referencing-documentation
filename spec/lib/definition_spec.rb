require 'definition'

describe Definition do
  describe 'getting a list of words' do
    it 'makes pluralized words singular' do
      definition = Definition.new("a {collection} of {letters}")

      expect(definition.related_words).to match_array ["collection", "letter"]
    end
  end
end