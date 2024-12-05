#!/bin/bash

#######################
######################
###########SCRIPT FROM CLAUDE.AI
JENKINS_URL="http://$1:8080"
USERNAME="shubh"
PASSWORD="shubh"
NEW_TOKEN_NAME="MyNewToken"

# Function to extract crumb
get_jenkins_crumb() {
    # Fetch and store cookies and crumb
    CRUMB=$(curl -s --cookie-jar /tmp/cookies -u "$USERNAME:$PASSWORD" \
        "$JENKINS_URL/crumbIssuer/api/json" | \
        grep -oP '(?<="crumb":")[^"]*')
    
    echo "$CRUMB"
}

# Generate new API token
generate_api_token() {
    local crumb="$1"
    
    response=$(curl -s -X POST \
        --cookie /tmp/cookies \
        "$JENKINS_URL/me/descriptorByName/jenkins.security.ApiTokenProperty/generateNewToken?newTokenName=$NEW_TOKEN_NAME" \
        -H "Jenkins-Crumb:$crumb" \
        -u "$USERNAME:$PASSWORD")
    
    # Extract token from response
    echo "$response" | grep -oP '(?<="tokenValue":")[^"]*'
}

# Main execution
JENKINS_CRUMB=$(get_jenkins_crumb)
if [ -n "$JENKINS_CRUMB" ]; then
    NEW_TOKEN=$(generate_api_token "$JENKINS_CRUMB")
    echo "New API Token: $NEW_TOKEN"
else
    echo "Failed to retrieve Jenkins crumb"
    exit 1
fi

# Clean up temporary cookies
rm -f /tmp/cookies

echo "API token generation completed (check Jenkins logs for details)."
