class SpellingError
  include Mongoid::Document
  field :error_word, :type => String
  field :error_elem, :type => String
  field :suggestion_words, :type => Array
end

