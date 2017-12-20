require_relative 'text'
require 'time'
require 'date'

class RequestController
  include Text
  attr_reader :server,
              :text,
              :cycles,
              :close_server,
              :request_lines,
              :client

  def initialize
    @server        = TCPServer.new(9292)
    # @text          = Text.new
    @cycles        = 0
    @close_server  = false
    @request_lines = []
    @client        = server.accept
  end

  def time
    time = Time.now.strftime('%a, %e %b %Y %H:%M:%S %z').delete(",").split(" ")
    puts "#{time[4]}" + " on " "#{time[0]}" + "day " + "#{time[2]}" + "ember " + "#{time[1]} " + "#{time[3]}"
  end

  def open_server
    loop do
    @cycles += 1
    while line = @client.gets and !line.chomp.empty?
      request_lines << line.chomp
    end
    pre = "<pre>"
    pre_close = "</pre>"
    verb, path, protocol = request_lines[0].split(" ")
    host, ip, port = request_lines[1].split(":")
    accept = request_lines[6]
    response = "#{pre}
    Verb: #{verb}
    Path: #{path}
    Protocol: #{protocol}
    #{host}: #{ip}
    Port: #{port}
    Origin: #{ip}
    #{accept}
    #{pre_close}"
      if path == ""
        output = "<html><head></head><body>#{response}</body></html>"
      elsif path == "/hello"
        output = "<html><head></head><body>Hello World(#{cycles})</body></html>"
      elsif path == "/datetime"
        output = "<html><head></head><body>#{time}</body></html>"
      elsif path == "/shutdown"
        output = "<html><head></head><body>Total Requests: #{cycles}</body></html>"
        @server.close
      end
    text.headers(output)
    text.got_request
    text.ready_request
    @client.puts text.headers(output)
    @client.puts output
    puts "Sending response."
    end
  end
end
