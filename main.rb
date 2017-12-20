require 'base64'
require 'openssl'
require 'socket'
require 'yaml'

OpenSSL::PKey::RSA::new

server = TCPServer.new 7777

loop do
	client = server.accept
	msg = client.gets(nil)
	job = YAML.load(msg)

	client.puts "job: #{job['tasks']},"

	client.close
end
