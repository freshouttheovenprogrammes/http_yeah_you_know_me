class RequestController
  attr_reader :tcp_server

  def initialize
    @tcp_server = TCPServer.new(9292)
  end

  def close_server

  end

end
