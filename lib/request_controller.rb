class RequestController
  attr_reader :tcp_server,
              :cycles,
              :close_server

  def initialize
    @tcp_server = TCPServer.new(9292)
    @cycles = 0
    @close_server = false
  end

  def open_server
    client = tcp_server.accept
    puts "Ready for a request"
    request_lines = []
    while line = client.gets and !line.chomp.empty?
      request_lines << line.chomp
    end
  end

  def close_server
    tcp_server.close
  end

end
