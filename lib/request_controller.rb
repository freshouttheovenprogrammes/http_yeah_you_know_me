class RequestController
  attr_reader :tcp_server,
              :cycles,
              :close_server,
              :client

  def initialize
    @tcp_server = TCPServer.new(9292)
    @cycles = 0
    @close_server = false
    @client = tcp_server.accept
  end

  def open_server
    loop do
      client
    puts "Ready for a request"
    request_lines = []
      while line = client.gets and !line.chomp.empty?
        request_lines << line.chomp
      end
    puts "Got this request:"
    puts request_lines.inspect
    puts "Sending response."
    verb, path, protocol = request_lines.first.split(" ")
    if path.scan("?").any?
      path, params = path.split("?")
      response = "<pre>" + "verb: " + verb + " params: " + params + " path: " + path + " protocol: " + protocol + "\n\n"+ request_lines.join("\n") + "</pre>"
    else
      response = "<pre>" + "verb: " + verb + " path: " + path + " protocol: " + protocol + "\n\n"+ request_lines.join("\n") + "</pre>"
    end
    end
  end

  def close_server
    tcp_server.close
  end

end
