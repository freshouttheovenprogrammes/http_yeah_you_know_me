require_relative 'request'
require_relative 'word_search' # not using right now
require 'date'

class RequestController
  attr_reader :server,
              :request,
              :request_cycles,
              :hello_cycles,
              :close_server # not really using...should I?

  def initialize
    @server         = TCPServer.new(9292)
    @request        = []
    @request_cycles = 0
    @hello_cycles   = 0
    @close_server   = false # not really using...should I?
  end

  def open_server
  loop do
    @client = @server.accept
    @request_cycles += 1
    puts "Ready for a request"
    path_finder
    puts "Got this request:"
      @client.puts headers + @output
      puts "Sending response."
    end
  end

  def headers
    ["http/1.1 200 ok",
      "date: #{Time.now.strftime('%a, %e %b %Y %H:%M:%S %z')}",
      "server: ruby",
      "content-type: text/html; charset=iso-8859-1",
      "content-length: #{@output.length}\r\n\r\n"].join("\r\n")
  end

  def path_finder
    @request_line = []
    while line = @client.gets and !line.chomp.empty?
      @request_line << line.chomp
    end
    @request = Request.new(@request_line)
    @output = ""
      if @request.path == "/" || @request.path == ""
        @output = "<html><head></head><body>#{diagnostics(request)}</body></html>"
      elsif @request.path == "/hello"
        @output = "<html><head></head><body>#{hello}</body></html>"
      elsif @request.path == "/datetime"
        @output = "<html><head></head><body>#{datetime}</body></html>"
      elsif @request.path == "/word_search"
        word = @request.value
        @output = "<html><head></head><body>#{word_search(word)}</body></html>"
      elsif @request.path == "/shutdown"
        @output = "<html><head></head><body>Total Requests: #{@request_cycles}</body></html>"
        @server.close
      end
  end

  def diagnostics(request)
    "<pre>
    Verb: #{@request.verb}
    Path: #{@request.path}
    Protocol: #{@request.protocol}
    #{@request.host}: #{@request.ip}
    Port: #{@request.port}
    Origin: #{@request.ip}
    #{@request.accept}
    </pre>"
  end

  def hello
    @hello_cycles += 1
    "Hello World(#{hello_cycles})"
  end

  def datetime
    d = DateTime.now
    "#{d.strftime('%H:%M%p on %A, %B %d, %Y')}"
  end

  def word_search(word)
    dic = File.read('/usr/share/dict/words')
    if dic.include?(word.downcase)
      "#{word.upcase} is a known word"
    else
      "#{word.upcase} is not a known word"
    end
  end

  def shutdown

  end

end

# TODO why the hell doesn't the dictionary thing return anything what so ever?
