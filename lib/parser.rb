class Parser
attr_reader :request_line,
            :verb,
            :path,
            :protocol,
            :host,
            :ip,
            :port,
            :value,
            :accept

  def initialize(request_line)
    @request_line           = request_line
    @verb, @path, @protocol = request_line[0].split(" ")
    @host, @ip, @port       = request_line[1].split(":")
    @path, @value           = path.split("?word=")
    @accept                 = request_line[6]
  end
end
