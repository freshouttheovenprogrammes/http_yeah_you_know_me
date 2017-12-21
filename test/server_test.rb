require_relative 'test_helper'
require './lib/server'
require 'faraday'

class ServerTest < Minitest::Test

  def test_that_it_exists
    server = Server.new

    assert_instance_of Server, server
  end

  def test_whatever_the_hell_faraday_is
    response = Faraday.get 'http://localhost:9292/hello'
    assert_equal "<html><head></head><body><h1> Hello, World! (1) </h1></body></html>", response.body
  end

end
