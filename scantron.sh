#!/bin/bash
ip=$(cat -)

#If reading from a file use below lines instead of cat to pipe as above

#while read ip
#do
#  echo "$ip"
#done < "${1:-/dev/stdin}"

nmap $ip 
nmap -vv -sC -sV $ip
nmap -v -Pn -sS --stats-every 3m --max-retries 1 --max-scan-delay 20 -T4 -p - -oA nmap/full-nmap-tcp $ip

searchsploit --nmap nmap/full-nmap-tcp.xml

nikto -h nmap/full-nmap-tcp.gnmap
