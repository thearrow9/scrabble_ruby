module LanguageSet
  SERVER_URL = 'http://dictionary.cambridge.org/dictionary/british/'
  NOT_FOUND_REGEX = /not\sfound/
  LABEL = 'en'

  ALPHABET = { 'a' => [6, 1],
               'b' => [4, 2],
               'c' => [4, 2],
               'd' => [4, 2],
               'e' => [4, 2],
               'f' => [4, 2],
               'g' => [4, 2],
               'h' => [4, 2],
               'i' => [4, 2],
               'j' => [4, 2],
               'k' => [4, 2],
               'l' => [4, 2],
               'm' => [4, 2],
               'n' => [4, 2],
               'o' => [4, 2],
               'p' => [4, 2],
               'q' => [4, 2],
               'r' => [4, 2],
               's' => [4, 2],
               't' => [4, 2],
               'u' => [4, 2],
               'v' => [4, 2],
               'w' => [4, 2],
               'x' => [4, 2],
               'y' => [4, 2],
               'z' => [4, 2],
               '_' => [0, 0]
  }

  MAIN_REGEX = /^[a-z]$/i
  CMD_REGEX = /^(1[0-5]|[1-9]),(1[0-5]|[1-9])\s[vh]\s[a-z]+$/i
end
