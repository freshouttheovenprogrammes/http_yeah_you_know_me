class Headers
  attr_reader :client,
              :headers

  def initialize
    @client = client
    @headers = {}
  end

  def output
    while line = client.gets and !line.chomp.empty?
    "<html><head></head><body>Hello World(#{cycles})#{response}</body></html>"
    end
  end

end
