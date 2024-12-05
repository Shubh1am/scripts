#!/bin/bash

# Replace with your Jenkins URL and authentication credentials
#!/bin/bash

# Replace with your Jenkins URL and authentication credentials
JENKINS_URL="http://13.233.2.248:8080/job/asd/api/json"
JENKINS_USER="shubh"
JENKINS_TOKEN="1146881bbfd641d47f75b41a6e14f0cfa7"

# Prompt the user for input
echo "Do you want to trigger a new build? (yes/no)"
read trigger_build

if [ "$trigger_build" == "yes" ]; then
  # Trigger a new build
  curl -X POST -u "$JENKINS_USER:$JENKINS_TOKEN" "$JENKINS_URL/build"
  echo "Build triggered successfully."

  # Get the number of the latest build
  response=$(curl -u "$JENKINS_USER:$JENKINS_TOKEN" "$JENKINS_URL")
  num_builds=$(echo "$response" | jq '.lastBuild.number')

  # Get the console output of the latest build
  build_url="$JENKINS_URL/$num_builds/consoleText"
  build_log=$(curl -u "$JENKINS_USER:$JENKINS_TOKEN" "$build_url")
  echo "Latest build console output:"
  echo "$build_log"
else
  # Get the number of the last completed build
  response=$(curl -u "$JENKINS_USER:$JENKINS_TOKEN" "$JENKINS_URL")
  num_builds=$(echo "$response" | jq '.lastCompletedBuild.number')

  # Get the console output of the last completed build
  build_url="$JENKINS_URL/$num_builds/consoleText"
  build_log=$(curl -u "$JENKINS_USER:$JENKINS_TOKEN" "$build_url")
  echo "Last completed build console output:"
  echo "$build_log"
fi
