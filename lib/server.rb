require 'socket'
require_relative 'request_controller'

class Server
  attr_reader :request_controller

  def initialize
    @request_controller = RequestController.new
    connect
  end

  def connect
    @request_controller.open_server
  end
end

server = Server.new
server.open_server
