require_relative 'test_helper'
require './lib/server'

class ServerTest < Minitest::Test

  def test_server_reaches_request_controller
    server = Server.new

    server.close
    assert_instance_of RequestController, server.connect
  end

end
