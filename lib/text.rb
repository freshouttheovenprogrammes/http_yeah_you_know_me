require_relative 'request_controller'

module Text

  def self.ready_request
    puts "Ready for a request"
  end

  def self.got_request
    puts "Got this request:"
  end

  def response

  end

  def output

  end

  def self.headers(output)
    ["http/1.1 200 ok",
      "date: #{Time.now.strftime('%a, %e %b %Y %H:%M:%S %z')}",
      "server: ruby",
      "content-type: text/html; charset=iso-8859-1",
      "content-length: #{output.length}\r\n\r\n"].join("\r\n")
  end

end
