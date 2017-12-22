require_relative 'request'
require_relative 'game'
require 'date'

class RequestController
  attr_reader :server,
              :request,
              :request_cycles,
              :hello_cycles,
              :close_server # not really using...should I?

  def initialize
    @server         = TCPServer.new(9292)
    @request        = [] # this isn't always an array, could I go w/o?
    @request_cycles = 0
    @hello_cycles   = 0
    @close_server   = false # not really using...should I?
  end

  def headers
    ["http/1.1 200 ok",
      "date: #{Time.now.strftime('%a, %e %b %Y %H:%M:%S %z')}",
      "server: ruby",
      "content-type: text/html; charset=iso-8859-1",
      "content-length: #{@output.length}\r\n\r\n"].join("\r\n")
  end

  def open_server
    loop do
      @client = @server.accept
      @request_cycles += 1
      puts "Ready for a request"
      path_finder
      puts "Got this request:" # nothing output here
      @client.puts headers + @output
      puts "Sending response." # still unclear on what "response" really is
    end
  end

  def path_finder
    @request_line = []
    while line = @client.gets and !line.chomp.empty?
      @request_line << line.chomp
    end
    @request = Request.new(@request_line)
    @output = ""
      if @request.verb == "GET"
        get_request
      elsif @request.verb == "POST"
        post_request
      end
  end

  def get_request
    if @request.path == "/" || @request.path == ""
      diagnostics_method(request)
    elsif @request.path == "/hello"
      hello_method
    elsif @request.path == "/datetime"
      datetime_method
    elsif @request.path == "/word_search"
      word = @request.value
      word_search_method(word)
    elsif @request.path == "/shutdown"
      shutdown_method
      @server.close
    end
  end

  def post_request(request)
    if @request.path == "/start_game"
      @output = "<html><head></head><body>Good luck!</body></html>"
      game = Game.new
      game.start
    elsif @request.path == "/game"
    end
  end

  def diagnostics_method(request)
    @output = "<pre>
    Verb: #{@request.verb}
    Path: #{@request.path}
    Protocol: #{@request.protocol}
    #{@request.host}: #{@request.ip}
    Port: #{@request.port}
    Origin: #{@request.ip}
    #{@request.accept}
    </pre>"
  end

  def hello_method
    @hello_cycles += 1
    @output = "Hello World(#{hello_cycles})"
  end

  def datetime_method
    d = DateTime.now
    @output = "#{d.strftime('%H:%M%p on %A, %B %d, %Y')}"
  end

  def word_search_method(word)
    dictionary = File.read('/usr/share/dict/words')
    if dictionary.include?(word.downcase)
      @output = "#{word.upcase} is a known word"
    else
      @output =  "#{word.upcase} is not a known word"
    end
  end

  def shutdown_method
    @output = "Total Requests: #{@request_cycles}"
  end

end
