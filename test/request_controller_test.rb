require_relative 'test_helper'
require './lib/request_controller'

class RequestControllerTest < Minitest::Test


REQUEST_LINE =  ["Verb: GET
                 Path: /
                 Protocol: HTTP/1.1
                 Host:  127.0.0.1
                 Port: 9292
                 Origin:  127.0.0.1
                 Accept-Encoding: gzip, deflate, br"]

  def test_that_it_exists
    rq = RequestController.new

    assert_instance_of RequestController, rq
  end

  def test_that_attributes_default_correctly
    rq = RequestController.new

    assert_instance_of Array, rq.request
    assert_equal 0, rq.request_cycles
    assert_equal 0, rq.hello_cycles
  end

  def test_that_request_cycle_increases_upon_opening
    open_server = Faraday.get "http://127.0.0.1:9292/"
    require "pry"; binding.pry
    assert_equal expected, open_server
  end

end
