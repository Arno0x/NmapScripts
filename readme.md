Nmap Scripts
============

Author: Arno0x0x - [@Arno0x0x](http://twitter.com/Arno0x0x)

This repository aims at publishing some of my Nmap scripts.

Nmap comes with a LUA Script Engine along with some useful libraries that allows creation of scripts in the LUA langage. These scripts extend the capabilities of the Nmap scanner.

cisco-voip-phone-number
----------------
This script obtains the phone number, aka extension, of a Cisco VoIP phone by parsing information published on the phone's built-in web interface.

Running this script implies the scanner has access to the VoIP network.

This script queries a model specific URL and parses the response body using pattern matching, to obtain the phone number corresponding to the host being scanned.