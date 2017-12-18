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
    pre = "<pre>"
    text.headers
    text.got_request
    text.ready_request
    request_lines = []
    while line = @client.gets and !line.chomp.empty?
      request_lines << line.chomp
    end
    verb, path, protocol = request_lines.first.split(" ")
    response = (puts pre + "Verb:" + verb + "Path:" + path
    puts "Protocol:" + protocol + pre)
    output = "<html><head></head><body>#{response}</body></html>"
    headers = ["http/1.1 200 ok",
      "date: #{Time.now.strftime('%a, %e %b %Y %H:%M:%S %z')}",
      "server: ruby",
      "content-type: text/html; charset=iso-8859-1",
      "content-length: #{output.length}\r\n\r\n"].join("\r\n")
    @client.puts headers
    @client.puts output
    puts "Sending response."
      @cycles += 1
      @client.close
    end
  end
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
