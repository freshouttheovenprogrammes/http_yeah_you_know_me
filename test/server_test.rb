require_relative 'test_helper'
require './lib/server'

class ServerTest < Minitest::Test

  def test_that_it_exists
    server = Server.new

    assert_instance_of Server, server
  end

end
