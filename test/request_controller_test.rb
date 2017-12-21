require_relative 'test_helper'
require './lib/request_controller'

class RequestControllerTest < Minitest::Test

  def test_that_it_exists
    rq = RequestController.new

    assert_instance_of RequestController, rq
  end

end
