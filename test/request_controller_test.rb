require_relative 'test_helper'
# what should I do as far as counters in the test?
# shutdown method is ruining tests.
# just generally confused on what good things to test are in this scope right now.
class RequestControllerTest < Minitest::Test

  ROOT_RESPONSE = "<pre>\n    Verb: GET\n    Path: /\n    Protocol: HTTP/1.1\n    User-Agent:  Faraday v0.13.1\n    Port: \n    Origin:  Faraday v0.13.1\n    \n    </pre>"

  def setup
    @test_cycles = 0
    @hello_cycles = 0
  end

  def test_root_response
    server = Faraday.get "http://127.0.0.1:9292/"
    @test_cycles += 1

    assert_equal ROOT_RESPONSE, server.body
  end

  def test_get_verb_response
    server = Faraday.get "http://127.0.0.1:9292/"
    @test_cycles += 1

    assert_equal :get, server.env.method
  end

  def test_hello_path_change
    server = Faraday.get "http://127.0.0.1:9292/hello"
    @test_cycles += 1
    @hello_cycles += 1
    expected = "Hello World(#{@hello_cycles})"

    assert_equal expected, server.body
  end

  def test_datetime_path_change
    server = Faraday.get "http://127.0.0.1:9292/datetime"
    @test_cycles += 1
    d = DateTime.now
    expected = "#{d.strftime('%H:%M%p on %A, %B %d, %Y')}"

    assert_equal expected, server.body
  end

  def test_word_search_method_working
    server_hit_1 = Faraday.get "http://127.0.0.1:9292/word_search?word=chump"
    @test_cycles += 1
    server_hit_2 = Faraday.get "http://127.0.0.1:9292/word_search?word=gHhFn"
    @test_cycles += 1
    expected_1 = "CHUMP is a known word"
    expected_2 = "GHHFN is not a known word"

    assert_equal expected_1, server_hit_1.body
    assert_equal expected_2, server_hit_2.body
  end

  def test_shutdown_method_working
    skip
    server = Faraday.get "http://127.0.0.1:9292/shutdown"
    @test_cycles += 1

    assert_equal "Total Requests: #{@test_cycles}", server.body
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
