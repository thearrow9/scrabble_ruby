require 'net/http'

class ScrabbleOnlineCheck
  def self.verify? word, server, pattern
    uri = URI(server + word)
    (pattern =~ Net::HTTP.get(uri)).nil?
  end
end
