require_relative 'text'

class RequestController
  attr_reader :server,
              :text,
              :cycles,
              :close_server,
              :request_lines,
              :client

  def initialize
    @server        = TCPServer.new(9292)
    @text          = Text.new
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
        require "pry"; binding.pry
        output = "<html><head></head><body>#{time}</body></html>"
      end
    text.headers(output)
    text.got_request
    text.ready_request
    @client.puts text.headers(output)
    @client.puts output # this is needed...why?
    puts "Sending response."
      @cycles += 1
    end
  end
  #
  # def root
  #   if something == "/"
  #     do a thing
  #   end
  # end
  #
  # def root
  #   if something == "/"
  #     do a thing
  #   end
  # end
  #
  # def root
  #   if something == "/"
  #     do a thing
  #   end
  # end
  #
  # def root
  #   if something == "/"
  #     do a thing
  #   end
  # end
  #
  # def formatter(lines)
  #   lines.map do |line|
  # end
  #
  # def close_server
  #   server.close
  # end

end












# if path.scan("?").any?
#   path, params = path.split("?")
#   response = "<pre>" + "verb: " + verb + " params: " + params + " path: " + path + " protocol: " + protocol + "\n\n"+ request_lines.join("\n") + "</pre>"
# else
#   response = "<pre>" + "verb: " + verb + " path: " + path + " protocol: " + protocol + "\n\n"+ request_lines.join("\n") + "</pre>"
# end
