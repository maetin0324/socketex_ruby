require 'socket'
require 'thread'

socket = Socket.new(:INET, :STREAM)
socket.setsockopt(Socket::SOL_SOCKET, Socket::SO_REUSEADDR, true)
socket.bind(Addrinfo.tcp("localhost", 3000))
socket.listen(5)

puts 'Listening on port 3000'

while true
  Thread.start(socket.accept) do |connection, _|
    puts 'Connection accepted from ' + connection.remote_address.ip_address
    begin
      while true
        buf = connection.readpartial(4096)
        puts 'Received: ' + buf
        connection.puts(buf)
      end
    rescue EOFError
      puts 'Connection closed by ' + connection.remote_address.ip_address
    rescue Exception => e
      puts e.message
    end

    connection.close
  end
end
socket.close