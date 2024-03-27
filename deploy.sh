#!/bin/bash

# Check if both version and message are provided
if [ "$#" -lt 2 ]; then
    printf "Usage: %s <version> <message>\n" "$0"
    exit 1
fi

# Assign version and message to variables
version="$1"
message="$2"

# Create a git tag with the provided version and message
git tag -a "$version" -m "$message"

# Push the tag along with commits
git push --follow-tags
