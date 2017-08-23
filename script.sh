# paste the sh traffic in some file and pass the file as argument to this script
# produces a report on the 1 minute rate of pps/mpbs

if [ $# -eq 0 ]; then printf "\n\n missing shtraffic filename.\nUSAGE: script filename\n\n"; exit;fi


PPS=$(cat  $1 | tr '\n' '|' | sed 's/----------------------------------------/\n/' \
 | grep -v Aggr | tr '|' '\n' | egrep "^[^ ].+:$|1 minute input rate" \
 | awk '{print $5}' | egrep [0-9] | tr '\n' '+' | sed 's/\+$//g')

MBPS=$(cat  $1 | tr '\n' '|' | sed 's/----------------------------------------/\n/' \
 | grep -v Aggr | tr '|' '\n' | egrep "^[^ ].+:$|1 minute input rate" \
 | awk '{print $7}' | egrep [0-9] | tr '\n' '+' | sed 's/\+$//g;s/^/scale=6\;(8\/1000000)*(/g;s/$/)/g')


# nameifs stats
printf "\n\n*** NAMEIF stats\n"
cat  $1 | tr '\n' '|' | sed 's/----------------------------------------/\n/' \
 | grep -v Aggr | tr '|' '\n' | egrep "^[^ ].+:$|1 minute input rate"

# physical IFs stats
printf "\n\n*** Physical IFs stats\n"
cat  $1 | tr '\n' '|' | sed 's/----------------------------------------/\n/' \
 | grep  Aggr | tr '|' '\n' | egrep "^[^ ].+:$|1 minute input rate"

# summary

printf "\n\n*** SUMMARY:\n$(echo $PPS | bc) PPS\n\n$(echo $MBPS | bc) Mbps\n\n"
