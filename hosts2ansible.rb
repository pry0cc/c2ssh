#!/usr/bin/env ruby

require 'json'

def get_hosts()
	return JSON.parse(File.open("hosts.json", "r").read())
end

hosts = get_hosts()

hostsfile = File.open("hosts", "w")
hosts["hosts"].each do |host|
	hostsfile.write(host[0]+":"+host[1].to_s+"\n")
end
hostsfile.close
