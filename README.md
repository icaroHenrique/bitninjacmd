# bitninjacmd
bitninjacmd automation rules

## Introduction
This script has the function of allowing the use of files to indicate the blacklist and whitelist of IPs inside the server, making their addition/removal in bulk.
This helps those who want to undo the *CSF* to use only the Bitninja solution (Recommended by the company itself).

## How use
You need three files that will be used to read the IPs:

bitninjacmd.allow -> For the IPs that will be placed on the Whitelist

bitninjacmd.deny-> For the IPs that will be placed on the Blacklist

bitninjacmd.neutral -> For the IPs that will be placed on the Neutrallist

NOTE: Neutrallist is the list of IPs you want to remove from the Blacklist and Whitelist

Example for files: IPnumber #Comment -> 192.168.0.1 #local IP

## Run script
Follow command:

    sh bitninjacmd.sh




