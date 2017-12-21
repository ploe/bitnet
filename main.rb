require 'base64'
require 'optparse'
require 'openssl'
require 'socket'
require 'yaml'

OpenSSL::PKey::RSA::new

class Node

def initialize(config=nil)
end

def create
	puts "Creating new network"
end

def apply

end

def invite

end

def serve
	server = TCPServer.new 7777

	loop do
		client = server.accept
		msg = client.gets(nil)
		job = YAML.load(msg)
		client.puts "job: #{job['tasks']},"

		if job['method'] == "apply" then
			self.apply(job)
		end

		client.close
	end
end

end

opts = {
	:fleet => 'fleet.yml',
}

OptionParser.new do |opt|
	opt.on('-f', '--fleet FLEET', 'Path to the fleet file. Defaults to \'./fleet.yml\'') { |o| 
		opts[:fleet] = o
	}

	opt.on('-j', '--join JOIN', 'Join a federation by attaching to an IP address on the network.') { |o| 
		opts[:join] = o
	}

end.parse!
puts opts.to_s

node = Node.new
node.serve
