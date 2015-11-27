local shortport = require "shortport"
local http = require "http"
local stdnse = require "stdnse"

description = [[
Obtains the phone number, aka extension, of a Cisco VoIP phone by parsing information
published on the phone's built-in web interface.

Running this script implies the scanner has access to the VoIP network.

This script queries a model specific URL and parses the response body
using pattern matching, to obtain the phone number corresponding to the host
being scanned.
]]

---
-- @usage
-- nmap --script cisco-voip-phone-number <host/ip>
--
-- @output
-- PORT   STATE SERVICE
-- 80/tcp open  http
-- | cisco-voip-phone-number: 85670
--

author = "Arno0x0x - https://twitter.com/Arno0x0x"
license = "Same as Nmap--See https://nmap.org/book/man-legal.html"
categories = {"discovery","safe"}

-- The Rule Section --
portrule = shortport.http

local CISCO_MODELS_URI = {
  ["794x"] = "/DeviceInformation"
}

local CISCO_MODELS_PATTERN = {
  ["794x"] = "NR.-<B>([^<]-)</B>"
}

-- The Action Section --

action = function(host, port)
    
	for model,uri in pairs(CISCO_MODELS_URI) do
	
		local response = http.get(host, port, uri)

		if ( response.status == 200 ) then
			local title = string.match(response.body, CISCO_MODELS_PATTERN[model])
			return title
		else
			break
		end
	end
end