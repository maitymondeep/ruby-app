require 'socket'
require 'logger'

# Create a Logger instance
logger = Logger.new(STDOUT)

server = TCPServer.new('0.0.0.0', 80)

loop {
  client = server.accept

  begin
    request = client.readpartial(2048)
    method, path, version = request.lines[0].split

    puts "Request received: #{method} #{path} #{version}"

    # Log the request details
    logger.info("#{method} #{path} #{version}")

    if path == "/healthcheck"
      logger.info("Health check request received")
      response = "HTTP/1.1 200 OK\r\nContent-Type: text/plain\r\n\r\nOK"
    else
      logger.info("Request received for: #{path}")
      response = "HTTP/1.1 200 OK\r\nContent-Type: text/plain\r\n\r\nWell, hello there!"
    end
    client.write(response)

  rescue EOFError => e
    # Log client disconnection
    logger.error("Client disconnected: #{e.message}")
  rescue StandardError => e
    # Log unexpected errors
    logger.error("Unexpected error: #{e.message}")  
  ensure
    client.close
  end
}
