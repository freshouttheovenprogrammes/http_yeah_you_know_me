class Parser
attr_reader :request_line,
            :verb,
            :path,
            :protocol,
            :host,
            :ip,
            :port,
            :value,
            :accept,
            :word_search_param

  def initialize(request_line)
    @request_line           = request_line
    @verb, @path, @protocol = request_line[0].split(" ")
    @host, @ip, @port       = request_line[1].split(":")
    @path, @value           = path.split("?word=")
    @accept                 = request_line[6]
    @word_search_param      = request_line[0].split("?")[1].split("=")[0] unless request_line[0].split[1].split("?")[1].nil?
  end
end


=begin
12] pry(#<Parser>)> path.split("word_search?")
=> ["/", "word=chun"]
[13] pry(#<Parser>)> path.split("word_search?").split("=")
NoMethodError: undefined method `split' for ["/", "word=chun"]:Array
from (pry):18:in `initialize'
[14] pry(#<Parser>)> path.split("word_search?")[1].split("=")
=> ["word", "chun"]
[15] pry(#<Parser>)> path.split("word_search?")[1].split("=")[1]
=> "chun"
[16] pry(#<Parser>)> path.split("word_search?")[1].split("=")
=> ["word", "chun"]
[17] pry(#<Parser>)> anything, value = path.split("word_search?")[1].split("=")
=> ["word", "chun"]
[18] pry(#<Parser>)> value
=> "chun"
=end
