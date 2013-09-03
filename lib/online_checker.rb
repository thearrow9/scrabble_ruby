require 'net/http'
require 'cgi'

class ScrabbleOnlineCheck
  def self.verify? word, server, pattern
    word = CGI::escape(word)
    uri = URI(server + word)
    (pattern =~ Net::HTTP.get(uri).force_encoding('utf-8')).nil?
  end
end
