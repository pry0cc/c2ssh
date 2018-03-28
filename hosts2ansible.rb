#!/usr/bin/env ruby

require 'json'

def get_hosts()
	return JSON.parse(File.open("hosts.json", "r").read())
end

hosts = get_hosts()

hostsfile = File.open("ssh_config", "w")
hosts["hosts"].each do |host|
	hostsfile.write("Host " + host[0]+"\n")
	hostsfile.write("    Hostname 127.0.0.1\n")
	hostsfile.write("    Port " + host[1].to_s+"\n")
	hostsfile.write("    User root\n\n")
end
hostsfile.close

anshosts = File.open("hosts", "w")
hosts["hosts"].each do |host|
	anshosts.write(host[0]+"\n")
end
anshosts.close
