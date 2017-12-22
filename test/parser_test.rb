require_relative 'test_helper'
require './lib/request'

class RequestTest < Minitest::Test

  def test_that_it_exists
    request = Request.new(request_line)

    assert_instance_of Request, request
  end


end
