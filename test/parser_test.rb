require_relative 'test_helper'
require './lib/parser'

class ParserTest < Minitest::Test

 ROOT_REQUEST_LINE = ["GET / HTTP/1.1",
  "Host: 127.0.0.1:9292",
  "Connection: keep-alive",
  "Cache-Control: no-cache",
  "User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10_11_5) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/63.0.3239.108 Safari/537.36",
  "Postman-Token: eb37bbbc-8e06-e119-ffa7-c6b04f4ac603",
  "Accept: */*",
  "Accept-Encoding: gzip, deflate, br",
  "Accept-Language: en-US,en;q=0.9"]

  HELLO_REQUEST_LINE = ["GET /hello HTTP/1.1",
   "Host: 127.0.0.1:9292",
   "Connection: keep-alive",
   "Cache-Control: no-cache",
   "User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10_11_5) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/63.0.3239.108 Safari/537.36",
   "Postman-Token: a03d16cd-238d-62fe-983b-e2a52543520e",
   "Accept: */*",
   "Accept-Encoding: gzip, deflate, br",
   "Accept-Language: en-US,en;q=0.9"]

  DATETIME_REQUEST_LINE = ["GET /datetime HTTP/1.1",
   "Host: 127.0.0.1:9292",
   "Connection: keep-alive",
   "Cache-Control: no-cache",
   "User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10_11_5) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/63.0.3239.108 Safari/537.36",
   "Postman-Token: 43e5e9f0-2c29-babc-2cba-5e2ea3ba7cdb",
   "Accept: */*",
   "Accept-Encoding: gzip, deflate, br",
   "Accept-Language: en-US,en;q=0.9"]

  SHUTDOWN_REQUEST_LINE = ["GET /shutdown HTTP/1.1",
   "Host: 127.0.0.1:9292",
   "Connection: keep-alive",
   "Cache-Control: no-cache",
   "User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10_11_5) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/63.0.3239.108 Safari/537.36",
   "Postman-Token: a5053c8b-7e7c-bce8-64d6-6834d6dc6a75",
   "Accept: */*",
   "Accept-Encoding: gzip, deflate, br",
   "Accept-Language: en-US,en;q=0.9"]

 WORD_SEARCH_REQUEST_LINE = ["GET /word_search?word=banana HTTP/1.1",
   "Host: 127.0.0.1:9292",
   "Connection: keep-alive",
   "Cache-Control: no-cache",
   "User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10_11_5) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/63.0.3239.108 Safari/537.36",
   "Postman-Token: b79cca18-d5a1-a271-2c30-ae9ed8b91d21",
   "Accept: */*",
   "Accept-Encoding: gzip, deflate, br",
   "Accept-Language: en-US,en;q=0.9"]

  def test_that_it_exists
    request = Parser.new(ROOT_REQUEST_LINE)

    assert_instance_of Parser, request
  end

  def test_request_line_attribute
    request = Parser.new(ROOT_REQUEST_LINE)

    assert_equal ROOT_REQUEST_LINE, request.request_line
  end

  def test_verb_attribute
    request = Parser.new(ROOT_REQUEST_LINE)

    assert_equal "GET", request.verb
  end

  def test_path_attribute
    request = Parser.new(ROOT_REQUEST_LINE)

    assert_equal "/", request.path
  end

  def test_hello_path_attribute
    request = Parser.new(HELLO_REQUEST_LINE)

    assert_equal "/hello", request.path
  end

  def test_datetime_path_attribute
    request = Parser.new(DATETIME_REQUEST_LINE)

    assert_equal "/datetime", request.path
  end

  def test_word_search_path_attribute
    request = Parser.new(WORD_SEARCH_REQUEST_LINE)

    assert_equal "/word_search", request.path
  end

  def test_shutdown_path_attribute
    request = Parser.new(SHUTDOWN_REQUEST_LINE)

    assert_equal "/shutdown", request.path
  end

  def test_protocol_attribute
    request = Parser.new(ROOT_REQUEST_LINE)

    assert_equal "HTTP/1.1", request.protocol
  end

  def test_host_attribute
    request = Parser.new(WORD_SEARCH_REQUEST_LINE)

    assert_equal "Host", request.host
  end

  def test_ip_attribute
    request = Parser.new(HELLO_REQUEST_LINE)

    assert_equal " 127.0.0.1", request.ip
  end

  def test_port_attribute
    request = Parser.new(ROOT_REQUEST_LINE)

    assert_equal "9292", request.port
  end

  def test_path_and_value_attribute_change_from_word_search
    request = Parser.new(WORD_SEARCH_REQUEST_LINE)

    assert_equal "banana", request.value
  end


end
