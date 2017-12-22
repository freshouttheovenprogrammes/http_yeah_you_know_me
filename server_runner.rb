require 'socket'
require './lib/request_controller'

server = RequestController.new
server.open_server
