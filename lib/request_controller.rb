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
    pre = "<pre>"
    pre_close = "</pre>"
    verb, comma, protocol = @request_lines[0].split(" ")
    host, ip, port = @request_lines[1].split(":")
    response = "#{pre}
    Verb: #{verb}
    Path: #{comma}
    Protocol: #{protocol}
    Host: #{host}
    Port: #{port}
    #{pre_close}"
    response_2 = pre + " IP: " + ip + " Port: " + port + pre_close
    output = "<html><head></head><body>#{response}#{response_2}</body></html>"
    text.headers(output)
    text.got_request
    text.ready_request
    @client.puts text.headers(output)
    @client.puts output # this is needed...why?
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
