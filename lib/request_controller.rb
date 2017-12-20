require_relative 'text'
require 'date'

class RequestController
  # include Text
  attr_reader :server,
              :text,
              :cycles,
              :close_server,
              :request_lines

  def initialize
    @server        = TCPServer.new(9292)
    @cycles        = 0
    @close_server  = false
  end

  def time
    d = DateTime.now
    "#{d.strftime('%H:%M%p on %A, %B %d, %Y')}"
  end

  def wordsearch(word)
    search = WordSearch.new
    search.word_parse(word)
  end

  def open_server
    loop do
    request_lines = []
    client = @server.accept
    @cycles += 1
    puts "Ready for a request"
    while line = client.gets and !line.chomp.empty?
      request_lines << line.chomp
      require "pry"; binding.pry
    end
    pre = "<pre>"
    pre_close = "</pre>"
    verb, path, protocol = request_lines[0].split(" ")
    host, ip, port = request_lines[1].split(":")
    accept = request_lines[6]
    word = request_lines[x]
    response = "#{pre}
    Verb: #{verb}
    Path: #{path}
    Protocol: #{protocol}
    #{host}: #{ip}
    Port: #{port}
    Origin: #{ip}
    #{accept}
    #{pre_close}"
    @output = ""
      if path == "/"
        @output = "<html><head></head><body>#{response}</body></html>"
      elsif path == "/hello"
        @output = "<html><head></head><body>Hello World(#{cycles})</body></html>"
      elsif path == "/datetime"
        @output = "<html><head></head><body>#{time}</body></html>"
      elsif path == "/wordsearch"
        @output = "<html><head></head><body>#{wordsearch(word)}</body></html>"
      elsif path == "/shutdown"
        @output = "<html><head></head><body>Total Requests: #{cycles}</body></html>"
        @server.close
      end
    puts "Got this request:"
    headers = ["http/1.1 200 ok",
      "date: #{Time.now.strftime('%a, %e %b %Y %H:%M:%S %z')}",
      "server: ruby",
      "content-type: text/html; charset=iso-8859-1",
      "content-length: #{@output.length}\r\n\r\n"].join("\r\n")
    client.puts headers
    client.puts @output
    puts "Sending response."
        # @server.close
    end
  end
end
