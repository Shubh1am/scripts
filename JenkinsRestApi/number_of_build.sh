#!/bin/bash

# Replace with your Jenkins URL and authentication credentials
JENKINS_URL="http://13.233.2.248:8080/job/asd/api/json"
JENKINS_USER="shubh"
JENKINS_TOKEN="1146881bbfd641d47f75b41a6e14f0cfa7"

# Use curl to fetch the JSON data
response=$(curl -u "$JENKINS_USER:$JENKINS_TOKEN" "$JENKINS_URL")

# Parse the JSON response to extract the number of builds
num_builds=$(echo "$response" | jq '.builds | length')

echo "Number of builds: $num_builds" 


# Get the latest build number
latest_build_number=$(echo "$response" | jq '.lastBuild.number')

# Get the console output of the latest build
console_output=$(curl -u "$JENKINS_USER:$JENKINS_TOKEN" "http://13.233.2.248:8080/job/asd/$latest_build_number/consoleText")

echo """Console Output of the Latest Build:
##########
##########
##########
#Output_Below:
"""
echo "$console_output"


