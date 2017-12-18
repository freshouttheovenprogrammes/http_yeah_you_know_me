class Text

  def ready_request
    puts "Ready for a request"
  end

  def got_request
    puts "Got this request:"
  end


end






# def headers
#   ["http/1.1 200 ok",
#     "date: #{Time.now.strftime('%a, %e %b %Y %H:%M:%S %z')}",
#     "server: ruby",
#     "content-type: text/html; charset=iso-8859-1",
#     "content-length: #{output.length}\r\n\r\n"].join("\r\n")
# end
