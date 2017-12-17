require 'socket'
require_relative 'request_controller'

class Server
  attr_reader

  def initialize
    @request_controller = RequestController.new
  end

  def connect
    until request_controller.close_server
    end
  end
tcp_server = TCPServer.new(9292)
cycles = 0
loop do
  puts cycles
  client = tcp_server.accept
  puts "Ready for a request"
  request_lines = []
  while line = client.gets and !line.chomp.empty?
    request_lines << line.chomp
  end

  puts "Got this request:"
  puts request_lines.inspect

  puts "Sending response."
  verb, path, protocol = request_lines.first.split(" ")
  if path.scan("?").any?
    path, params = path.split("?")
    response = "<pre>" + "verb: " + verb + " params: " + params + " path: " + path + " protocol: " + protocol + "\n\n"+ request_lines.join("\n") + "</pre>"
  else
    response = "<pre>" + "verb: " + verb + " path: " + path + " protocol: " + protocol + "\n\n"+ request_lines.join("\n") + "</pre>"
  end

  cycles += 1
  output = "<html><head></head><body>Hello World(#{cycles})#{response}</body></html>"
  headers = ["http/1.1 200 ok",
            "date: #{Time.now.strftime('%a, %e %b %Y %H:%M:%S %z')}",
            "server: ruby",
            "content-type: text/html; charset=iso-8859-1",
            "content-length: #{output.length}\r\n\r\n"].join("\r\n")
  client.puts headers
  client.puts output

  puts ["Wrote this response:", headers, output].join("\n")
    # set conditional
  puts "\nResponse complete, exiting."
  # client.close
  end
end
