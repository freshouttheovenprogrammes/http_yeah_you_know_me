require_relative 'parser'
require_relative 'game'
require 'date'

class RequestController
  attr_reader :server,
              :request,
              :request_cycles

  def initialize
    @server         = TCPServer.new(9292)
    @request        = []
    @request_cycles = 0
  end

  def open_server
    loop do
      @client = @server.accept
      @request_cycles += 1
      puts "Ready for a request\n\n"
      @parser = parser
      puts "\nGot this request:\n\n"
      puts @parser.request_line
      path_finder
      @client.puts headers + @output
      puts "\nSending response.\n\n"
      puts headers
      puts @output
    end
  end

  def headers
    ["http/1.1 200 ok",
      "date: #{Time.now.strftime('%a, %e %b %Y %H:%M:%S %z')}",
      "server: ruby",
      "content-type: text/html; charset=iso-8859-1",
      "content-length: #{@output.length}\r\n\r\n"].join("\r\n")
  end

  def parser
    @request_line = []
    while line = @client.gets and !line.chomp.empty?
      @request_line << line.chomp
    end
    Parser.new(@request_line)
  end

  def path_finder
    if @parser.verb == "GET"
      get_request
    elsif @parser.verb == "POST"
      post_request
    end
  end

  def get_request
    if @parser.path == "/" || @parser.path == ""
      diagnostics_method(request)
    elsif @parser.path == "/hello"
      hello_method
    elsif @parser.path == "/datetime"
      datetime_method
    elsif @parser.path == "/word_search"
      word = @parser.value
      word_search_method(word)
    elsif @parser.path == "/game"
      @game = Game.new
      @output = @game.game_diagnostics
    elsif @parser.path == "/shutdown"
      shutdown_method
      @server.close
    else
      @output = "404 Not Found"
    end
  end

  def post_request
    if @parser.path == "/start_game"
      start_game_method
      @output = "#{@game.start_game}"
    else @output = "500 This Server Is Under Construction"
    end
  end

  def diagnostics_method(request)
    @output = "<pre>
    Verb: #{@parser.verb}
    Path: #{@parser.path}
    Protocol: #{@parser.protocol}
    #{@parser.host}: #{@parser.ip}
    Port: #{@parser.port}
    Origin: #{@parser.ip}
    #{@parser.accept}
    </pre>"
  end

  def hello_method
    @hello_cycles ||= 0
    @hello_cycles += 1
    @output = "Hello World (#{@hello_cycles})"
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
      @output = "#{word.upcase} is not a known word"
    end
  end

  def shutdown_method
    @output = "Total Requests: #{@request_cycles}"
  end

  def start_game_method
    @game = Game.new
    @game.start_game
  end
end
