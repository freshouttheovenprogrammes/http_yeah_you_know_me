require_relative 'text'

class RequestController
  attr_reader :server,
              :text,
              :cycles,
              :close_server

  def initialize
    @server       = TCPServer.new(9292)
    @text         = Text.new
    @cycles       = 0
    @close_server = false
  end


  def open_server
    loop do
    @client = server.accept
    @request_lines = []
    while line = @client.gets and !line.chomp.empty?
      @request_lines << line.chomp
    end
    verb, path, protocol = @request_lines.first.split(" ")
    pre = "<pre>"
    pre_close = "</pre>"
    response = pre + "Verb: " + verb + " Path: " + path +
    " Protocol: " + protocol + pre_close
    output = "<html><head></head><body>#{response}</body></html>"
    text.headers(output)
    text.got_request
    text.ready_request
    @client.puts text.headers(output)
    @client.puts output
    puts "Sending response."
      @cycles += 1
      @client.close
    end
  end
  #
  # def formatter(lines)
  #   lines.map do |line|
  # end
  #
  # def close_server
  #   server.close
  # end

end












# if path.scan("?").any?
#   path, params = path.split("?")
#   response = "<pre>" + "verb: " + verb + " params: " + params + " path: " + path + " protocol: " + protocol + "\n\n"+ request_lines.join("\n") + "</pre>"
# else
#   response = "<pre>" + "verb: " + verb + " path: " + path + " protocol: " + protocol + "\n\n"+ request_lines.join("\n") + "</pre>"
# end
