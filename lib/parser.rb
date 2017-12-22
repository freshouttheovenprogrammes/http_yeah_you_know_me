class Parser
attr_reader :request_line,
            :verb,
            :path,
            :protocol,
            :host,
            :ip,
            :port,
            :value,
            :accept,
            :word_search_param

  def initialize(request_line)
    @request_line           = request_line
    @verb, @path, @protocol = request_line[0].split(" ")
    @host, @ip, @port       = request_line[1].split(":")
    @path, @value           = path.split("?word=")
    @accept                 = request_line[6]
    @word_search_param      = request_line[0].split("?")[1].split("=")[0] unless request_line[0].split[1].split("?")[1].nil?
  end
end
