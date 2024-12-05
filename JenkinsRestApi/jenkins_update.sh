#!/bin/bash

# Jenkins API Update Script
# Usage: ./jenkins_update.sh <job_name> <config_xml_path>

# Configuration
JENKINS_URL="http://13.233.2.248:8080/"
USERNAME="shubh"
API_TOKEN="1146881bbfd641d47f75b41a6e14f0cfa7"

# Check if required arguments are provided
if [ $# -ne 2 ]; then
    echo "Usage: $0 <job_name> <config_xml_path>"
    exit 1
fi

JOB_NAME="$1"
CONFIG_FILE="$2"

# Validate config file exists
if [ ! -f "$CONFIG_FILE" ]; then
    echo "Error: Config file $CONFIG_FILE not found"
    exit 1
fi

# Update job configuration via Jenkins REST API
update_job() {
    local job_name="$1"
    local config_file="$2"
    
    # Use curl to update job configuration
    response=$(curl -s -X POST \
        -u "$USERNAME:$API_TOKEN" \
        -H "Content-Type: application/xml" \
        --data-binary "@$config_file" \
        "$JENKINS_URL/job/$job_name/config.xml")
    
    # Check if update was successful
    if [ $? -eq 0 ]; then
        echo "Successfully updated job: $job_name"
    else
        echo "Failed to update job: $job_name"
        exit 1
    fi
}

# Main execution
update_job "$JOB_NAME" "$CONFIG_FILE"

exit 0
