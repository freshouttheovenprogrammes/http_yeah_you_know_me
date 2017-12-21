require_relative 'test_helper'

class RequestControllerTest < Minitest::Test

  ROOT_RESPONSE = "<html><head></head><body><pre>\n
                    Verb: GET\n    Path: /\n    Protocol: HTTP/1.1\n
                    Host:  Faraday v0.9.2\n    Port: \n    Origin:  Faraday v0.9.2\n
                    Accept: */*\n   </pre></body></html>"
  HELLO_RESPONSE =  "<html><head></head><body>Hello World 1\n<pre>\n
                     Verb: GET\n    Path: /hello\n    Protocol: HTTP/1.1\n
                     Host:  Faraday v0.9.2\n    Port: \n    Origin:  Faraday v0.9.2\n
                     Accept: */*\n   </pre></body></html>"
  DATETIME =  "<html><head></head><body>#{Time.now.strftime("%l:%M%p on %A, %^B %-d, %Y ")}
               \n<pre>\n    Verb: GET\n    Path: /datetime\n    Protocol: HTTP/1.1\n
               Host:  Faraday v0.9.2\n    Port: \n    Origin:  Faraday v0.9.2\n
               Accept: */*\n   </pre></body></html>"
  SHUTDOWN = "<html><head></head><body>Total Requests: 3\n<pre>\n
              Verb: GET\n    Path: /shutdown\n    Protocol: HTTP/1.1\n
              Host:  Faraday v0.9.2\n    Port: \n    Origin:  Faraday v0.9.2\n
              Accept: */*\n   </pre></body></html>"
  NEW_GAME = "<html><head></head><body>Good luck!</body></html>"
  GAME_RESPONSE = "<html><head></head><body>you have made 0 guesses</body></html>"


  def test_that_it_exists
    rq = RequestController.new

    assert_instance_of RequestController, rq
  end

  def test_root_response
    server = Faraday.get "http://127.0.0.1:9292/"

    assert_equal ROOT_RESPONSE, server.body
  end

  def test_that_request_cycle_increases_upon_opening
    skip
    server = Faraday.get "http://127.0.0.1:9292/"
    # how to i get access to RequestController w/o another instantiation??
    assert_equal 1, server.request_cycles
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
  def test_

  end

  def test_

  end

  def test_

  end

  def test_

  end

  def test_

  end

  def test_

  end

end
