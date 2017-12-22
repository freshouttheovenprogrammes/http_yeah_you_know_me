require 'socket'
require_relative 'request_controller'

server = RequestController.new
server.open_server
