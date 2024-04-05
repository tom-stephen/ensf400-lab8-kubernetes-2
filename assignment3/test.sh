#!/bin/bash

# Initialize counters
app1_count=0
app2_count=0

# Perform 100 requests
for ((i=1; i<=100; i++)); do
    # Make a curl request and extract the app name from the response
    response=$(curl -s http://192.168.58.2)
    app_name=$(echo "$response" | grep -oP '\[app-[12]-dep-[^\]]+\]' | sed 's/\[\(.*\)\]/\1/')

    # Increment the counter based on the app name
    case "$app_name" in
        "app-1-dep-"*)
            ((app1_count++))
            ;;
        "app-2-dep-"*)
            ((app2_count++))
            ;;
        *)
            echo "Unknown app name: $app_name"
            ;;
    esac
done

# Calculate percentages
total=$((app1_count + app2_count))
percent_app1=$((100 * app1_count / total))
percent_app2=$((100 * app2_count / total))

# Print results
echo "Percentage of responses from App 1: $percent_app1%"
echo "Percentage of responses from App 2: $percent_app2%"