class Request
  attr_reader :verb,
              :path,
              :protocol,
              :host,
              :ip,
              :port,
              :accept,
              :value,
              :word

  def initialize(request_line)
    @verb, @path, @protocol = request_line[0].split(" ")
    @host, @ip, @port = request_line[1].split(":")
    @accept = request_line[6]
    @value  = @path.split("=")[1]
  end

end
