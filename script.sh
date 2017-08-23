
#!/bin/bash
# paste the sh traffic | i ^[a-zA-Z]|1 minute input rate
# in shtraffic.txt
# excluding internal interfaces

PPS=$(cat shtraffic.txt | awk '{print $5}' | egrep [0-9] | tr '\n' '+' | sed 's/\+$//g')
MBPS=$(cat  shtraffic.txt | awk '{print $7}' | egrep [0-9] | tr '\n' '+' | sed 's/\+$//g;s/^/scale=6\;(8\/1000000)*(/g;s/$/)/g')

printf "\n$(echo $PPS | bc) PPS\n\n$(echo $MBPS | bc) Mbps\n\n"
