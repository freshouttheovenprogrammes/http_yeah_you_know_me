class Parser
attr_reader :request_line,
            :verb,
            :path,
            :protocol,
            :host,
            :ip,
            :port,
            :accept,
            :value

  def initialize(request_line)
    @request_line           = request_line
    @verb, @path, @protocol = request_line[0].split(" ")
    require "pry"; binding.pry
    @host, @ip, @port       = request_line[1].split(":")
    @accept                 = request_line[6]
    @path, @value           = path.split("?word=")
    @cache                  = request_line[3].split[1]
  end
end
