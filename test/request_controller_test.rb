require_relative 'test_helper'

class RequestControllerTest < Minitest::Test

  ROOT_RESPONSE = "<pre>\n    Verb: GET\n    Path: /\n    Protocol: HTTP/1.1\n    User-Agent:  Faraday v0.13.1\n    Port: \n    Origin:  Faraday v0.13.1\n    \n    </pre>"
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

  def test_root_response
    server = Faraday.get "http://127.0.0.1:9292/"

    assert_equal ROOT_RESPONSE, server.body
  end

  def test_get_verb_response
    server = Faraday.get "http://127.0.0.1:9292/"

    assert_equal :get, server.env.method
  end

  def test_hello_path_change
    server = Faraday.get "http://127.0.0.1:9292/hello"
    
    assert_equal "Hello World(1)", server.body
  end

  def test_a

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

  def test_

  end

end
