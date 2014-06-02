require 'dictionary'

describe Dictionary do
  it 'can return the definition of a word' do
    input = <<-INPUT
{
  "word": {
    "definition": "a {collection} of {letters}",
    "url": "//example.com/word"
  },
  "letter": {
    "definition": "a character representing one or more of the sounds used in speech; any of the symbols of an alphabet",
    "url": "//example.com/letter"
  },
  "collection": {
    "definition": "a group of things or people",
    "url": "//example.us/collection"
  }
}
    INPUT
    dictionary = Dictionary.new(input)

    definition_for = dictionary.definition_for("word")

    expect(definition_for[:definition]).to eq "a collection of letters"
    expect(definition_for[:see_also]).to match_array [
                                                         "//example.com/letter",
                                                         "//example.us/collection"
                                                     ]
  end
end