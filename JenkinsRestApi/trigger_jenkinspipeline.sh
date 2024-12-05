#!/bin/bash

# Replace with your Jenkins URL and authentication credentials
JENKINS_URL="http://13.233.2.248:8080/job/asd/api/json"
JENKINS_USER="shubh"
JENKINS_TOKEN="1146881bbfd641d47f75b41a6e14f0cfa7"


# Prompt the user for input to trigger the build
read -p "Do you want to trigger the build? (yes/no): " trigger_build

if [[ "$trigger_build" == "yes" ]]; then
    # Trigger the build
    curl -X POST -u "$JENKINS_USER:$JENKINS_TOKEN" "$JENKINS_URL"
    sleep 30
    # Get the build number
#    build_number=$(curl -s -u "$JENKINS_USER:$JENKINS_TOKEN" "$JENKINS_URL/lastBuild/number")

    # Get the build console output
#    curl -u "$JENKINS_USER:$JENKINS_TOKEN" "$JENKINS_URL/$build_number/consoleText" | less
else
    echo "Build not triggered."
fi

# Get the build number
build_number=$(curl -s -u "$JENKINS_USER:$JENKINS_TOKEN" "$JENKINS_URL/lastBuild/number")

#Get the Build console Output
#
curl -u "$JENKINS_USER:$JENKINS_TOKEN" "$JENKINS_URL/$build_number/consoleText" | less
#
