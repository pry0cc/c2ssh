#!/usr/bin/env ruby
#
require 'rubygems'
require 'json'
require 'sinatra'

set :environment, :production
set :port, 8080

master_key = "a187904d1b0023a4d2fbdcd8483170b5021003"


last_port = get_last_port()

def get_last_port()
	last_port = 0 
	hosts = get_hosts()
	for hosts["hosts"].each do |host|
		if host > last_port
			last_port = host
		end
	end
	return last_port
end

def create_db()
	settings = {"hosts"=>{}}
	f = File.open("hosts.json", "w")
	f.write(JSON.generate(settings))
	f.close
end

def get_hosts()
	return JSON.parse(File.open("hosts.json", "r").read())
end

def add_host(host, port)
	settings = get_hosts()
	settings["hosts"][host] = port
	settingsf = File.open("hosts.json", "w")
	settingsf.write(JSON.generate(settings))
	settingsf.close
end


if File.file?("hosts.json")
	# do nothing
else
	puts "hosts.json doesn't exist, creating it..."
	create_db()
end

get '/' do
	return "<head>404</head>"
end

get '/robots.txt' do
	return "disallow: /admin"
end

get '/admin' do
	return "Sorry bro, I was trolling. There is no admin... Nice try. <!-- STOP TRYNA HACK !-->"
end

get '/api' do
	if params["authkey"]
		if params["authkey"] == master_key
			if params["action"]
				if params["action"] == "add"
					if get_hosts()["hosts"][request.ip]
						return get_hosts()["hosts"][request.ip.to_s].to_s
					else
						add_host(request.ip.to_s, last_port)
						last_port += 1
						return get_hosts()["hosts"][request.ip.to_s].to_s
					end
				end
			end
		else
			return "Authentication denied"
		end
	else
		return "Not Authenenticated"
	end
end

