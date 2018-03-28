#!/usr/bin/env ruby

require 'json'

def get_hosts()
	return JSON.parse(File.open("hosts.json", "r").read())
end

hosts = get_hosts()

hosts["hosts"].each do |host|
	hostsfile = File.open("hosts", "w")
	hostsfile.write(host[0]+":"+host[1].to_s)
	hostsfile.close
end
