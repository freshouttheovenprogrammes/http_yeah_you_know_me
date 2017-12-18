require_relative 'text'

class RequestController
  attr_reader :tcp_server,
              :cycles,
              :close_server,
              :text

  def initialize
    @tcp_server   = TCPServer.new(9292)
    @text         = Text.new
    @cycles       = 0
    @close_server = false
  end



  def open_server
    loop do
    @client = tcp_server.accept
    pre = "<pre>"
    text.headers
    text.got_request
    request_lines = []
      while line = @client.gets and !line.chomp.empty?
        request_lines << line.chomp
      end
    text.ready_request
    verb, path, protocol = request_lines.first.split(" ")
    response = (puts pre + "Verb:" + verb
    puts "Path:" + path
    puts "Protocol:" + protocol + pre)
    output = "<html><head></head><body>#{response}</body></html>"
    @client.puts output
    @client.puts response
    puts "Sending response."
      @cycles += 1
      @client.close
    end
  end
  #
  # def close_server
  #   tcp_server.close
  # end

end












# if path.scan("?").any?
#   path, params = path.split("?")
#   response = "<pre>" + "verb: " + verb + " params: " + params + " path: " + path + " protocol: " + protocol + "\n\n"+ request_lines.join("\n") + "</pre>"
# else
#   response = "<pre>" + "verb: " + verb + " path: " + path + " protocol: " + protocol + "\n\n"+ request_lines.join("\n") + "</pre>"
# end
