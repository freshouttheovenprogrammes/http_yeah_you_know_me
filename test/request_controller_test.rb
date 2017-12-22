require_relative 'test_helper'

class RequestControllerTest < Minitest::Test

  ROOT_RESPONSE = "<pre>\n    Verb: GET\n    Path: /\n    Protocol: HTTP/1.1\n    User-Agent:  Faraday v0.13.1\n    Port: \n    Origin:  Faraday v0.13.1\n    \n    </pre>"


  def test_root_response
    skip
    server = Faraday.get "http://127.0.0.1:9292/"

    assert_equal ROOT_RESPONSE, server.body
  end

  def test_get_verb_response
    skip
    server = Faraday.get "http://127.0.0.1:9292/"

    assert_equal :get, server.env.method
  end

  def test_bad_address_gets_response
    skip
    server = Faraday.get "http://127.0.0.1:9292/hell"

    assert_equal "404 Not Found", server.body
  end

  def test_hello_path_change
    skip
    Faraday.get "http://127.0.0.1:9292/hello"
    Faraday.get "http://127.0.0.1:9292/hello"
    Faraday.get "http://127.0.0.1:9292/hello"
    Faraday.get "http://127.0.0.1:9292/hello"
    server = Faraday.get "http://127.0.0.1:9292/hello"

    assert_equal "Hello World (5)", server.body
  end

  def test_datetime_path_change
    skip
    server = Faraday.get "http://127.0.0.1:9292/datetime"
    d = DateTime.now
    expected = "#{d.strftime('%H:%M%p on %A, %B %d, %Y')}"

    assert_equal expected, server.body
  end

  def test_word_search_method_working_include_any_param

    # server_1 = Faraday.get "http://127.0.0.1:9292/word_search?word=chun"
    server_2 = Faraday.get "http://127.0.0.1:9292/word_search?woo=Wowisie"
    # server_3 = Faraday.get "http://127.0.0.1:9292/word_search?random=Wowisie"
    # expected_1 = "CHUN is a known word"
    expected_2 = "WOWISIE is not a known word"

    # assert_equal expected_1, server_1.body
    assert_equal expected_2, server_2.body
  end

  def test_game_post_method_working
    skip
    server = Faraday.post "http://127.0.0.1:9292/start_game"

    assert_equal :post, server.env.method
    assert_equal "Good luck!", server.body
  end
end
