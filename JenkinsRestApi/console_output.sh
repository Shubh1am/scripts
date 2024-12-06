#!/bin/bash

# Configuration variables
JENKINS_URL="http://15.206.165.241:8080"  # Replace with your Jenkins URL
JOB_NAME="Taskmaster"               # Replace with your Jenkins job name
USERNAME="shubh"               # Replace with your Jenkins username
API_TOKEN="$1"             # Replace with your Jenkins API token

# Fetch the number of builds
echo "Fetching builds for job: $JOB_NAME..."
BUILD_INFO=$(curl -s -u "$USERNAME:$API_TOKEN" "$JENKINS_URL/job/$JOB_NAME/api/json?tree=builds[number,status]")

if [[ $? -ne 0 ]]; then
    echo "Failed to fetch build information. Please check your Jenkins URL, credentials, or network."
    exit 1
fi

# Parse and count the builds
NUM_BUILDS=$(echo "$BUILD_INFO" | jq '.builds | length')
echo "Total number of builds: $NUM_BUILDS"

# Check for active builds
ACTIVE_BUILD=$(echo "$BUILD_INFO" | jq '.builds[] | select(.status == "IN_PROGRESS") | .number')

if [[ -n "$ACTIVE_BUILD" ]]; then
    echo "Active build found: Build #$ACTIVE_BUILD"
    echo "Fetching console output for Build #$ACTIVE_BUILD..."
    
    CONSOLE_OUTPUT=$(curl -s -u "$USERNAME:$API_TOKEN" "$JENKINS_URL/job/$JOB_NAME/$ACTIVE_BUILD/consoleText")
    
    if [[ $? -ne 0 ]]; then
        echo "Failed to fetch console output. Please check your Jenkins URL, credentials, or network."
        exit 1
    fi

    echo "Console Output for Build #$ACTIVE_BUILD:"
    echo "---------------------------------------"
    echo "$CONSOLE_OUTPUT"
else
    echo "No active builds found."
fi
