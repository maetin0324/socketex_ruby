require 'socket'

addr = ARGV[0] || 'localhost'
port = ARGV[1] || 3000

socket = TCPSocket.new(addr, port)
while true
  input = gets
  puts 'Send: ' + input
  socket.puts(input)
  puts 'Received: ' + socket.gets
end
socket.close